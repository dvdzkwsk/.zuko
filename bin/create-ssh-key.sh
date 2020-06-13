# https://help.github.com/en/enterprise/2.17/user/github/authenticating-to-github/generating-a-new-ssh-key-and-adding-it-to-the-ssh-agent
read -p "Enter email: " email
read -p "Enter filename (default: id_rsa): " file
file="$HOME/.ssh/${file:-id_rsa}"
echo "Creating SSH key: $file"
ssh-keygen -t rsa -b 4096 -C "${email}" -f "$file"
eval "$(ssh-agent -s)"
ssh-add "$file"

