if [ -f ${OCP_POST}/${logging_config} ]
then
  echo "Applying ${OCP_POST}/${logging_config}..."
  oc apply -f  ${OCP_POST}/${logging_config}
else
  echo "[Skipped]: Unable to find the logging config"
fi