if [ -f "${monitoring_config}" ]
then
  echo "Applying ${monitoring_config}..."
  oc apply -f  ${monitoring_config}
else
  echo "[Skipped]: Unable to find the cluster monitoring config"
fi
