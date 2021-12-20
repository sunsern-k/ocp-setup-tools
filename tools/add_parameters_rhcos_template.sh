govc vm.change -vm $RHCOS_TEMPLATE -e "disk.EnableUUID=TRUE" -e "guestinfo.ignition.config.data.encoding=base64"
