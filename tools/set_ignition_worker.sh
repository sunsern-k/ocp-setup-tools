govc vm.change -vm $RHCOS_MASTER -e "guestinfo.ignition.config.data=$(cat ${OCP_DIR}/worker.64)"
