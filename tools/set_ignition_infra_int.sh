is_vm=$1

[ "$start_infra_int" = "" ] && start_infra_int=1
# Consider infra_int may not running from infra01, infra02, and so on.
# If it is start from infra04 and the infra_int_count is 2 then they are infra04 and infra05
# Then run seq -s' '  <start> <end> ; where <end> is <start> + <infra_int_count> - 1

if [ "$is_vm" = "vm" ] || [ "$is_vm" = "VM" ]
then
  for i in $(seq -s' ' $start_infra_int $(($infra_int_count + $start_infra_int -1)) )
  do
    # DNS record
    vmfqdn="infra0"${i}.${OCP_DOMAIN}

    # VM name on vCenter
    # Ex: VMname is a DNS record
    # vmname_prefix="infra0"
    # vmname_suffix=".${OCP_DOMAIN}"
    # vmname="${vmname_prefix}${i}${vmname_suffix}"

    # EX: Customized VM name:  OCP_Int_Infrax_<IP_oct3>.<IP_oct4>
    vmname_prefix="OCP_Int_Infra0"
    vmname_suffix="$(dig +noall +answer @${dnsserver} +short $vmfqdn | cut -d. -f3,4)"
    vmname="${vmname_prefix}${i}_${vmname_suffix}"
 
    echo "Setting $vmname - guestinfo.ignition.config.data => the content of ${OCP_DIR}/worker.64"
    echo govc vm.change -vm $vmname -e "guestinfo.ignition.config.data=$(cat ${OCP_DIR}/worker.64)"
    govc vm.change -vm $vmname -e "guestinfo.ignition.config.data=$(cat ${OCP_DIR}/worker.64)"

  done
else
  echo "Setting $RHCOS_INFRA_INT - guestinfo.ignition.config.data => the content of ${OCP_DIR}/worker.64"
  echo govc vm.change -vm $RHCOS_INFRA_INT -e "guestinfo.ignition.config.data=$(cat ${OCP_DIR}/worker.64)"
  govc vm.change -vm $RHCOS_INFRA_INT -e "guestinfo.ignition.config.data=$(cat ${OCP_DIR}/worker.64)"
fi
