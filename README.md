# Transparant-video-shader


Shader that allows transparent videos to play in Unity in normal video formats.
This shader follows the same format as transparent videos in the video game Caligula 2. Video files exported from that game's assets work perfectly in this shader.


To make this work, take the following steps:


1. Clone this repostitory
2. Add Video Player prefab to scene
3. (OPTIONAL) Add custom video to video player
4. Add transparent video material to any mesh that needs to display the video




# Creating Transparent video
To create a transparent video, you need to split your video into two parts: the top part as alpha mask, and the bottom part the actual video.
Check the sample video to check the format.
All 16:9 resolutions should work properly, as the shader works with scale.


# TODO-LIST:

- Make a video to decal shader, to project videos on any mesh as a decal
- Fix material not working in game view
- Make both vertical and Horizontal split views work in shader (Using customizeable size parameters)
- Test non 16:9 resolutions
