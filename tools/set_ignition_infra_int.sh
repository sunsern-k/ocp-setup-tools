echo "Setting $RHCOS_INFRA_INT - guestinfo.ignition.config.data => the content of ${OCP_DIR}/worker.64"
govc vm.change -vm $RHCOS_INFRA_INT -e "guestinfo.ignition.config.data=$(cat ${OCP_DIR}/worker.64)"
