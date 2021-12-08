if [ -f ${logging_config} ]
then
  echo "Applying ${logging_config}..."
  oc apply -f  ${logging_config}
else
  echo "[Skipped]: Unable to find the logging config"
fi