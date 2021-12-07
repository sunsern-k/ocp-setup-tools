for i in {0..1}
do
  govc vm.clone -vm $RHCOS_WORKER -on=false worker${i}.${OCP_DOMAIN}
done
