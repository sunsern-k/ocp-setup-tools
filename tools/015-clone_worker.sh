for i in $(seq -s' ' $worker_count)
do
  # DNS record
  vmfqdn="worker0${i}.${OCP_DOMAIN}"

  # VM name on vCenter 
  # Ex: VMname is a DNS record
  # vmname_prefix="worker0"
  # vmname_suffix=".${OCP_DOMAIN}"
  # vmname="${vmname_prefix}${i}${vmname_suffix}"
  
  # EX: Customized VM name:  OCP_Int_Workerx_<IP_oct3>.<IP_oct4>
  vmname_prefix="OCP_Int_Worker0"
  vmname_suffix="$(dig +noall +answer @${dnsserver} +short $vmfqdn | cut -d. -f3,4)"
  vmname="${vmname_prefix}${i}_${vmname_suffix}"

  govc vm.clone -vm $RHCOS_WORKER -on=false $vmname
done
