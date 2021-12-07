for i in {0..2}
do
  govc vm.clone -vm $RHCOS_MASTER -on=false master${i}.${OCP_DOMAIN}
done
