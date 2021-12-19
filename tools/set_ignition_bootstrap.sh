is_vm=$1

if [ "$is_vm" = "vm" ] || [ "$is_vm" = "VM" ]
then
  echo "Setting bootstrap.${OCP_DOMAIN} - guestinfo.ignition.config.data => the content of ${OCP_DIR}/append-bootstrap.64"
  govc vm.change -vm ${OCP_DOMAIN} -e "guestinfo.ignition.config.data=$(cat ${OCP_DIR}/append-bootstrap.64)"
else
  echo "Setting $RHCOS_BOOTSTRAP - guestinfo.ignition.config.data => the content of ${OCP_DIR}/append-bootstrap.64"
  govc vm.change -vm $RHCOS_BOOTSTRAP -e "guestinfo.ignition.config.data=$(cat ${OCP_DIR}/append-bootstrap.64)"
fi
