cat <<END > $registry_pvc_config
kind: PersistentVolumeClaim
apiVersion: v1
metadata:
  name: image-registry-storage 
  namespace: openshift-image-registry 
spec:
  storageClassName: ${registry_storageclass}
  accessModes:
  - ${registry_storage_mode}
  resources:
    requests:
      storage: ${registry_storage_size}
END
