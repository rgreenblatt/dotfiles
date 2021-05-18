# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/gpfs/runtime/opt/anaconda/2020.02/bin/conda' 'shell.bash' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/gpfs/runtime/opt/anaconda/2020.02/etc/profile.d/conda.sh" ]; then
        . "/gpfs/runtime/opt/anaconda/2020.02/etc/profile.d/conda.sh"
    else
        export PATH="/gpfs/runtime/opt/anaconda/2020.02/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<
