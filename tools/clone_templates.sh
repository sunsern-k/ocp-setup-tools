export RHCOS_TEMPLATE="RHCOS-Template"
export RHCOS_BOOTSTRAP="RHCOS-Template-$clustername-boostrap"
export RHCOS_MASTER="RHCOS-Template-$clustername-master"
export RHCOS_WORKER="RHCOS-Template-$clustername-worker"
export RHCOS_INFRA_INT="RHCOS-Template-$clustername-infra-int"
export RHCOS_INFRA_MON="RHCOS-Template-$clustername-infra-mon"

govc vm.clone -template=true -vm "$RHCOS_TEMPLATE"  $RHCOS_BOOTSTRAP
govc vm.clone -template=true -vm "$RHCOS_TEMPLATE"  $RHCOS_MASTER
govc vm.clone -template=true -vm "$RHCOS_TEMPLATE"  $RHCOS_WORKER