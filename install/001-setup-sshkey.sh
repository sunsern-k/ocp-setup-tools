ssh-keygen -t rsa -b 2048 -N '' -f ~/.ssh/$ssh_key_name
eval "$(ssh-agent -s)"
ssh-add ~/.ssh/$ssh_key_name
