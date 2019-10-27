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

        self.formatted_image = self.format_image(image_file)
        self.scantron_bubbles = self.get_scantron_bubbles()

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
        paper = four_point_transform(image, docCnt.reshape(4, 2))
        warped = four_point_transform(gray, docCnt.reshape(4, 2))

        # self.warped = warped
        # self.formatted_image = warped
        return warped

    def get_scantron_bubbles(self):
        # apply Otsu's thresholding method to binarize the warped
        # piece of paper
        self.thresh = cv2.threshold(self.formatted_image, 0, 255,
                                    cv2.THRESH_BINARY_INV | cv2.THRESH_OTSU)[1]

        # find contours in the thresholded image, then initialize
        # the list of contours that correspond to questions
        cnts = cv2.findContours(self.thresh.copy(), cv2.RETR_EXTERNAL,
                                cv2.CHAIN_APPROX_SIMPLE)
        cnts = imutils.grab_contours(cnts)
        questionCnts = []

        # loop over the contours
        for c in cnts:
                # compute the bounding box of the contour, then use the
                # bounding box to derive the aspect ratio
            (x, y, w, h) = cv2.boundingRect(c)
            ar = w / float(h)

            # in order to label the contour as a question, region
            # should be sufficiently wide, sufficiently tall, and
            # have an aspect ratio approximately equal to 1
            if w >= 20 and h >= 20 and ar >= 0.9 and ar <= 1.1:
                questionCnts.append(c)

        # sort the question contours top-to-bottom, then initialize
        # the total number of correct answers
        questionCnts = contours.sort_contours(questionCnts,
                                              method="top-to-bottom")[0]

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

        # image_path = os.path.join(os.getcwd(), 'scantron_images', 'test_01.jpg')
        # image = cv2.imread(image_path)
