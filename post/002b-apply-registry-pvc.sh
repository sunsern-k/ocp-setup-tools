if [ -f ${registry_pvc_config} ]
then
  echo "Applying ${registry_pvc_config}..."
  cat ${registry_pvc_config}
  oc apply -f ${registry_pvc_config}
else
  echo "[Skipped] - Not found any registry pvc config."
fi