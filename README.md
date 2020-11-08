# PSP Video Converter 2020

I made this because I could not find a converter that works properly in 2020 :(

This converts any* video file into a format that the psp can read. It also generates a thumbnail (`name.THM`) for your video so you can put the two files in the Video folder of the PSP. 

### requirements
`ffmpeg` and some codecs possibly if they are not installed by default

### instructions
`PSP-Video-Converter-2020.sh -h` has everything you need


provide a file that you want to convert as your first arguement and folder you want to save to as your second. the folder is optional so if you provide nothing it will save to your pwd


You can supply a third arguement to choose a preset ( note you will need to supply a folder if you choose to use a non default preset so you can do `PSP-Video-Converter-2020.sh video.mp4 $(pwd) 1` if you wanna save to your current location )


Here is the full help page with the Presets:
```
Basic USAGE: ./PSP-Video-Converter-2020.sh input_file_path.mp4 output_file_path

Advanced USAGE: ./PSP-Video-Converter-2020.sh input_file_path.mp4 output_file_path.mp4 PRESET_NUM
Where PRESET_NUM is between 0-2 (default is 0 if nothing is specified)

Presets
0: default video bitrate 900k audio 128k @ 44.1kHz
1: Super high quality video bitrate 2000k audio 192k @ 48kHz 29.97fps
2: Super high quality video bitrate 2000k audio 192k @ 48kHz 23.976fps
3: matrix specific video bitrate 1000k audio 160k @ 44.1kHz 23.976fps
4: matrix specific video bitrate 1000k audio 160k @ 44.1kHz 29.97fps
5: Low quality video bitrate 658k audio 96k @ 44.1kHz 29.97fps
6: Low quality video bitrate 658k audio 96k @ 44.1kHz 23.976fps

For highest quality use: ./PSP-Video-Converter-2020.sh input_file_path.mp4 output_file_path 1
```

### extra: youtubedl_psp.sh

This script created by https://github.com/leleobhz/ and based on PSP-Video-Converter-2020.sh is targeted to best possible encoding a Youtube URL. 

#### youtubedl_psp requirements
* Same `ffmpeg` as PSP-Video-Converter-2020.sh
* `youtube-dl` (https://youtube-dl.org/) in latest version possible (Tested with 2020.09.20)
* `aria2c` for faster downloads (Usually available with `apt install aria2` or `yum install aria2`)

#### youtubedl_psp usage

```
Single command: ./youtubedl_psp.sh <youtube url>
```

Output will generate .mp4 ready for the card and .THM with a 160x120 scaled+pan thumbnail from youtube thumbnail image.

### issues
currently this uses nvenc ( nvidia encoder ) to create files as I was not able to get any other h264 encoder to play on the PSP for some strange reason. So if you dont have an nvidia gpu I appologise I will try to figure it out soon enough.

### screenshots
![PSP Video Menu](/screenshots/1.jpg?raw=true "PSP Video Menu") 
![Video Details top half](/screenshots/2.jpg?raw=true "Video Details top half") 
![Rest of Video Details](/screenshots/3.jpg?raw=true "Rest of Video Details") 
![The Matrix Movie Running on PSP](/screenshots/4.jpg?raw=true "The Matrix Movie Running on PSP") 
