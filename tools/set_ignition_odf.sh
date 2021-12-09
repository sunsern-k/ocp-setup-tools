echo "Setting $RHCOS_ODF - guestinfo.ignition.config.data => the content of ${OCP_DIR}/worker.64"
govc vm.change -vm $RHCOS_ODF -e "guestinfo.ignition.config.data=$(cat ${OCP_DIR}/worker.64)"