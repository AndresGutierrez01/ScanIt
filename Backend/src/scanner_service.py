# import the necessary packages
from imutils import contours
from imutils.perspective import four_point_transform
import numpy as np
import argparse
import imutils
import cv2
import os


class ScannerService:

    purple = (133, 29, 219)
    green = (115, 219, 29)
    red = (255, 0, 0)
    pink = (255, 137, 196)
    orange = (255, 126, 30)

    colors = [purple, green,
              red, pink, orange]

    def __init__(self, image_file):
        self.scantron = self.get_scantron()
        self.columnCnts = self.get_column_contours()
        self.submitted_answers = self.get_submitted_answers()
        result = self.grade_test([0, 1, 2, 3, 4, 0, 1, 2, 3, 4, 0,
                                  1, 2, 3, 4, 0, 1, 2, 3, 4])

        print(result)

    def get_scantron(self):

        image_path = os.path.join(
            os.getcwd(), 'scantron_images', 'Bubble_Sheet_pic_17.jpg')
        image = cv2.imread(image_path)

        cv2.imshow('image', image)
        cv2.waitKey(0)
        cv2.destroyAllWindows()

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
                cv2.drawContours(image, [c], -1, self.colors[0], 3)
                scantronCnt = approx
                break

        cv2.imshow('image', image)
        cv2.waitKey(0)
        cv2.destroyAllWindows()
        # apply a four point perspective transform to both the
        # original image and threshold to obtain a top-down
        # birds eye view of the scantron
        self.scantron_color = four_point_transform(
            image, scantronCnt.reshape(4, 2))
        scantron = four_point_transform(self.thresh, scantronCnt.reshape(4, 2))

        cv2.imshow('image', self.scantron_color)
        cv2.waitKey(0)
        cv2.destroyAllWindows()

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
                cv2.drawContours(self.scantron_color, [
                                 c], -1, self.colors[1], 3)
                colCnts.append(approx)

        # sort the contours from left to right
        colCnts = contours.sort_contours(colCnts,
                                         method="left-to-right")[0]

        cv2.imshow('image', self.scantron_color)
        cv2.waitKey(0)
        cv2.destroyAllWindows()

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
            cur_col_color = four_point_transform(
                self.scantron_color, col.reshape(4, 2))

            # detect the bubbles for the respective column
            col_bubbles = self.get_bubbles(cur_col)

            # sort the bubbles from top to bottom
            col_bubbles = contours.sort_contours(col_bubbles,
                                                 method="top-to-bottom")[0]

            cv2.imshow('image', cur_col_color)
            cv2.waitKey(0)
            cv2.destroyAllWindows()

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
                        bubbled = (total, j, c)

                cv2.drawContours(
                    cur_col_color, [bubbled[2]], -1, self.colors[2], 3)
                cv2.imshow('image', cur_col_color)
                cv2.waitKey(0)
                cv2.destroyAllWindows()

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

        student_id_box = None
        for c in self.cnts:
            # compute the bounding box of the contour, then use the
            # bounding box to derive the aspect ratio
            (x, y, w, h) = cv2.boundingRect(c)
            ar = w / float(h)

            # check to see if it is the student_id box
            if ar > 1.2 and h > 50 and x > 100:
                student_id_box = c

        id_box_bubbles = self.get_bubbles(student_id_box)

        id_box_bubbles = contours.sort_contours(id_box_bubbles,
                                                method="left-to-right")[0]

        # remove the extra inner-bubble
        # this is to fix the problem with cv2.RETR_EXTERNAL
        student_id_bubbles = [c for c in id_box_bubbles if cv2.boundingRect(c)[
            2] > 45]

        student_id = []
        # each digit has a possible 10 values, to loop over the
        # thing in batches of 10
        for (q, i) in enumerate(np.arange(0, len(student_id_bubbles), 10)):
            # sort the contours for the current question from
            # top to bottom, then initialize the index of the
            # bubbled answer
            cnts = contours.sort_contours(
                student_id_bubbles[i:i + 10], method="top-to-bottom")[0]
            bubbled = None
            # loop over the sorted contours
            for (j, c) in enumerate(cnts):
                # construct a mask that reveals only the current
                # "bubble" for the question
                mask = np.zeros(self.thresh.shape, dtype="uint8")
                cv2.drawContours(mask, [c], -1, 255, -1)

                # apply the mask to the thresholded image, then
                # count the number of non-zero pixels in the
                # bubble area
                mask = cv2.bitwise_and(self.thresh, self.thresh, mask=mask)
                total = cv2.countNonZero(mask)

                # if the current total has a larger number of total
                # non-zero pixels, then we are examining the currently
                # bubbled-in answer
                if bubbled is None or total > bubbled[0]:
                    bubbled = (total, j)

            student_id.append(bubbled[1])

        return ''.join([str(s) for s in student_id[:id_len]])


ScannerService('')
