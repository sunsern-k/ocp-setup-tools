if [ "$registry_storageclass" = "" ] || [ "$registry_storage_mode" = "" ] || [ "$registry_storage_size" = "" ]
then 
  echo "Please verify that all required registry parameters are set."
  exit 1
else 
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
fi