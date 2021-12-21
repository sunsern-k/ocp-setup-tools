# Accept one of the following parameters
# template, bootstrap, master, infra-int, infra-mgt, logmon, odf, or worker

t=$1

case $t in

  template)
               echo "Marking $RHCOS_TEMPLATE as VM.."
 	       govc vm.markasvm $RHCOS_TEMPLATE
               ;;
  bootstrap) 
               echo "Marking $RHCOS_BOOTSTRAP as VM.."
 	       govc vm.markasvm $RHCOS_BOOTSTRAP
               ;;
  master) 
               echo "Marking $RHCOS_MASTER as VM.."
	       govc vm.markasvm $RHCOS_MASTER
               ;;
  infra-int) 
               echo "Marking $RHCOS_INFRA_INT as VM.."
	       govc vm.markasvm $RHCOS_INFRA_INT
               ;;
  infra-mgt) 
               echo "Marking $RHCOS_INFRA_MGT as VM.."
	       govc vm.markasvm $RHCOS_INFRA_MGT
               ;;
  logmon) 
               echo "Marking $RHCOS_LOGMON as VM.."
	       govc vm.markasvm $RHCOS_LOGMON
               ;;
  odf) 
               echo "Marking $RHCOS_ODF as VM.."
	       govc vm.markasvm $RHCOS_ODF
               ;;
  worker) 
               echo "Marking $RHCOS_WORKER as VM.."
	       govc vm.markasvm $RHCOS_WORKER
               ;;
  *) 
               echo "Please speficy one of the options: template, bootstrap, master, infra-int, infra-mgt, logmon, odf, or worker"
               ;;
esac
