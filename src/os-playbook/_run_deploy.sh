# *** VARIABLES ***
HOST_FILE=inventory/hosts.ini
RC_FILE=../authentication/openrc-withpw.sh
SSHKey=../authentication/my-private-key

# *** prerequisite ***
# copy private key
cp $SSHKey ~/.ssh/my-private-key
sudo chmod 600 ~/.ssh/my-private-key

# *** common tasks for all instances ***
# --------------------------------------
# configure (http|https|no) proxy
. $RC_FILE; ansible-playbook -i $HOST_FILE host_deploy/simple-proxy.yaml
# mount /dev/vdb to /data
. $RC_FILE; ansible-playbook -i $HOST_FILE host_deploy/simple-mount.yaml
# update cache and install [pip, git, ...]
. $RC_FILE; ansible-playbook -i $HOST_FILE host_deploy/simple-apt.yaml

# *** tasks for couchdb node ***
# -----------------------------
# configure docker: install docker.io, run couchdb container
. $RC_FILE; ansible-playbook -i $HOST_FILE host_deploy/simple-docker_envr.yaml
. $RC_FILE; ansible-playbook -i $HOST_FILE host_deploy/simple-docker_run.yaml
. $RC_FILE; ansible-playbook -i $HOST_FILE host_deploy/simple-docker_start.yaml
# after starting the couchdb container, define views with python scripts
. $RC_FILE; ansible-playbook -i $HOST_FILE host_deploy/simple-aurin.yaml
# set up nginx for web hosting
. $RC_FILE; ansible-playbook -i $HOST_FILE host_deploy/simple-docker_nginx.yaml

# *** tasks for harvester instances ***
# -------------------------------------
# configure git repository
. $RC_FILE; ansible-playbook -i $HOST_FILE host_deploy/simple-harvester.yaml
