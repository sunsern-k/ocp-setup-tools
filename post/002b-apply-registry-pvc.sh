if [ -f ${OCP_POST}/${registry_pvc_config} ]
then
  echo "Applying ${OCP_POST}/${registry_pvc_config}..."
  cat ${OCP_POST}/${registry_pvc_config}
  oc apply -f ${OCP_POST}/${registry_pvc_config}
else
  echo "[Skipped] - Not found any registry pvc config."
fi