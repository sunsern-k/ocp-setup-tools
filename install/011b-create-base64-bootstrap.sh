echo "Copying the bootstrap.ign to the $helper server.."
sudo cp ${OCP_DIR}/bootstrap.ign /var/www/html
sudo chmod 644 /var/www/html/bootstrap.ign 
sudo ls -l /var/www/html/bootstrap.ign

echo "Create the append-boottrap.ign.."

cat <<END > $HOME/append-bootstrap.ign
{
  "ignition": {
      "config": {
          "merge": [
              {
                  "source": "http://${HTTP_HOST}/bootstrap.ign",
                  "verification": {}
              }
          ]
      },
      "timeout": {},
      "version": "3.1.0"
  },
  "network": {},
  "passwd": {},
  "storage": {},
  "systemd": {}
}
END

cat $HOME/append-bootstrap.ign

echo "Creating the based64-encoded append-bootstrap.."
cat $HOME/append-bootstrap.ign | base64 -w0 > $HOME/append-bootstrap.64
ls -l $HOME/append-bootstrap*
