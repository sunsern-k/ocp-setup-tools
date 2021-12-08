govc vm.change -vm $RHCOS_WORKER -e "guestinfo.ignition.config.data=$(cat ${OCP_DIR}/worker.64)"
