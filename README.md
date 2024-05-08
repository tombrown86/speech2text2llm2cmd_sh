# speech2text2llm2cmd_sh
Speech to text to local LLM to shell cmd.

Records audio in console allowing user to vocally describe a desired shell command / operation... 

E.g.
"Computer, show me the files in the current directory"
"find me a list of files called blah that contain blahblah and sort them by blahblahblah..."



The audio description is converted to text which is then converted to a best guess shell command using a local LLM (like gpt-2 or llama).

(This actually works a lot better than expected! but obvs I suggest reviewing any command before running..)



Speech to text step:

Uses sox and ffmpeg to create / clean a wav recording.

Currently calls Google cloud API to get transcript from audio (account creds + project required).



Alternatively, to skip speech to text step and have the sh accept the prompt text:

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
