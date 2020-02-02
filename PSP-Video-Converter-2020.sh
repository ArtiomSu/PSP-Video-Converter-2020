#!/usr/bin/env bash

# text colours
InfoMessages='\033[0;32m' 
CommandMessages='\033[1;30m'
ErrorMessages='\033[0;1m'
NC='\033[0m' # No Color


input_file=""
output_path=""
filename=""
script_name="$0"
preset=0

check_in_out(){
	command -v ffmpeg >/dev/null 2>&1 || { echo -e "${ErrorMessages}ffmpeg is needed please install using your package manager${NC}"; exit 1; }

	if [ $# -eq 0 ]; then
	    echo -e "${ErrorMessages}Invalid number of arguments supplied"
	    help
	    exit 2
	else
		if [ "$1" == "-h" ] || [ "$1" == "--help" ]; then
			help
			exit 0
		fi
		if [ ! -f "$1" ]; then
			echo -e "${ErrorMessages}cant find $1 the required input file${NC}"
			exit 3
		fi		
		input_file=$1
		if [ $# -eq 1 ]; then
			output_path=$(pwd)/
		elif [ -d "$2" ]; then
			output_path=$2
			if [ ! "${output_path: -1}" == "/" ]; then
				echo -e "${InfoMessages}fixing path${NC}"
				output_path=${output_path}/
			fi		
		else	
			echo -e "${ErrorMessages}$2 is not a directory needed for output${NC}"
			exit 4
		fi

		filename=$(basename "$1")
		filename="${filename%.*}"
		#echo $filename

		#optional preset
		if [ ! -z $3 ]; then
			preset=$3
		fi	

	fi
}

help(){
	echo -e "Basic USAGE: $script_name input_file_path.mp4 output_file_path" 
	echo -e "\nAdvanced USAGE: $script_name input_file_path.mp4 output_file_path.mp4 PRESET_NUM"
	echo -e "Where PRESET_NUM is between 0-2 (default is 0 if nothing is specified)"
	echo -e "\nPresets"
	echo -e "0: default video bitrate 900k audio 128k @ 44.1kHz"
	echo -e "1: Super high quality video bitrate 2000k audio 192k @ 48kHz 29.97fps"
	echo -e "2: Super high quality video bitrate 2000k audio 192k @ 48kHz 23.976fps"
	echo -e "3: matrix specific video bitrate 1000k audio 160k @ 44.1kHz 23.976fps"
	echo -e "4: matrix specific video bitrate 1000k audio 160k @ 44.1kHz 29.97fps"
	echo -e "5: Low quality video bitrate 658k audio 96k @ 44.1kHz 29.97fps"
	echo -e "6: Low quality video bitrate 658k audio 96k @ 44.1kHz 23.976fps"
	echo -e "\nFor highest quality use: $script_name input_file_path.mp4 output_file_path 1"
}

run_conversion(){
	case  $preset  in
                1)      
					# Super high quality video bitrate 2000k audio 192k @ 48kHz 29.97fps
     		    	echo -e "${CommandMessages}ffmpeg -i $input_file -b:v 2000k -strict -2 -s 480x272 -vcodec h264_nvenc -ab 192k -ar 48000 -acodec aac -r 29.97 ${output_path}${filename}_psp.mp4${NC}"
					ffmpeg -i "$input_file" -b:v 2000k -strict -2 -s 480x272 -vcodec h264_nvenc -ab 192k -ar 48000 -acodec aac -r 29.97 "${output_path}${filename}_psp.mp4"
                    ;;
                2)
     		    	# Super high quality video bitrate 2000k audio 192k @ 48kHz 23.976fps
     		    	echo -e "${CommandMessages}ffmpeg -i $input_file -b:v 2000k -strict -2 -s 480x272 -vcodec h264_nvenc -ab 192k -ar 48000 -acodec aac -r 23.976 ${output_path}${filename}_psp.mp4${NC}"
					ffmpeg -i "$input_file" -b:v 2000k -strict -2 -s 480x272 -vcodec h264_nvenc -ab 192k -ar 48000 -acodec aac -r 23.976 "${output_path}${filename}_psp.mp4"
                    ;;            
				3)
     		    	# matrix specific video bitrate 1000k audio 160k @ 44.1kHz 23.976fps
     		    	echo -e "${CommandMessages}ffmpeg -i $input_file -b:v 1000k -strict -2 -s 480x272 -vcodec h264_nvenc -ab 160k -ar 44100 -acodec aac -r 23.976 ${output_path}${filename}_psp.mp4${NC}"
					ffmpeg -i "$input_file" -b:v 1000k -strict -2 -s 480x272 -vcodec h264_nvenc -ab 160k -ar 44100 -acodec aac -r 23.976 "${output_path}${filename}_psp.mp4"
                    ;; 
                4)
     		    	# matrix specific video bitrate 1000k audio 160k @ 44.1kHz 29.97fps
     		    	echo -e "${CommandMessages}ffmpeg -i $input_file -b:v 1000k -strict -2 -s 480x272 -vcodec h264_nvenc -ab 160k -ar 44100 -acodec aac -r 29.97 ${output_path}${filename}_psp.mp4${NC}"
					ffmpeg -i "$input_file" -b:v 1000k -strict -2 -s 480x272 -vcodec h264_nvenc -ab 160k -ar 44100 -acodec aac -r 29.97 "${output_path}${filename}_psp.mp4"
                    ;;   
                5)
     		    	# Low quality video bitrate 658k audio 96k @ 44.1kHz 29.97fps
     		    	echo -e "${CommandMessages}ffmpeg -i $input_file -b:v 658k -strict -2 -s 480x272 -vcodec h264_nvenc -ab 96k -ar 44100 -acodec aac -r 29.97 ${output_path}${filename}_psp.mp4${NC}"
					ffmpeg -i "$input_file" -b:v 658k -strict -2 -s 480x272 -vcodec h264_nvenc -ab 96k -ar 44100 -acodec aac -r 29.97 "${output_path}${filename}_psp.mp4"
                    ;;  
                6)
     		    	# Low quality video bitrate 658k audio 96k @ 44.1kHz 23.976fps
     		    	echo -e "${CommandMessages}ffmpeg -i $input_file -b:v 658k -strict -2 -s 480x272 -vcodec h264_nvenc -ab 96k -ar 44100 -acodec aac -r 23.976 ${output_path}${filename}_psp.mp4${NC}"
					ffmpeg -i "$input_file" -b:v 658k -strict -2 -s 480x272 -vcodec h264_nvenc -ab 96k -ar 44100 -acodec aac -r 23.976 "${output_path}${filename}_psp.mp4"
                    ;;        
                *) 
					#default video bitrate 900k audio 128k @ 44.1kHz
					echo -e "${CommandMessages}ffmpeg -i $input_file -b:v 900k -strict -2 -s 480x272 -vcodec h264_nvenc -ab 128k -ar 44100 -acodec aac -r 23.976 ${output_path}${filename}_psp.mp4${NC}"
					ffmpeg -i "$input_file" -b:v 1000k -strict -2 -s 480x272 -vcodec h264_nvenc -ab 160k -ar 44100 -acodec aac -r 23.976 "${output_path}${filename}_psp.mp4"
					;;              
          esac 
}

convert(){
	echo -e "${InfoMessages}Beginning conversion.....${NC}"
	echo -e "${InfoMessages}input file is $input_file${NC}"
	echo -e "${InfoMessages}output path is $output_path${NC}"
	echo -e "${InfoMessages}using preset $preset${NC}"

	echo -e "${InfoMessages}running command:${NC}"
	 
	run_conversion 

	if [ $? -eq 0 ]; then
		echo -e "${InfoMessages}conversion seems to have been successfull${NC}"
		echo -e "${InfoMessages}generating thumbnail now${NC}"
		echo -e "${InfoMessages}running command:${NC}"
		echo -e "${CommandMessages}ffmpeg -y -i $input_file -f image2 -ss 5 -vframes 1 -s 160x120 -an ${output_path}${filename}_psp.THM${NC}"
		ffmpeg -y -i "$input_file" -f image2 -ss 5 -vframes 1 -s 160x120 -an "${output_path}${filename}_psp.THM"
	else
		echo -e "${ErrorMessages}Conversion failed see ffmpeg output for a reason${NC}"
		exit 5
	fi
}


check_in_out "$@"
convert
