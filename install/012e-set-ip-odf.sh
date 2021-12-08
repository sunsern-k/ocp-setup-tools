for node in odf0
do
  # Adjust a number of nodes
  for i in {1..3}
  do
    h="${node}${i}.${OCP_DOMAIN}"
    nip=$(dig +noall +answer @${dnsserver} +short $h)
    gw="$gateway"
    nm="$netmask"
    export IPCFG="ip=${nip}::${gw}:${nm}:${h}:ens192:none nameserver=${dnsserver}"

    # For DHCP
    # export IPCFG="ip=ens192:dhcp nameserver=${dnsserver}" 
  
    echo $IPCFG
    govc vm.change -vm "$h" -e "guestinfo.afterburn.initrd.network-kargs=${IPCFG}"
  done 
done



for i in {1..3}
do
  # VM name on vCenter 
  vmname_prefix=""
  vmname_subfix=""
  vmname="${vmname_prefix:odf}${i}${vmname_subfix}"
  
  # DNS record
  vmfqdn="odf0"${i}.${OCP_DOMAIN}
  
  # Searching for an IP address from DNS
  nip=$(dig +noall +answer @${dnsserver} +short $vmfqdn)
  gw="$gateway"
  nm="$netmask"
  export IPCFG="ip=${nip}::${gw}:${nm}:${vmfqdn}:ens192:none nameserver=${dnsserver}"

  # For DHCP
  # export IPCFG="ip=ens192:dhcp nameserver=${dnsserver}"

  echo "Setting IP: $vmname -> $IPCFG"
  govc vm.change -vm "$vmname" -e "guestinfo.afterburn.initrd.network-kargs=${IPCFG}"
done 