
for i in {1..2}
do
  # VM name on vCenter 
  vmname_prefix=""
  vmname_subfix=""
  vmname="${vmname_prefix:log}${i}${vmname_subfix}"
  
  # DNS record
  vmfqdn="log0"${i}.${OCP_DOMAIN}
  
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