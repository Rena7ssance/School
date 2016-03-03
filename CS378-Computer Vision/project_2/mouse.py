import cv2
import numpy as np
import stereo

left = cv2.imread("my_stereo/mouseleft.JPG")
right = cv2.imread("my_stereo/mouseright.JPG")

f, hleft, hright = stereo.rectify_pair(left, right)
wl, p = stereo.warp_image(left, hleft)
wr, p = stereo.warp_image(right, hright)
#  cv2.imwrite("left.png",left)
#  cv2.imwrite("right.png",wr)

disparity = stereo.disparity_map(left, right)

cv2.imwrite('disparity.png', disparity)

s = stereo.point_cloud(disparity, left, 3)
with open("my_stereo/mouse.ply", 'w') as f:
    f.write(s)
