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

        self.formatted_image = self.format_image(image_file)
        self.cnts = self.get_contours()
        self.scantron_questions = self.get_scantron_questions()
        self.student_id_bubbles = self.get_student_id()

        i = 0
        for c in self.scantron_questions:
            cv2.drawContours(
                self.paper, [c], -1, self.colors[i % len(self.colors)], -1)

            i += 1

        i = 0
        for c in self.student_id_bubbles:
            cv2.drawContours(
                self.paper, [c], -1, self.colors[i % len(self.colors)], -1)

            i += 1

        cv2.imshow('image', self.paper)
        cv2.waitKey(0)
        cv2.destroyAllWindows()

    def format_image(self, image_file):
        image_path = os.path.join(
            os.getcwd(), 'scantron_images', 'Bubble_Sheet.jpg')
        image = cv2.imread(image_path)
        gray = cv2.cvtColor(image, cv2.COLOR_BGR2GRAY)
        blurred = cv2.GaussianBlur(gray, (5, 5), 0)
        edged = cv2.Canny(blurred, 75, 200)

        # find contours in the edge map, then initialize
        # the contour that corresponds to the document
        cnts = cv2.findContours(edged.copy(), cv2.RETR_EXTERNAL,
                                cv2.CHAIN_APPROX_SIMPLE)
        cnts = imutils.grab_contours(cnts)
        docCnt = None

        # ensure that at least one contour was found
        if len(cnts) > 0:
            # sort the contours according to their size in
            # descending order
            cnts = sorted(cnts, key=cv2.contourArea, reverse=True)

            # loop over the sorted contours
            for c in cnts:
                # approximate the contour
                peri = cv2.arcLength(c, True)
                approx = cv2.approxPolyDP(c, 0.02 * peri, True)

                # if our approximated contour has four points,
                # then we can assume we have found the paper
                if len(approx) == 4:
                    docCnt = approx
                    break

        # apply a four point perspective transform to both the
        # original image and grayscale image to obtain a top-down
        # birds eye view of the paper
        self.paper = four_point_transform(image, docCnt.reshape(4, 2))
        warped = four_point_transform(gray, docCnt.reshape(4, 2))

        # self.warped = warped
        # self.formatted_image = warped
        return warped

    def get_contours(self):
        # apply Otsu's thresholding method to binarize the warped
        # piece of paper
        self.thresh = cv2.threshold(self.formatted_image, 0, 255,
                                    cv2.THRESH_BINARY_INV | cv2.THRESH_OTSU)[1]

        # find contours in the thresholded image, then initialize
        # the list of contours that correspond to questions
        cnts, heirarchy = cv2.findContours(self.thresh.copy(), cv2.RETR_LIST,
                                           cv2.CHAIN_APPROX_SIMPLE)

        return cnts

    def get_scantron_questions(self):
        columns = self.get_columns()

        scantron_questions = []

        # loop through the columns in the scantron and
        # find their respective bubbles
        for col in columns:
            col_bubbles = self.get_scantron_bubbles(col)

            # sort the bubbles from top to bottom
            col_bubbles = contours.sort_contours(col_bubbles,
                                                 method="top-to-bottom")[0]

            # iterate through every other 5 contours to get rid of the extra bubble-border
            # this is to fix the problem with cv2.RETR_EXTERNAL
            for ind, c in enumerate(range(0, len(col_bubbles), 5)):
                if ind % 2 == 1:
                    continue
                scantron_questions.extend(col_bubbles[c:c+5])

        return scantron_questions

    def get_student_id(self):

        student_id_box = None
        for c in self.cnts:
            # compute the bounding box of the contour, then use the
            # bounding box to derive the aspect ratio
            (x, y, w, h) = cv2.boundingRect(c)
            ar = w / float(h)

            # check to see if it is the student_id box
            if ar > 1.2 and h > 50 and x > 100:
                student_id_box = c

        id_box_bubbles = self.get_scantron_bubbles(student_id_box)

        id_box_bubbles = contours.sort_contours(id_box_bubbles,
                                                method="left-to-right")[0]

        # remove the extra bubble-border
        # this is to fix the problem with cv2.RETR_EXTERNAL
        student_id_bubbles = [c for c in id_box_bubbles if cv2.boundingRect(c)[
            2] > 45]

        return student_id_bubbles

    def get_columns(self):

        colCnts = []

        for c in self.cnts:
            # compute the bounding box of the contour, then use the
            # bounding box to derive the aspect ratio
            (x, y, w, h) = cv2.boundingRect(c)
            ar = w / float(h)

            # check to see if it is a column
            if ar < .5 and h > 50:
                colCnts.append(c)

        # sort the contours from left to right
        colCnts = contours.sort_contours(colCnts,
                                         method="left-to-right")[0]

        # find and remove the extraneous contours
        extrColCnts = set()
        for i in range(len(colCnts)):
            if i == 0:
                continue

            x_prev = cv2.boundingRect(colCnts[i-1])[0]
            x_cur = cv2.boundingRect(colCnts[i])[0]

            if abs(x_prev - x_cur) < 10:
                extrColCnts.add(i)

        colCnts = [c for i, c in enumerate(colCnts) if i not in extrColCnts]

        return colCnts

    def get_scantron_bubbles(self, bounding_box):

        questionCnts = []

        (box_x, box_y, box_w, box_h) = cv2.boundingRect(bounding_box)

        left_bound = box_x
        right_bound = box_x + box_w

        # loop over the contours
        for c in self.cnts:
            # compute the bounding box of the contour, then use the
            # bounding box to derive the aspect ratio
            (x, y, w, h) = cv2.boundingRect(c)
            ar = w / float(h)

            # in order to label the contour as a question, region
            # should be sufficiently wide, sufficiently tall, and
            # have an aspect ratio approximately equal to 1
            if w >= 20 and h >= 20 and ar >= 0.9 and ar <= 1.1:

                if x > left_bound and x+w < right_bound:
                    questionCnts.append(c)
                    # cv2.drawContours(self.paper, [c], -1, (0, 255, 0), -1)

        return questionCnts

    def grade_test(self, key):

        # convert key to array of integers
        key = [int(a) for a in key]

        correct = 0
        ANSWERS = []

        # each question has 5 possible answers, to loop over the
        # question in batches of 5
        for (q, i) in enumerate(np.arange(0, len(self.scantron_bubbles), 5)):
            # sort the contours for the current question from
            # left to right, then initialize the index of the
            # bubbled answer
            cnts = contours.sort_contours(self.scantron_bubbles[i:i + 5])[0]
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

            ANSWERS.append(bubbled[1])

        result = {}
        bubbled = []
        for index, (submitted, correct) in enumerate(zip(ANSWERS, key)):
            result[index] = submitted == correct
            bubbled.append(submitted)

        return {'result': result, 'bubbled': bubbled}


s = ScannerService("")
