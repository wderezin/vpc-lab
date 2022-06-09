#!/bin/bash

echo " *** Installing the web server ***"

while test -f /var/run/yum.pid
do
  echo "Waiting for YUM lock to be free"
  sleep 5
done

yum install -y httpd

INDEX=/var/www/html/index.html

cat > $INDEX <<EOF
<h1>Hello There,</h1>
<p>my local ip:
EOF
curl http://169.254.169.254/latest/meta-data/local-ipv4  >> $INDEX
echo "</p>" >> $INDEX

chmod 644 $INDEX

systemctl start  httpd
