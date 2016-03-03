import cv2
import numpy as np

MIN_MATCH_COUNT = 10


def homography(image_a, image_b):
    """Returns the homography mapping image_b into alignment with image_a.

    Arguments:
      image_a: A grayscale input image.
      image_b: A second input image that overlaps with image_a.

    Returns: the 3x3 perspective transformation matrix (aka homography)
             mapping points in image_b to corresponding points in image_a.
    """
    sift = cv2.SIFT()
    # find the keypoints and descriptors with SIFT
    kp1, des1 = sift.detectAndCompute(image_a, None)
    kp2, des2 = sift.detectAndCompute(image_b, None)

    FLANN_INDEX_KDTREE = 0
    index_params = dict(algorithm=FLANN_INDEX_KDTREE, trees=5)
    search_params = dict(checks=50)

    flann = cv2.FlannBasedMatcher(index_params, search_params)

    matches = flann.knnMatch(des1, des2, k=2)

    # store all the good matches as per Lowe's ratio test.
    good = []
    for m, n in matches:
        if m.distance / n.distance < .75:
            good.append(m)

    # print(kp1)
    if len(good) > 0:
        src_pts = np.float32([kp1[m.queryIdx].pt for m in good])
        src_pts = src_pts.reshape(-1, 1, 2)
        dst_pts = np.float32([kp2[m.trainIdx].pt for m in good])
        dst_pts = dst_pts.reshape(-1, 1, 2)

        M, mask = cv2.findHomography(dst_pts, src_pts, cv2.RANSAC)
        return M

    else:
        x = len(good)
        line = "Not enough matches are found"
        print "%s - %d/%d" % (line, x, MIN_MATCH_COUNT)
        matchesMask = None


def warp_image(image, homography):
    """Warps 'image' by 'homography'

    Arguments:
      image: a 3-channel image to be warped.
      homography: a 3x3 perspective projection matrix mapping points
                  in the frame of 'image' to a target frame.

    Returns:
      - a new 4-channel image containing the warped input, resized to contain
        the new image's bounds. Translation is offset so the image fits exactly
        within the bounds of the image. The fourth channel is an alpha channel
        which is zero anywhere that the warped input image does not map in the
        output, i.e. empty pixels.
      - an (x, y) tuple containing location of the warped image's upper-left
        corner in the target space of 'homography', which accounts for any
        offset translation component of the homography.
    """
    """[0][2] = tranlate in x
        [1][2] = translate in y
        [0][0] = scale in x
        [1][1] = scale in y
    """

    # Calcualte an (x,y) tuple with the location of the
    # warped images upper-left corner
    height, width, depth = image.shape
    homography_matrix = np.matrix(homography)

    zero_array = np.matrix([[0], [0], [1]])
    origin_points = homography_matrix * zero_array
    new_x1 = origin_points[0, 0] // origin_points[2, 0]
    new_y1 = origin_points[1, 0] // origin_points[2, 0]

    zero_array = np.matrix([[width], [0], [1]])
    origin_points = homography_matrix * zero_array
    new_x2 = origin_points[0, 0] // origin_points[2, 0]
    new_y2 = origin_points[1, 0] // origin_points[2, 0]

    zero_array = np.matrix([[0], [height], [1]])
    origin_points = homography_matrix * zero_array
    new_x3 = origin_points[0, 0] // origin_points[2, 0]
    new_y3 = origin_points[1, 0] // origin_points[2, 0]

    zero_array = np.matrix([[width], [height], [1]])
    origin_points = homography_matrix * zero_array
    new_x4 = origin_points[0, 0] // origin_points[2, 0]
    new_y4 = origin_points[1, 0] // origin_points[2, 0]

    y_max = max(new_y4, new_y3, new_y2, new_y1)
    y_min = min(new_y4, new_y3, new_y2, new_y1)
    x_max = max(new_x4, new_x3, new_x2, new_x1)
    x_min = min(new_x4, new_x3, new_x2, new_x1)

    # Make a new homography without translations
    identity = [[1, 0, -x_min], [0, 1, -y_min], [0, 0, 1]]
    Hprime = np.matrix(identity) * homography_matrix

    # warp image
    image3 = cv2.warpPerspective(image, Hprime,
        (int(x_max - x_min), int(y_max - y_min)))

    # Calculate alpha channel
    grayImg = cv2.cvtColor(image3, cv2.COLOR_BGR2GRAY)
    thresh = cv2.threshold(grayImg, 0, 255, cv2.THRESH_BINARY)
    channel1, channel2, channel3 = cv2.split(image3)
    threshImage = cv2.merge((channel1, channel2, channel3, thresh[1]))

    return threshImage, (x_min, y_min)


def create_mosaic(images, origins):
    #make coordinates relative to origins[0]

    miny = min(y for (x, y) in origins)
    minx = min(x for (x, y) in origins)
    maxy = max(y for (x, y) in origins)
    maxx = max(x for (x, y) in origins)
    origins = [[x - minx, y - miny] for (x, y) in origins]

    #set up the resulting mosaic canvas
    imageorigins = zip(images, origins)
    fullheight = max(image.shape[0] + abs(y) for image, [x, y] in imageorigins)
    fullwidth = max(image.shape[1] + x for image, [x, y] in imageorigins)

    mosaiccanvas = np.zeros((fullheight, fullwidth, 4))
    for image, (x, y) in imageorigins:
        h, w, d = image.shape
        mosaiccanvas[y:y + h, x:x + w, :] = image
    return mosaiccanvas
