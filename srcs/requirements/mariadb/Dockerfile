FROM alpine:3.16

ENV PHP=php8 \
    MYSQL_NAME=${MYSQL_NAME} \
    MYSQL_USER=${MYSQL_USER} \
    MYSQL_PASSWORD=${MYSQL_PASSWORD}

RUN apk update && apk add --no-cache mariadb mariadb-client

#Disables the host cache
#Disables DNS host name
#Binds the MariaDB server to all available network
#Tee writes it to a file
#Replaces networking settings allowing network connections to the MariaDB
RUN mkdir /var/run/mysqld; \
    chmod 777 /var/run/mysqld; \
    { echo '[mysqld]'; \
      echo 'skip-host-cache'; \
      echo 'skip-name-resolve'; \
      echo 'bind-address=0.0.0.0'; \
    } | tee  /etc/my.cnf.d/docker.cnf; \
    sed -i "s|skip-networking|skip-networking=0|g" \
      /etc/my.cnf.d/mariadb-server.cnf

RUN mysql_install_db --user=mysql --datadir=/var/lib/mysql

#Allows container to use port 3306
EXPOSE 3306

#Runs the MySQL(database management) server process as the "mysql" user.
USER mysql
CMD ["/usr/bin/mysqld"]