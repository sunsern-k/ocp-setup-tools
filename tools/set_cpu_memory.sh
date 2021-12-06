govc vm.change -vm $RHCOS_WORKER -c 2 -m 8192 
govc vm.change -vm $RHCOS_MASTER -c 4 -m 16384
govc vm.change -vm $RHCOS_BOOTSTRAP -c 2 -m 8096
