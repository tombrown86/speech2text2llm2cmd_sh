# speech2text2llm2cmd_sh
Speech to text to local LLM to shell cmd 



Speech to text step:

Uses sox and ffmpeg to create / clean a wav recording.
Currently calls Google cloud API to get transcript from audio (account creds + project required).



Alternatively just skip speech2text step and have the sh accept the prompt text?


```
prompt=""
for arg in "$@"
do
  prompt="$prompt $arg"
done
```



End recording with Ctrl + C


```
chmod +x s2cmd.sh
./s2cmd.sh
```
