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

cat <<END >$etcd_backup_sa_config
kind: ServiceAccount
apiVersion: v1
metadata:
  name: openshift-backup
  namespace: $etcd_backup_project
  labels:
    app: openshift-backup
END
echo "oc create -f $etcd_backup_sa_config"
oc apply -f $etcd_backup_sa_config

# Create ClusterRole 
cat <<END > $etcd_backup_clusterrole
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
echo "oc create -f $etcd_backup_clusterrole"
oc apply -f $etcd_backup_clusterrole

# Create clusterrolebinding

cat <<END > $etcd_backup_clusterrolebinding
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
echo "oc create -f $etcd_backup_clusterrolebinding"
oc apply -f $etcd_backup_clusterrolebinding

# Create etcd backup cron job
cat <<END > $etcd_backup_cronjob
apiVersion: batch/v1
kind: CronJob
metadata:
  name: openshift-backup
  namespace: $etcd_backup_project
  labels:
    app: openshift-backup
spec:
  schedule: "0 * * * *"
  concurrencyPolicy: Forbid
  successfulJobsHistoryLimit: 5
  failedJobsHistoryLimit: 5
  jobTemplate:
    metadata:
      labels:
        app: openshift-backup
    spec:
      backoffLimit: 0
      template:
        metadata:
          labels:
            app: openshift-backup
        spec:
          containers:
            - name: backup
              image: "registry.redhat.io/openshift4/ose-cli:latest"
              command:
                - "/bin/bash"
                - "-c"
                - oc get no -l node-role.kubernetes.io/master --no-headers -o name | head -n 1 | while read node; do oc debug $node -- bash -c "chroot /host &&  sudo -E  mount -t nfs $etcd_backup_nfs_path  /home/core/backup && chroot /host sudo -E /usr/local/bin/cluster-backup.sh /home/core/backup && chroot /host sudo -E find /home/core/backup/ -type f -mmin +1 -delete"; done
          restartPolicy: "Never"
          terminationGracePeriodSeconds: 30
          activeDeadlineSeconds: 500
          dnsPolicy: "ClusterFirst"
          serviceAccountName: "openshift-backup"
          serviceAccount: "openshift-backup"
END

echo "oc create -f $etcd_backup_cronjob"
oc apply -f $etcd_backup_cronjob