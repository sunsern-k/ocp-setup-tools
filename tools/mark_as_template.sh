# Accept one of the following parameters
# template, bootstrap, master, infra-int, infra-mgt, logmon, odf, or worker

t=$1

case $t in

  template) 
               echo "Marking $RHCOS_TEMPLATE as VM template.."
 	       govc vm.markastemplate $RHCOS_TEMPLATE
               ;;
  bootstrap) 
               echo "Marking $RHCOS_BOOTSTRAP as VM template.."
 	       govc vm.markastemplate $RHCOS_BOOTSTRAP
               ;;
  master) 
               echo "Marking $RHCOS_MASTER as VM template.."
	       govc vm.markastemplate $RHCOS_MASTER
               ;;
  infra-int) 
               echo "Marking $RHCOS_INFRA_INT as VM template.."
	       govc vm.markastemplate $RHCOS_INFRA_INT
               ;;
  infra-mgt) 
               echo "Marking $RHCOS_INFRA_MGT as VM template.."
	       govc vm.markastemplate $RHCOS_INFRA_MGT
               ;;
  logmon) 
               echo "Marking $RHCOS_LOGMON as VM template.."
	       govc vm.markastemplate $RHCOS_LOGMON
               ;;
  odf) 
               echo "Marking $RHCOS_ODF as VM template.."
	       govc vm.markastemplate $RHCOS_ODF
               ;;
  worker) 
               echo "Marking $RHCOS_WORKER as VM template.."
	       govc vm.markastemplate $RHCOS_WORKER
               ;;
  *) 
               echo "Please speficy one of the options: template, bootstrap, master, infra-int, infra-mgt, logmon, odf, or worker"
               ;;
esac
