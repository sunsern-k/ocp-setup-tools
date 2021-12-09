echo "Setting $RHCOS_WORKER - guestinfo.ignition.config.data => the content of ${OCP_DIR}/worker.64"
govc vm.change -vm $RHCOS_WORKER -e "guestinfo.ignition.config.data=$(cat ${OCP_DIR}/worker.64)"
