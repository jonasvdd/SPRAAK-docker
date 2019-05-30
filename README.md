# SPRaak Software tool
This software is used to process the given speech data in such way it resembles telephone speech. 

## Corpus File

>See also [this README](README_stm.md) for further information (section .stm files)

Processing a collection of files in SPRaak requires a corpus (or segmentation) file

A corpus files **list the files** (or parts thereof) and **their content (orthographic description)**. Files in SPRaak are suposed to have a header (you can specifiy an external header if the file just contains raw data). The header start with the "magic" string ".spr", then continues with a set of "key" "value" value pairs, and ends with a line containing a single "#.
The data start directly after the "#" (and newline character).

A corpus file contain ASCII based data (filename + orthographic description + time info + optional extra info), and had the following mandatory fields:

- **field1**: file name without source path of the databased and without extension; this allows reusing the same corpus file for listing the wav-files or various versions of processed data
            use `-` if the next line describes the same file (e.g. when describing each sentence in a seperate line)
- **field2**:   orthograpic description (words are sperated by '_')
- **field3+4**: begin and end time of the sentence (just a chunk of the signal) time can be
    - start frame (by default 10msec frames) and length in number of frames (integers); this is the default;
     >**note**: the key FSHIFT can be used to redefine the default frame period of 0.01 seconds (10msec)
    - begin time and end time in seconds (floating point value); add the "TIMEBASE CONTINUOUS" to the header if you want to use this convention
     >**note**: use -1 to indicate "till the end of the file" (both when using the frame indices or when using the time in seconds)
- **field5...** optional fields; you may want to split the data per speaker and add the speaker ID as 5th field (will be needed when doing speaker normalisation)!


## Installation
To ease the installation a [Dockerfile](Dockerfile) was made to create a container withholding the SPRaak tool. Just follow the succeeding commands and you will be fine. 


### Commands 
First you need to build an image from that dockerfile with:
```sh
docker image build -t $USER/spraak .
```

Run the container in an interactive mode (terminal) with a **volume mounted** (most likely the directory in which the speech files are stored). 
```sh
docker run -ti -v "$PWD/os_volume_path":/container_path $USER/spraak bash
```

To be able to interact with the `spr_` API, run this command:
```sh
source /etc/profile
```

If you want to do a quick check if everything works, just run:
```sh
printf '@1+1\nquit\n' | spr_cwr_main
# should print "const ans = 2"
```

## Configuration
Now, configure configure the [convert_tel_data.sh](convert_tel_data.sh) script, this is located in the `/SPRaak` foloder. Within this script the variables `dbase`, `wav_src`, and `wav_tel_dst` must be set to their corresponding values (the nano texteditor is installed). 


## An example 
I set the variables to: 
```sh
dbase=tel_db
wav_src=/ugent_data/ugent
wav_tel_dst=/ugent_data/ugent_conv_tel
```
Then I executed the [convert_tel_data.sh](convert_tel_data.sh) which led to the following output:
```txt
root@77745bdfe6fc:/SPRaak/v1.2.395# ./convert_tel_data.sh 
000000.000868 INFO main_thread.spr_stream_file_open().0 : making directory "/ugent_data/ugent_conv_tel/evaluation/wav/BN"
000127.634697 INFO main_thread.spr_stream_file_open().0 : making directory "/ugent_data/ugent_conv_tel/evaluation/wav/Documentaries"
000329.227871 INFO main_thread.spr_stream_file_open().0 : making directory "/ugent_data/ugent_conv_tel/evaluation/wav/English"
000367.714922 INFO main_thread.spr_stream_file_open().0 : making directory "/ugent_data/ugent_conv_tel/evaluation/wav/Flemish"
000401.465159 INFO main_thread.spr_stream_file_open().0 : making directory "/ugent_data/ugent_conv_tel/evaluation/wav/French"
etc ...
```

The corpus database file was named "tel_db.cor". 
