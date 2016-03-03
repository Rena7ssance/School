"""Project 3: Tracking.

In this project, you'll track objects in videos.
"""

import cv2
import cv2.cv as cv
import math
import numpy as np


class Pedestrian:
    """Stores the state of a kalman filter model"""

    def __init__(self, init_state):
        """ Initializes the state.

        Model:
          State modeled as x, y, w, h, vx, vy, ax, ay
          Measurements = x, y, w, h

        Arguments:
          init_state: A 4-vector containing the initial x, y, w, h
        """

        self.kalman = cv.CreateKalman(8, 4, 0)
        self.prev_state = init_state
        self.timer = 20      # Number of frames missing before removal
        self.time_alive = 0  # Remove pedestrian if not alive 4 consec. frames

        self.setMatrix(self.kalman.transition_matrix,
                       [[1, 0, 0, 0, 0, 1, 0.5, 0],  # x = x + vx + 0.5ax
                        [0, 1, 0, 0, 0, 0, 1, 0.5],  # y = y + vy + 0.5ay
                        [0, 0, 1, 0, 0, 0, 0, 0],    # w = w
                        [0, 0, 0, 1, 0, 0, 0, 0],    # h = h
                        [0, 0, 0, 0, 1, 0, 1, 0],    # vx = vx + ax
                        [0, 0, 0, 0, 0, 1, 0, 1],    # vy = vy + ay
                        [0, 0, 0, 0, 0, 0, 1, 0],    # ax = ax
                        [0, 0, 0, 0, 0, 0, 0, 1]])   # ay = ay

        for i in xrange(4):
            # Set XY, WH to be our measurements.
            self.kalman.measurement_matrix[i, i] = 1

            # Set initial state
            self.kalman.state_post[i, 0] = init_state[i]

        # Set noisy constraints
        cv.SetIdentity(self.kalman.process_noise_cov, cv.RealScalar(1e-5))
        cv.SetIdentity(self.kalman.measurement_noise_cov, cv.RealScalar(1e-1))
        cv.SetIdentity(self.kalman.error_cov_post, cv.RealScalar(1.0))

    def setMatrix(self, mat, newMat):
        for r, row in enumerate(newMat):
            for c, val in enumerate(row):
                mat[r, c] = val

    def update(self):
        """ Updates the kalman model. """

        prediction = cv.KalmanPredict(self.kalman)

        # In practice, prev_state will usually be updated with
        # the new measurement for that period.
        cvMeasure = cv.CreateMat(4, 1, cv.CV_32FC1)
        for i in xrange(4):
            cvMeasure[i, 0] = self.prev_state[i]

        estimate = cv.KalmanCorrect(self.kalman, cvMeasure)

        process_noise = self.kalman.process_noise_cov * np.random.randn(8, 1)
        state = np.dot(self.kalman.transition_matrix, estimate) + process_noise

        # Store the final estimated state for the current frame
        for i in xrange(8):
            self.kalman.state_post[i, 0] = state[i, 0]


def thresholdDetect(gframes):
    """ Detect objects in non-noisy scenarios using thresholding and naive
        foreground bound detection.

    Arguments:
      gframes: An array of gray-scale images comprising a non-noisy video.

    Returns:
      a list of (min_x, min_y, max_x, max_y) four-tuples containing the pixel
      coordinates of the rectangular bounding box of the ball in each frame.
    """

    bounds = []
    check_all = True

    for gimg in gframes:
        _, thresh = cv2.threshold(gimg, 10, 255, cv2.THRESH_BINARY)

        # Define window to check for object
        window_x = window_y = 0
        if check_all:
            window_x = range(len(thresh[0]))
            window_y = range(len(thresh))
        else:
            limit_x = min(len(thresh[0]), max_x + 25)
            limit_y = min(len(thresh), max_y + 25)
            window_x = range(max(0, min_x - 25), limit_x)
            window_y = range(max(0, min_y - 25), limit_y)

        # Assumes the frames do not have noisy background motion information
        # and collects all foreground_pixels in the frame
        foreground_pixels = [(i, j)
                             for j in window_x for i in window_y
                             if thresh[i, j] == 255]

        if foreground_pixels:
            check_all = False
            min_y, min_x = map(min, zip(*foreground_pixels))
            max_y, max_x = map(max, zip(*foreground_pixels))
        else:
            check_all = True

        bounds.append((int(min_x), int(min_y), int(max_x), int(max_y)))

    return bounds


def track_ball_1(video, param1=24, param2=4, viz=False):
    """ Track the ball's center in 'video' using direct thresholding detection.

    Arguments:
      video: an open cv2.VideoCapture object containing a video of a ball
        to be tracked.

    Outputs:
      a list of (min_x, min_y, max_x, max_y) four-tuples containing the pixel
      coordinates of the rectangular bounding box of the ball in each frame.
    """

    gFrames = []
    while True:
        grabbed, img = video.read()
        if not grabbed:
            break

        gFrames.append(cv2.cvtColor(img, cv2.COLOR_BGR2GRAY))

    return thresholdDetect(gFrames)


def track_ball_2(video):
    """ Track the ball's center in 'video' using background subtraction and
        direct thresholding detection.

    Arguments and Outputs are the same as track_ball_1.
    """

    gframes = []

    # Grab all frames, converted to grayscale
    while True:
        grabbed, img = video.read()
        if not grabbed:
            break

        gframes.append(cv2.cvtColor(img, cv2.COLOR_BGR2GRAY))

    # Determine the median of pixel i, j
    def median(frames, i, j):
        length = len(frames)
        sorts = sorted([frames[idx][i, j] for idx in xrange(length)])
        return sorts[length/2]

    background = np.array([[median(gframes, i, j)
                            for j in xrange(len(gframes[0][0]))]
                           for i in xrange(len(gframes[0]))])

    subtractions = gframes - background
    return thresholdDetect(subtractions)


def track_ball_3(video):
    """As track_ball_1, but for ball_3.mov."""
    return track_ball_2(video)


def track_ball_4(video):
    """ Track the ball's center in 'video' using Gaussian Blur
        Hough Circle Detection and Meanshift tracking.

    Arguments and Outputs are the same as track_ball_1.
    """

    grabbed, img = video.read()
    if not grabbed:
        return

    # Blur the initial image to reduce noise from sharp background edges
    gimg = cv2.cvtColor(img, cv2.COLOR_BGR2GRAY)
    gimg = cv2.GaussianBlur(gimg, (21, 21), 0)

    circles = cv2.HoughCircles(gimg, cv2.cv.CV_HOUGH_GRADIENT, 2, 100,
                               param1=24, param2=4, minRadius=0, maxRadius=0)

    # Initial bounds and associated track_window
    x, y, radius = circles[0][0][0], circles[0][0][1], circles[0][0][2]
    track_window = (int(x-radius), int(y+radius), int(2*radius), int(2*radius))
    bounds = [(x-radius, y-radius, x+radius, y+radius)]

    # Initialize the binary image of our tracked circle for Meanshift
    roi = img[x-radius:x+radius, y-radius:y+radius]
    hsv_roi = cv2.cvtColor(roi, cv2.COLOR_BGR2HSV)

    mask = cv2.inRange(hsv_roi, np.array((0., 60., 32.)),
                       np.array((180., 255., 255.)))

    roi_hist = cv2.calcHist([hsv_roi], [0], mask, [180], [0, 180])
    cv2.normalize(roi_hist, roi_hist, 0, 255, cv2.NORM_MINMAX)

    # Meanshift termination criteria:
    # Max 10 iterations, or moved at least 1 pixel
    term_crit = (cv2.TERM_CRITERIA_EPS | cv2.TERM_CRITERIA_COUNT, 10, 1)

    while True:
        grabbed, img = video.read()
        if not grabbed:
            break

        # Calculates the meanshift for the current frame.
        # Meanshift detects the tracking_window shift of maximum foreground
        # coverage, where the foregrounds are indicated by our roi histogram &
        # the current frame's hsv image.
        hsv = cv2.cvtColor(img, cv2.COLOR_BGR2HSV)
        dst = cv2.calcBackProject([hsv], [0], roi_hist, [0, 180], 1)

        ret, track_window = cv2.meanShift(dst, track_window, term_crit)

        x, y, w, h = track_window
        bounds.append((x, y, x+w, y+h))

    return bounds


def track_face(video, viz=False):
    """ Track Bryan's face using a frontal Haar Cascade,
        and recovery with Kalman Filter when not detected.

    Arguments and Outputs are the same as track_ball_1.
    """

    # Initialize using Frontal Face Haar Cascade
    face_cascade = cv2.CascadeClassifier('haarcascade_frontalface_default.xml')

    _, img = video.read()
    gimg = cv2.cvtColor(img, cv2.COLOR_BGR2GRAY)
    faces = face_cascade.detectMultiScale(gimg, 1.3, 5)

    bryan = Pedestrian(faces[0])

    state = bryan.kalman.state_post
    bounds = [(state[0, 0],
               state[1, 0],
               state[0, 0] + state[2, 0],
               state[1, 0] + state[3, 0])]

    while True:
        grabbed, img = video.read()

        if not grabbed:
            break

        # Get new measurement
        gimg = cv2.cvtColor(img, cv2.COLOR_BGR2GRAY)
        faces = face_cascade.detectMultiScale(gimg, 1.3, 5)

        # If a face is detected, use the first face's bounds instead of Kalman.
        useKalmanUpdate = True

        if len(faces) > 0:
            bryan.prev_state = faces[0]

            x, y, w, h = faces[0][0], faces[0][1], faces[0][2], faces[0][3]
            bounds.append((x, y, x + w, y + h))
            useKalmanUpdate = False

            if viz:
                cv2.rectangle(img,
                              (int(x), int(y)),
                              (int(x + w), int(y + h)),
                              (0, 255, 0))

        bryan.update()
        state = bryan.kalman.state_post

        if useKalmanUpdate:
            bounds.append((state[0, 0],
                           state[1, 0],
                           state[0, 0] + state[2, 0],
                           state[1, 0] + state[3, 0]))

        if viz:
            # Render current frame with kalman and detector bounds
            cv2.rectangle(img,
                          (int(state[0, 0]), int(state[1, 0])),
                          (int(state[0, 0] + state[2, 0]),
                           int(state[1, 0] + state[3, 0])),
                          (255, 0, 0))

            cv2.imshow("i", img)
            cv2.waitKey()
            cv2.destroyAllWindows()

    return bounds


def track_pedestrians(video, classifier, outputfn,
                      tracking_window=100, viz=True):

    """Tracks pedestrians in a video using the specified classifier.

    Arguments:
      video: An open cv2.VideoCapture object containing trackable objects.
      classifier: The filename for a haar cascade classifier to detect objects.
      outputfn: The desired output video filename.
      tracking_window: The window size to track objects in.
      viz: If true, will preview each frame and the current detection state.
    """

    out = None    # Output video writer
    frame_num = 0
    timeout = 20  # Remove pedestrian if they are not detected after 20 frames
    pedestrians = []
    ped_cascade = cv2.CascadeClassifier(classifier)

    while True:
        grabbed, img = video.read()
        if not grabbed:
            break

        frame_num += 1

        # Initialize the videowriter
        if out is None:
            shape = (img.shape[1], img.shape[0])
            out = cv2.VideoWriter(outputfn,
                                  cv2.cv.CV_FOURCC('M', 'J', 'P', 'G'),
                                  15, shape)

        # Detect pedestrians with the provided cascade
        gimg = cv2.cvtColor(img, cv2.COLOR_BGR2GRAY)
        ped_measurements = ped_cascade.detectMultiScale(gimg, 1.3, 6)

        for ped in pedestrians:

            # All measurements matched to a pedestrian;
            # Any other pedestrian must be unmatched.
            if len(ped_measurements) == 0:
                ped.timer -= 1
                continue

            state = np.array([ped.kalman.state_post[0, 0],
                              ped.kalman.state_post[1, 0],
                              ped.kalman.state_post[2, 0],
                              ped.kalman.state_post[3, 0]])

            # Find distances between the pedestrian and each measurement
            distances = [sum(np.abs(state - np.array(measure)))
                         for measure in ped_measurements]

            # Take the minimum distance measurement if less than mindist
            mindist = min(distances)
            if mindist < tracking_window:

                # Found a measurement within the tracking window
                minidx = distances.index(mindist)
                ped.prev_state = ped_measurements[minidx]
                ped.timer = timeout
                ped.time_alive += 1
                ped_measurements = [ped_measurements[i]
                                    for i in xrange(len(ped_measurements))
                                    if i != minidx]
            else:
                # Pedestrian not detected
                ped.timer -= 1

        # Remove pedestrians that have not been detected recently
        pedestrians = [ped for ped in pedestrians if ped.timer > 0 and
                       (ped.timer == 20 or ped.time_alive >= 4)]

        # Initialize new pedestrians that have been detected
        pedestrians += [Pedestrian(measure) for measure in ped_measurements]

        for ped in pedestrians:
            ped.update()

            # Render pedestrian state with fading color if lost
            state = ped.kalman.state_post
            red = 255 * (ped.timer / float(timeout))
            blue = 255 * (1 - (ped.timer / float(timeout)))

            cv2.rectangle(img,
                          (int(state[0, 0]), int(state[1, 0])),
                          (int(state[0, 0] + state[2, 0]),
                           int(state[1, 0] + state[3, 0])),
                          (blue, 0, red))

        out.write(img)

        if viz:
            cv2.imshow("i", img)
            cv2.waitKey()
            cv2.destroyAllWindows()
        else:
            print "Wrote frame %d" % frame_num

    cv2.destroyAllWindows()
    if out is not None:
        out.release()
