echo "Setting $RHCOS_BOOTSTRAP - guestinfo.ignition.config.data => the content of ${HOME}/append-bootstrap.64"
govc vm.change -vm $RHCOS_BOOTSTRAP -e "guestinfo.ignition.config.data=$(cat ${HOME}/append-bootstrap.64)"
