Xavier's Bounding Box tool (boundingTool.html)
==============================================
Open boundingTool in chrome or firefox - I've only tested with firefox.

The tool lets you draw colored squares around important regions and download the coordinates as JSON.

####To load an image:
Pick an image and click Load Image.  It should load full screen, with the controls in the top left corner.
Most of our images are big and will require you to scroll up and across.

####To draw a box:
Pick red, green, or blue as a color.  Click to mark the top left corner, drag to the bottom right.  Release your mouse.
A colored box should be over the region.

####To delete a box:
Click the delete mode checkbox.  Click a box to delete it.

Once you have your boxes drawn, click Get JSON and save the file in /groundtruth/json.

Ashley's Bounding Box tool (boundingTool.py)
============================================

####To load an image:
you can change image selected on line 54 if necessary

####to draw a bounding box:
click and drag from top left to bottom right of object you want to draw a bounding box around

####To delete a box:
right click. This ONLY deletes the previously drawn square

Press esc when done. JSON is automatically written groundtruth directory as "groundtruth.txt"