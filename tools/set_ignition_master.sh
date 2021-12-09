echo "Setting $RHCOS_MASTER - guestinfo.ignition.config.data => the content of ${OCP_DIR}/master.64"
govc vm.change -vm $RHCOS_MASTER -e "guestinfo.ignition.config.data=$(cat ${OCP_DIR}/master.64)"
