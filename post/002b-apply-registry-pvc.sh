echo "Applying ${registry_pvc_config}..."
cat ${registry_pvc_config}
oc apply -f ${registry_pvc_config}
