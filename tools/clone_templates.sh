
govc vm.clone -template=true -vm "$RHCOS_TEMPLATE"  $RHCOS_BOOTSTRAP
govc vm.clone -template=true -vm "$RHCOS_TEMPLATE"  $RHCOS_MASTER
govc vm.clone -template=true -vm "$RHCOS_TEMPLATE"  $RHCOS_WORKER
govc vm.clone -template=true -vm "$RHCOS_TEMPLATE"  $RHCOS_INFRA_INT
govc vm.clone -template=true -vm "$RHCOS_TEMPLATE"  $RHCOS_INFRA_MON
govc vm.clone -template=true -vm "$RHCOS_TEMPLATE"  $RHCOS_ODF

