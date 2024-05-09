# speech_to_txt_to_LLM_to_cmd_sh

Speech to text to local LLM to shell cmd.

Records audio in console allowing user to vocally describe a desired shell command / operation.

This is converted to an LLM prompt which is run on a local LLM (like gpt-2 or llama), and converted to (ideally) a desired linux command.

Warning: This takes a while to run on your average machine and some of the suggested commands are a bit awful but I'm convinced with the right model this could be awesome :)
At the moment it may be better to use a super decent online model via it's API :)


E.g.
"Computer, show me the files in the current directory"
"find me a list of files called blah that contain blahblah and sort them by blahblahblah..."



Setup:

```
# If using youre gcloud to get audio transcribed
gcloud auth application-default login

brew install ffmpeg
brew install sox
chmod +x s2cmd.sh

# update GCLOUD_PROJ_NAME, MODEL and BIN vars in sh before running

./s2cmd.sh
```







**Speech to text step**

This currently relies on google clouds transcription service for which you need a project + API etc.

Also uses sox and ffmpeg to create / clean a wav recording.





Alternatively, skip speech to text step and just have the sh accept the prompt text :) 

```
prompt=""
for arg in "$@"
do
  prompt="$prompt $arg"
done
```






