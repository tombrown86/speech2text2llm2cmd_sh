#!/bin/bash

echo "Recording audio... end with crl+c"

sox -d recording.wav
gcloud auth application-default login  # Authenticate with Google Cloud
#gcloud auth application-default set-quota-project xxx
gcloud config set project xxx
ffmpeg -i recording.wav recordingclean.wav

llmprompt=`gcloud ml speech recognize recordingclean.wav --language-code=en-US --format=json | jq -r '.results[].alternatives[].transcript'`

rm -f recording.wav
rm -f recordingclean.wav

echo "Your LLM Prompt: $llmprompt"


instruction="###Instruction:$llmprompt"

model="" # Set the path to your model (gpt-2 or llama etc), like: model="/Volumes/ext1tb/Models/Other_Models/GPT-2/GPT-2_Large_774M/ggml-model-gpt-2-774M_q80.bin"

infer="" # Set the path to your llama.cpp main or ggml gpt-2 etc, like: infer="./gpt-2"


prompt="$prompt$user_input"


echo "\n$llmprompt" >> text2llm2cmd.history

tempfile=$(mktemp)
instruction >> tempfile

command="$($infer 2>/dev/null --top_p 0.3 --temp 0.5 -n 23 -b 16 -t 3 -m "$model" -f "$tempfile" | sed -n '71p')"

echo "$command"
read -p "Execute above command? (y/n) " -n 1 -r
echo 

if [[ $REPLY =~ ^[Yy]$ ]]
then
    eval "$command"
fi

exit 0

