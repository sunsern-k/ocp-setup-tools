for node in master0
do
  for i in {0..2}
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
