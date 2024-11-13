# install cacti
git clone -b release/$CACTI_VERSION https://github.com/Cacti/cacti.git
mv cacti /var/www/html
sed "s/^\$database_hostname.*/\$database_hostname = 'mysql-server';/g" /var/www/html/cacti/include/config.php.dist > /var/www/html/cacti/include/config.php
chown -R www-data.www-data /var/www/html/cacti/

# install monitoring plugins
curl https://storage.googleapis.com/google-code-archive-downloads/v2/code.google.com/mysql-cacti-templates/better-cacti-templates-1.1.8.tar.gz | tar xzf -
cp better-cacti-templates-1.1.8/scripts/*.php /var/www/html/cacti/scripts
# patch script for php 7.x or later
sed -i "s/extension_loaded('mysql')/extension_loaded('mysqli')/g" /var/www/html/cacti/scripts/ss_get_mysql_stats.php
sed -i "s/mysql_error()/mysqli_connect_error()/g" /var/www/html/cacti/scripts/ss_get_mysql_stats.php
sed -i "s/\$conn = mysql_connect(/\$conn = mysqli_connect(/g" /var/www/html/cacti/scripts/ss_get_mysql_stats.php
sed -i "s/@mysql_/@mysqli_/g" /var/www/html/cacti/scripts/ss_get_mysql_stats.php
sed -i "s/@mysqli_query.*/@mysqli_query(\$conn, \$sql);/g" /var/www/html/cacti/scripts/ss_get_mysql_stats.php
sed -i "251 a\   if (empty(\$user)) \$user = \$mysql_user;" /var/www/html/cacti/scripts/ss_get_mysql_stats.php
sed -i "252 a\   if (empty(\$pass)) \$pass = \$mysql_pass;" /var/www/html/cacti/scripts/ss_get_mysql_stats.php
sed -i "253 a\   if (empty(\$port)) \$port = \$mysql_port;" /var/www/html/cacti/scripts/ss_get_mysql_stats.php
# update ssh public key location
sed -i "s/^\$ssh_iden.*/\$ssh_iden   = '-i \/root\/.ssh\/id_rsa';  # SSH identity/g" /var/www/html/cacti/scripts/ss_get_by_ssh.php
# update free command option
sed -i "s/free -ob/free -b/g" /var/www/html/cacti/scripts/ss_get_by_ssh.php
# patch script: used memory
sed -i "s/\$result\['STAT_memused'\].*/\$result\['STAT_memused'\]   = \$words\[2\];/g" /var/www/html/cacti/scripts/ss_get_by_ssh.php
sed -i "s/\$words\[2\] - \$words\[4\] - \$words\[5\]/\# \$words\[2\] - \$words\[4\] - \$words\[5\]/g" /var/www/html/cacti/scripts/ss_get_by_ssh.php

# replace index page
rm -rf /var/www/html/index.html
echo "<?php header('Location: ./cacti'); ?>" > /var/www/html/index.php
