echo "Generating 99-worker-chrony.bu"
cat <<END > 99-worker-chrony.bu
variant: openshift
version: 4.9.0
metadata:
  name: 99-worker-chrony 
  labels:
    machineconfiguration.openshift.io/role: worker 
storage:
  files:
  - path: /etc/chrony.conf
    mode: 0644
    overwrite: true
    contents:
      inline: |
        pool ${ntpserver} iburst 
        driftfile /var/lib/chrony/drift
        makestep 1.0 3
        rtcsync
        logdir /var/log/chrony
END


echo "Generating 99-master-chrony.bu"
cat <<END > 99-master-chrony.bu
variant: openshift
version: 4.9.0
metadata:
  name: 99-master-chrony 
  labels:
    machineconfiguration.openshift.io/role: master 
storage:
  files:
  - path: /etc/chrony.conf
    mode: 0644
    overwrite: true
    contents:
      inline: |
        pool ${ntpserver} iburst 
        driftfile /var/lib/chrony/drift
        makestep 1.0 3
        rtcsync
        logdir /var/log/chrony
END

echo "Generating chrony configurations..."
butane 99-worker-chrony.bu -o ${OCP_DIR}/openshift/99_openshift-machineconfig_99-worker-chrony.yaml
butane 99-master-chrony.bu -o ${OCP_DIR}/openshift/99_openshift-machineconfig_99-master-chrony.yaml
chmod 640 ${OCP_DIR}/openshift/99_openshift-machineconfig_99-*.yaml
ls -l ${OCP_DIR}/openshift/99_openshift-machineconfig_99*chrony*
cat ${OCP_DIR}/openshift/99_openshift-machineconfig_99-worker-chrony.yaml
cat ${OCP_DIR}/openshift/99_openshift-machineconfig_99-master-chrony.yaml
