export OCP_VERSION="$ocpversion"
wget https://mirror.openshift.com/pub/openshift-v4/clients/ocp/${OCP_VERSION}/openshift-install-linux-${OCP_VERSION}.tar.gz
wget https://mirror.openshift.com/pub/openshift-v4/clients/ocp/${OCP_VERSION}/openshift-client-linux-${OCP_VERSION}.tar.gz

sudo tar -xzvf openshift-install-linux-${OCP_VERSION}.tar.gz -C /usr/local/bin openshift-install

sudo tar -xzvf openshift-client-linux-${OCP_VERSION}.tar.gz -C /usr/local/bin oc kubectl

oc completion bash | sudo tee /etc/bash_completion.d/openshift > /dev/null
