for node in infra0
do
  # Adjust a number of nodes
  for i in {1..5}
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
