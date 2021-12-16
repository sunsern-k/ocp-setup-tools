
# Adjust a number of nodes as appropriate
for i in $(seq -s' ' $worker_count)
do
  # DNS record
  vmfqdn="worker0${i}.${OCP_DOMAIN}"

  # VM name on vCenter 
  # Ex: VMname is a DNS record
  # vmname_prefix="odf0"
  # vmname_suffix=".${OCP_DOMAIN}"
  # vmname="${vmname_prefix}${i}${vmname_suffix}"
  
  # EX: Customized VM name:  OCP_Int_Workerx_<IP_oct3>.<IP_oct4>
  vmname_prefix="OCP_Int_Worker0"
  vmname_suffix="$(dig +noall +answer @${dnsserver} +short $vmfqdn | cut -d. -f3,4)"
  vmname="${vmname_prefix}${i}_${vmname_suffix}"
  
  
  nip=$(dig +noall +answer @${dnsserver} +short $h)
  gw="$gateway"
  nm="$netmask"
  export IPCFG="ip=${nip}::${gw}:${nm}:${h}:ens192:none nameserver=${dnsserver}"

  # For DHCP
  # export IPCFG="ip=ens192:dhcp nameserver=${dnsserver}" 

  echo "Setting IP: $vmname -> $IPCFG"
  echo govc vm.change -vm $vmname -e "guestinfo.afterburn.initrd.network-kargs=${IPCFG}"
  govc vm.change -vm $vmname -e "guestinfo.afterburn.initrd.network-kargs=${IPCFG}"
done 
