#PREFIX="OCP_Int_Bootstrap_"
#SUFFIX=""
govc vm.clone -vm $RHCOS_BOOTSTRAP -on=false bootstrap.${OCP_DOMAIN}
