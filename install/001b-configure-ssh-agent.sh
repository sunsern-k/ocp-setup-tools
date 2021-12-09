echo "Staring ssh-agent and adding  ~/.ssh/$ssh_key_name"
eval "$(ssh-agent -s)"
ssh-add ~/.ssh/$ssh_key_name