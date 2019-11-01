# import the necessary packages
from imutils import contours
from imutils.perspective import four_point_transform
import numpy as np
import argparse
import imutils
import cv2
import os


class ScannerService:

    def __init__(self, image_file):
        self.scantron = self.get_scantron(image_file)
        self.columnCnts = self.get_column_contours()
        self.submitted_answers = self.get_submitted_answers()

    def get_scantron(self, image_file):

        # read image file string data
        filestr = image_file.read()
        # convert string data to numpy array
        npimg = np.fromstring(filestr, np.uint8)
        # convert numpy array to image
        image = cv2.imdecode(npimg, cv2.IMREAD_COLOR)

        # grayscale the image
        gray = cv2.cvtColor(image, cv2.COLOR_BGR2GRAY)

        # apply Otsu's thresholding method to binarize the warped
        # piece of paper
        self.thresh = cv2.threshold(gray, 0, 255,
                                    cv2.THRESH_BINARY_INV | cv2.THRESH_OTSU)[1]

        # dilate the image
        # this will make the lines more prominent and remove
        # imperfections in the contours
        kernel = np.ones((2, 2), np.uint8)
        dilated = cv2.dilate(self.thresh, kernel, iterations=3)

        # find contours in the thresholded image
        cnts, heirarchy = cv2.findContours(dilated.copy(), cv2.RETR_LIST,
                                           cv2.CHAIN_APPROX_SIMPLE)

        # TODO add if statement to check if at least one contour is found
        # sort the contours according to their size in
        # descending order
        cnts = sorted(cnts, key=cv2.contourArea, reverse=True)

        # initialize scantronCnt
        scantronCnt = None

        # loop over the sorted contours
        for c in cnts:

            # compute the bounding box of the contour, then use the
            # bounding box to derive the aspect ratio
            (x, y, w, h) = cv2.boundingRect(c)
            ar = w / float(h)

            # approximate the contour
            epsilon = 0.1*cv2.arcLength(c, True)
            approx = cv2.approxPolyDP(c, epsilon, True)

            # initialize scantronCnt just incase no better contour is found
            if x > 0 and scantronCnt is None:
                scantronCnt = approx

            # if our approximated contour has four points
            # and if it matches the aspect ratio we are looking for
            # then we can assume we have found the scantron rectangle
            if len(approx) == 4 and ar > 1.8 and ar < 2.2 and h > 100:
                scantronCnt = approx
                break

        # apply a four point perspective transform to both the
        # original image and threshold to obtain a top-down
        # birds eye view of the scantron
        self.scantron_color = four_point_transform(
            image, scantronCnt.reshape(4, 2))
        scantron = four_point_transform(self.thresh, scantronCnt.reshape(4, 2))

        return scantron

    def get_column_contours(self):

        # dilate the scantron
        # this will make the lines more prominent and remove
        # imperfections in the contours
        kernel = np.ones((1, 1), np.uint8)
        dilated = cv2.dilate(self.scantron, kernel, iterations=3)

        # find contours in the dilated scantron
        cnts, heirarchy = cv2.findContours(dilated.copy(), cv2.RETR_EXTERNAL,
                                           cv2.CHAIN_APPROX_SIMPLE)

        colCnts = []

        for c in cnts:
            # compute the bounding box of the contour, then use the
            # bounding box to derive the aspect ratio
            (x, y, w, h) = cv2.boundingRect(c)
            ar = w / float(h)

            epsilon = 0.1*cv2.arcLength(c, True)
            approx = cv2.approxPolyDP(c, epsilon, True)

            # if our approximated contour has four points
            # and if it matches the aspect ratio we are looking for
            # then we can assume we have found a column
            if len(approx) == 4 and ar < .6:
                colCnts.append(approx)

        # sort the contours from left to right
        colCnts = contours.sort_contours(colCnts,
                                         method="left-to-right")[0]

        return colCnts

    def get_bubbles(self, boundingBox):

        # dilate the bubbles in the column
        # this will make the lines more prominent and remove
        # imperfections in the contours
        kernel = np.ones((2, 2), np.uint8)
        dilated = cv2.dilate(boundingBox, kernel, iterations=2)

        labels = cv2.connectedComponentsWithStats(dilated)[1]
        np.zeros((dilated.shape[0], dilated.shape[1], 3), np.uint8)

        foundCnts = []
        for i in range(0, labels.max()+1):
            mask = cv2.compare(labels, i, cv2.CMP_EQ)

            cnts, _ = cv2.findContours(
                mask, cv2.RETR_EXTERNAL, cv2.CHAIN_APPROX_SIMPLE)

            for c in cnts:
                # compute the bounding box of the contour, then use the
                # bounding box to derive the aspect ratio
                (x, y, w, h) = cv2.boundingRect(c)
                ar = w / float(h)

                # check if aspect ration of bubbles
                # are within acceptable range
                if ar >= 0.8 and ar <= 1.2:
                    foundCnts.append(c)

        foundCnts = sorted(foundCnts, key=cv2.contourArea, reverse=True)

        scantronCnts = []

        # initialize the width that is expected of a santron bubble
        expectedWidth = None
        for c in foundCnts:

            (x, y, w, h) = cv2.boundingRect(c)
            ar = w / float(h)

            # initialize the width that is expected of a santron bubble
            if expectedWidth == None:
                expectedWidth = w

            # if the current width is out of the accepted range then
            # do not add to scantron contours
            if abs(w - expectedWidth) > 4:
                continue

            scantronCnts.append(c)

        return scantronCnts

    def get_submitted_answers(self):

        submitted_answers = []

        # loop through the columns in the scantron and
        # find their respective bubbles
        for col in self.columnCnts:
            # apply a four point perspective transform to both the
            # original scantron and threshold to obtain a top-down
            # birds eye view of the column
            cur_col = four_point_transform(self.scantron, col.reshape(4, 2))
            self.cur_col_color = four_point_transform(
                self.scantron_color, col.reshape(4, 2))

            # detect the bubbles for the respective column
            col_bubbles = self.get_bubbles(cur_col)

            # sort the bubbles from top to bottom
            col_bubbles = contours.sort_contours(col_bubbles,
                                                 method="top-to-bottom")[0]

            # go through the bubbles 5 at a time
            # row by row
            for i in range(0, len(col_bubbles), 5):

                # sort the bubbles in the row from left to right
                row = contours.sort_contours(
                    col_bubbles[i:i + 5], method="left-to-right")[0]
                bubbled = None

                # loop over the sorted bubbles
                for (j, c) in enumerate(row):
                    # construct a mask that reveals only the current
                    # "bubble" for the question
                    mask = np.zeros(cur_col.shape, dtype="uint8")
                    cv2.drawContours(mask, [c], -1, 255, -1)

                    # apply the mask to the thresholded image, then
                    # count the number of non-zero pixels in the
                    # bubble area
                    mask = cv2.bitwise_and(cur_col, cur_col, mask=mask)
                    total = cv2.countNonZero(mask)

                    # if the current total has a larger number of total
                    # non-zero pixels, then we are examining the currently
                    # bubbled-in answer
                    if bubbled is None or total > bubbled[0]:
                        bubbled = (total, j)

                submitted_answers.append(bubbled[1])

        return submitted_answers

    def grade_test(self, key):

        # convert key to array of integers
        key = [int(a) for a in key]

        correct = 0
        result = {}

        for index, (s, k) in enumerate(zip(self.submitted_answers, key)):
            result[index] = s == k

        return result, {i: s for i, s in enumerate(self.submitted_answers)}

    def get_student_id(self, id_len):

        # find contours in the dilated scantron
        cnts, heirarchy = cv2.findContours(self.scantron.copy(), cv2.RETR_EXTERNAL,
                                           cv2.CHAIN_APPROX_SIMPLE)

        # cnts = sorted(cnts, key=cv2.contourArea, reverse=True)
        cnts = contours.sort_contours(
            cnts, method="right-to-left")[0]

        # colCnts = []
        student_id_box = None

        for i, c in enumerate(cnts):
            # compute the bounding box of the contour, then use the
            # bounding box to derive the aspect ratio
            (x, y, w, h) = cv2.boundingRect(c)
            ar = w / float(h)

            epsilon = 0.1*cv2.arcLength(c, True)
            approx = cv2.approxPolyDP(c, epsilon, True)

            # if our approximated contour has four points
            # and if it matches the aspect ratio we are looking for
            # then we can assume we have found the student id box
            if ar > 1.0 and ar <= 1.5:
                student_id_box = approx
                break

        student_id_box_formatted = four_point_transform(
            self.scantron, student_id_box.reshape(4, 2))
        student_id_box_formatted_color = four_point_transform(
            self.scantron_color, student_id_box.reshape(4, 2))

        id_box_bubbles = self.get_bubbles(student_id_box_formatted)

        # sort the bubbles from left to right
        id_box_bubbles = contours.sort_contours(id_box_bubbles,
                                                method="left-to-right")[0]

        student_id = []
        # each digit has a possible 10 values, to loop over the
        # thing in batches of 10
        for (q, i) in enumerate(np.arange(0, len(id_box_bubbles), 10)):
            # sort the contours for the current question from
            # top to bottom, then initialize the index of the
            # bubbled answer
            cnts = contours.sort_contours(
                id_box_bubbles[i:i + 10], method="top-to-bottom")[0]
            bubbled = None
            # loop over the sorted contours
            for (j, c) in enumerate(cnts):
                # construct a mask that reveals only the current
                # "bubble" for the question
                mask = np.zeros(student_id_box_formatted.shape, dtype="uint8")
                cv2.drawContours(mask, [c], -1, 255, -1)

                # apply the mask to the thresholded image, then
                # count the number of non-zero pixels in the
                # bubble area
                mask = cv2.bitwise_and(
                    student_id_box_formatted, student_id_box_formatted, mask=mask)
                total = cv2.countNonZero(mask)

                # if the current total has a larger number of total
                # non-zero pixels, then we are examining the currently
                # bubbled-in answer
                if bubbled is None or total > bubbled[0]:
                    bubbled = (total, j, c)

            student_id.append(bubbled[1])

        return ''.join([str(s) for s in student_id[:id_len]])
