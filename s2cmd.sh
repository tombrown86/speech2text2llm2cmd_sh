#!/bin/bash

GCLOUD_PROJ_NAME="pivotal-surfer-422716-p5"
MODEL="../../AI/codellama-7b-instruct.Q8_0.gguf"
BIN="/Users/tom/Code/AI/llama.cpp/main"

echo "Recording audio... end with crl+c"

sox -d recording.wav
gcloud config set project $GCLOUD_PROJ_NAME
ffmpeg -i recording.wav recordingclean.wav

llmprompt=`gcloud ml speech recognize recordingclean.wav --language-code=en-US --format=json | jq -r '.results[].alternatives[].transcript'`

rm -f recording.wav
rm -f recordingclean.wav

echo "Your LLM Prompt: $llmprompt"
echo "\n$llmprompt" >> text2llm2cmd.history


instruction="###Instruction:Print me a linux command to: $llmprompt"
tempfile=$(mktemp)
echo "$instruction" > $tempfile


# command using llama.cpp method
command="$($BIN -m "$MODEL" -c 4096 --temp 0.5 --repeat_penalty 1.1 --file $tempfile)"

echo "$command"
read -p "Execute above command? (y/n) " -n 1 -r
echo 

if [[ $REPLY =~ ^[Yy]$ ]]
then
    eval "$command"
fi

exit 0

