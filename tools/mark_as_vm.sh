govc vm.markasvm -host $vcenterhost $RHCOS_BOOTSTRAP
govc vm.markasvm -host $vcenterhost $RHCOS_MASTER 
govc vm.markasvm -host $vcenterhost $RHCOS_WORKER
