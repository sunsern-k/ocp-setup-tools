echo "Checking the ${OCP_DIR}/.openshift_install.log file..."
if [ -f ${OCP_DIR}/.openshift_install.log ]
then
  echo "Monitoring ${OCP_DIR}/.openshift_install.log..."
  tail -f ${OCP_DIR}/.openshift_install.log
else
  echo "[Info]: Not found the openshift install log - exited"
fi
