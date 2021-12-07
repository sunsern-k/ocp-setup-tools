govc vm.change -vm $RHCOS_BOOTSTRAP -e "guestinfo.ignition.config.data=$(cat ${HOME}/append-bootstrap.64)"
