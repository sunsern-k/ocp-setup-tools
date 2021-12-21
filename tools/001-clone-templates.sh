
# Accept one of the following parameters
# bootstrap, master, infra-int, infra-mgt, logmon, odf, or worker

t=$1


case $t in

  bootstrap) 
               echo "Cloning $RHCOS_TEMPLATE -> $RHCOS_BOOTSTRAP"
 	       echo govc vm.clone -template=true -vm "$RHCOS_TEMPLATE"  $RHCOS_BOOTSTRAP
 	       govc vm.clone -template=true -vm "$RHCOS_TEMPLATE"  $RHCOS_BOOTSTRAP
               ;;
  master) 
               echo "Cloning $RHCOS_TEMPLATE -> $RHCOS_MASTER"
	       echo govc vm.clone -template=true -vm "$RHCOS_TEMPLATE"  $RHCOS_MASTER
	       govc vm.clone -template=true -vm "$RHCOS_TEMPLATE"  $RHCOS_MASTER
               ;;
  infra-int) 
               echo "Cloning $RHCOS_TEMPLATE -> $RHCOS_INFRA_INT"
               echo govc vm.clone -template=true -vm "$RHCOS_TEMPLATE"  $RHCOS_INFRA_INT
               govc vm.clone -template=true -vm "$RHCOS_TEMPLATE"  $RHCOS_INFRA_INT
               ;;
  infra-mgt) 
               echo "Cloning $RHCOS_TEMPLATE -> $RHCOS_INFRA_MGT"
               echo govc vm.clone -template=true -vm "$RHCOS_TEMPLATE"  $RHCOS_INFRA_MGT
               govc vm.clone -template=true -vm "$RHCOS_TEMPLATE"  $RHCOS_INFRA_MGT
               ;;
  logmon) 
               echo "Cloning $RHCOS_TEMPLATE -> $RHCOS_LOGMON"
               echo govc vm.clone -template=true -vm "$RHCOS_TEMPLATE"  $RHCOS_LOGMON
               govc vm.clone -template=true -vm "$RHCOS_TEMPLATE"  $RHCOS_LOGMON
               ;;
  odf) 
               echo "Cloning $RHCOS_TEMPLATE -> $RHCOS_ODF"
               echo govc vm.clone -template=true -vm "$RHCOS_TEMPLATE"  $RHCOS_ODF
               govc vm.clone -template=true -vm "$RHCOS_TEMPLATE"  $RHCOS_ODF
               ;;
  worker) 
               echo "Cloning $RHCOS_TEMPLATE -> $RHCOS_WORKER"
               echo govc vm.clone -template=true -vm "$RHCOS_TEMPLATE"  $RHCOS_WORKER 
               govc vm.clone -template=true -vm "$RHCOS_TEMPLATE"  $RHCOS_WORKER 
               ;;
  *) 
               echo "Please speficy one of the options: bootstrap, master, infra-int, infra-mgt, logmon, odf, or worker"
               ;;
esac

