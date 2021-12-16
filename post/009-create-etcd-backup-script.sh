is_project_created=$(oc projects -q | grep $etcd_backup_project)

# Prepare a backup project 
if [ "$is_project_created" = "" ]
then 
  echo "Creating the etcd backup project: ${etcd_backup_project}.."
  echo "oc new-project $etcd_backup_project"
  oc new-project $etcd_backup_project
else
  echo "The etcd backup project: $is_project_created has been created."
  oc project $etcd_backup_project
fi

# Create a service account
echo "Creating the SA of etcd backup: ${etcd_backup_sa_config}..."

cat <<END > ${OCP_POST}/$etcd_backup_sa_config
kind: ServiceAccount
apiVersion: v1
metadata:
  name: openshift-backup
  namespace: $etcd_backup_project
  labels:
    app: openshift-backup
END
echo "oc create -f ${OCP_POST}/$etcd_backup_sa_config"
oc apply -f ${OCP_POST}/$etcd_backup_sa_config

# Create ClusterRole 
cat <<END > ${OCP_POST}/$etcd_backup_clusterrole
apiVersion: rbac.authorization.k8s.io/v1
kind: ClusterRole
metadata:
  name: cluster-etcd-backup
rules:
- apiGroups: [""]
  resources:
     - "nodes"
  verbs: ["get", "list"]
- apiGroups: [""]
  resources:
     - "pods"
     - "pods/log"
  verbs: ["get", "list", "create", "delete", "watch"]
END
echo "oc create -f ${OCP_POST}/$etcd_backup_clusterrole"
oc apply -f ${OCP_POST}/$etcd_backup_clusterrole

# Create clusterrolebinding

cat <<END > ${OCP_POST}/$etcd_backup_clusterrolebinding
kind: ClusterRoleBinding
apiVersion: rbac.authorization.k8s.io/v1
metadata:
  name: openshift-backup
  labels:
    app: openshift-backup
subjects:
  - kind: ServiceAccount
    name: openshift-backup
    namespace: $etcd_backup_project
roleRef:
  apiGroup: rbac.authorization.k8s.io
  kind: ClusterRole
  name: cluster-etcd-backup
END
echo "oc create -f ${OCP_POST}/$etcd_backup_clusterrolebinding"
oc apply -f ${OCP_POST}/$etcd_backup_clusterrolebinding

# Create etcd backup cron job
if [ ! -f $etcd_backup_cronjob ]
then 
  echo "Pleaes prepare and update NFS server in the $etcd_backup_cronjob and run the following command "
  echo "oc create -f $etcd_backup_cronjob"
else
  echo "Applying the $etcd_backup_cronjob"
  echo "oc create -f $etcd_backup_cronjob"
  oc apply -f $etcd_backup_cronjob
fi