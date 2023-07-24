# set cacti db
mysql -p$MYSQL_ROOT_PASSWORD -e 'CREATE DATABASE cacti DEFAULT CHARACTER SET utf8 COLLATE utf8_unicode_ci'
mysql -p$MYSQL_ROOT_PASSWORD -e "CREATE USER 'cactiuser'@'%' IDENTIFIED BY 'cactiuser'"
mysql -p$MYSQL_ROOT_PASSWORD -e "GRANT ALL PRIVILEGES ON cacti.* TO 'cactiuser'@'%'"
mysql -p$MYSQL_ROOT_PASSWORD -e "GRANT SUPER ON *.* TO 'cactiuser'@'%'"
mysql -p$MYSQL_ROOT_PASSWORD -e "GRANT SELECT ON mysql.time_zone_name TO 'cactiuser'@'%'"
mysql -p$MYSQL_ROOT_PASSWORD -e "ALTER DATABASE cacti CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci"
mysql -p$MYSQL_ROOT_PASSWORD -e "FLUSH PRIVILEGES"

# install cacti
curl https://raw.githubusercontent.com/Cacti/cacti/release/$CACTI_VERSION/cacti.sql | mysql -p$MYSQL_ROOT_PASSWORD cacti
