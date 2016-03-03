import cv2
import numpy as np
import pano_stitcher

leftmost = 1
rightmost = 3
middle = (leftmost+rightmost)//2
imgdir = "images/pano/"

rawimages = []
for i in range(leftmost, rightmost+1):
    rawimages.append(cv2.imread(imgdir+"3-" + str(i)+".jpg"))

rightmost -= leftmost
middle -= leftmost
leftmost -= leftmost

rawimages[middle] = cv2.cvtColor(rawimages[middle], cv2.COLOR_BGR2BGRA)

warpedimages = []
warpedcorners = []
for i in range(0,middle):
    l = rawimages[i]
    r = rawimages[i+1]
    h = pano_stitcher.homography(r, l)
    print("Finished left homography #"+str(i))
    warpedimage, warpedcorner = pano_stitcher.warp_image(l, h)
    print("Warped image #"+str(i))
    warpedimages.append(warpedimage)
    warpedcorners.append(warpedcorner)



for i in range(middle,rightmost) :
    l = rawimages[i]
    r = rawimages[i+1]
    h = pano_stitcher.homography(l,r)
    print("Finished right homography #"+str(i))
    warpedimage, warpedcorner = pano_stitcher.warp_image(r, h)
    print("Warped image #"+str(i))
    warpedimages.append(warpedimage)
    warpedcorners.append(warpedcorner)

warpedimages.append(rawimages[middle])
warpedcorners.append((0, 0))

k = pano_stitcher.create_mosaic(warpedimages, warpedcorners)
cv2.imshow("image", k)
cv2.waitKey(0)
cv2.destroyAllWindows()
cv2.imwrite("images/smallPano.png", k)
