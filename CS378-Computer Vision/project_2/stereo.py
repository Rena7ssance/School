"""Project 2: Stereo vision.

In this project, you'll extract dense 3D information from stereo image pairs.
"""

import cv2
import math
import numpy as np
# from matplotlib import pyplot as plt


def rectify_pair(image_left, image_right, viz=False):
    """Computes the pair's fundamental matrix and rectifying homographies.

    Arguments:
      image_left, image_right: 3-channel images making up a stereo pair.

    Returns:
      F: the fundamental matrix relating epipolar geometry between the pair.
      H_left, H_right: homographies that warp the left and right image so
        their epipolar lines are corresponding rows.
    """

    img1 = image_left  # queryimage # left image
    img2 = image_right  # trainimage # right image

    sift = cv2.SIFT()

    # find the keypoints and descriptors with SIFT
    kp1, des1 = sift.detectAndCompute(img1, None)
    kp2, des2 = sift.detectAndCompute(img2, None)

    # FLANN parameters
    FLANN_INDEX_KDTREE = 0
    index_params = dict(algorithm=FLANN_INDEX_KDTREE, trees=5)
    search_params = dict(checks=50)

    flann = cv2.FlannBasedMatcher(index_params, search_params)
    matches = flann.knnMatch(des1, des2, k=2)

    good = []
    pts1 = []
    pts2 = []

    # ratio test as per Lowe's paper
    for m, n in matches:
        if m.distance/n.distance < .75:
            good.append(m)

    pts1 = np.float32([kp1[m.queryIdx].pt for m in good])
    pts2 = np.float32([kp2[m.trainIdx].pt for m in good])

    F, mask = cv2.findFundamentalMat(pts1, pts2, cv2.FM_RANSAC)

    pts1 = pts1.reshape(-1, 1, 2)
    pts2 = pts2.reshape(-1, 1, 2)
    width, height = img1.shape[:2]
    r, H_left, H_right = cv2.stereoRectifyUncalibrated(
        pts1, pts2, F, (width, height))

    return F, H_left, H_right


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
    h, w = image.shape[:2]
    pts2 = np.float32([[0, 0], [w, 0], [0, h], [w, h]]).reshape(-1, 1, 2)
    pts2_ = cv2.perspectiveTransform(pts2, homography)
    max_0 = max(pts2_[0][0][0], pts2_[1][0][0], pts2_[2][0][0], pts2_[3][0][0])
    max_1 = max(pts2_[0][0][1], pts2_[1][0][1], pts2_[2][0][1], pts2_[3][0][1])
    min_0 = min(pts2_[0][0][0], pts2_[1][0][0], pts2_[2][0][0], pts2_[3][0][0])
    min_1 = min(pts2_[0][0][1], pts2_[1][0][1], pts2_[2][0][1], pts2_[3][0][1])

    homography[0][2] -= min_0
    homography[1][2] -= min_1
    dst = cv2.warpPerspective(
        image, homography, (max_0 - min_0, max_1 - min_1))

    dst_alpha = cv2.cvtColor(dst, cv2.COLOR_BGR2BGRA)

    return dst, (pts2_[0][0][0], pts2_[0][0][1])


def disparity_map(image_left, image_right):
    """Compute the disparity images for image_left and image_right.

    Arguments:
      image_left, image_right: rectified stereo image pair.

    Returns:
      an single-channel image containing disparities in pixels,
        with respect to image_left's input pixels.
    """
    grayleft = cv2.cvtColor(image_left, cv2.COLOR_BGR2GRAY)
    grayright = cv2.cvtColor(image_right, cv2.COLOR_BGR2GRAY)
    c, r = grayleft.shape
    #  grayleft = cv2.cv.fromarray(grayleft)
    #  grayright = cv2.cv.fromarray(grayright)
    s = cv2.StereoSGBM()
    s.SADWindowSize = 11
    s.preFilterCap = 10
    s.minDisparity = 5
    s.numberOfDisparities = 14*16
    s.disp12MaxDiff = 1
    s.fullDP = False
    s.P1 = 8*3*s.SADWindowSize*s.SADWindowSize
    s.P2 = 32*3*s.SADWindowSize*s.SADWindowSize
    s.uniquenessRatio = 12
    disparity = s.compute(grayleft, grayright)
    #  cv2.cv.FindStereoCorrespondenceBM(grayleft, grayright, disparity, sbm)
    disparity_visual = cv2.cv.CreateMat(c, r, cv2.cv.CV_8U)
    cv2.cv.Normalize(
        cv2.cv.fromarray(disparity),
        disparity_visual, 0, 255, cv2.cv.CV_MINMAX)
    disparity_visual = np.array(disparity_visual)
    #  cv2.imshow("f", disparity_visual)
    return disparity_visual


def write_ply(verts, colors):
    ply_header = '''ply
    format ascii 1.0
    element vertex %(vert_num)d
    property float x
    property float y
    property float z
    property uchar red
    property uchar green
    property uchar blue
    end_header
    '''
    verts = verts.reshape(-1, 3)
    colors = colors.reshape(-1, 3)
    verts = np.hstack([verts, colors])
    s = str(ply_header % dict(vert_num=len(verts)))
    for [a, b, c, d, e, f] in verts:
            s += str(float(a))+" "
            s += str(float(b))+" "
            s += str(float(c))+" "
            s += str(int(d))+" "
            s += str(int(e))+" "
            s += str(int(f))+"\n"
    return s


def point_cloud(disparity_image, image_left, focal_length):
    """Create a point cloud from a disparity image and a focal length.

    Arguments:
      disparity_image: disparities in pixels.
      image_left: BGR-format left stereo image, to color the points.
      focal_length: the focal length of the stereo camera, in pixels.

    Returns:
      A string containing a PLY point cloud of the 3D locations of the
        pixels, with colors sampled from left_image. You may filter low-
        disparity pixels or noise pixels if you choose.
    """
    h, w = image_left.shape[:2]
    Q = np.float32([[1, 0, 0, 0.5*w],
                    [0, 1, 0,  0.5*h],  # turn points 180 deg around x-axis,
                    [0, 0, focal_length, 0],  # so that y-axis looks up
                    [0, 0, 0,      1]])
    points = cv2.reprojectImageTo3D(disparity_image, Q)
    colors = cv2.cvtColor(image_left, cv2.COLOR_BGR2RGB)
    return write_ply(points, colors)

"""
left = cv2.imread('test_data/kitchen_left.jpg')
right = cv2.imread('test_data/kitchen_right.jpg')
rectify_pair(left,right)
"""
