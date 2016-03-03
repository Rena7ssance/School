import cv2
import sys
import tracking


def main():
    if len(sys.argv) < 4:
        print "Usage: ./pedestrian_tracking.py video classifier " + \
            "output_filename [tracking_window] [viz T|F]"

    videoFile = sys.argv[1]
    classifierFile = sys.argv[2]
    outputFilename = sys.argv[3]
    trackingWindow = float(sys.argv[4]) if len(sys.argv) > 4 else 100
    viz = sys.argv[5] == 'T' if len(sys.argv) > 5 else True

    video = cv2.VideoCapture(videoFile)
    tracking.track_pedestrians(video, classifierFile, outputFilename,
                               trackingWindow, viz)

if __name__ == '__main__':
    main()
