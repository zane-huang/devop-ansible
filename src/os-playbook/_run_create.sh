SSHKey=../authentication/my-private-key
OpenRC=../authentication/openrc-withpw.sh

# copy ssh private key
cp $SSHKey ~/.ssh/my-private-key
sudo chmod 600 ~/.ssh/my-private-key
# export authentication and run the main script
. $OpenRC; ansible-playbook --ask-become-pass main.yaml
# prompt user guide for the next step
echo "Instance(s) launched. Please configure inventory files, OK?"
read _
