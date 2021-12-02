cat ${OCP_DIR}/master.ign | base64 -w0  > ${OCP_DIR}/master.64
cat ${OCP_DIR}/worker.ign | base64 -w0  > ${OCP_DIR}/worker.64
ls -l ${OCP_DIR}/*.64
