FROM alpine:3.16

ENV PHP=php8 \
    MYSQL_NAME=${MYSQL_NAME} \
    MYSQL_USER=${MYSQL_USER} \
    MYSQL_PASSWORD=${MYSQL_PASSWORD}

#Installs packages of PHP
#FPM handles PHP scripts efficiently using fast-cgi for web servers.
RUN apk update && apk upgrade && apk add --no-cache \
    ${PHP} \
    ${PHP}-fpm \
    ${PHP}-mysqli \
    ${PHP}-json \
    ${PHP}-curl \
    ${PHP}-dom \
    ${PHP}-exif \
    ${PHP}-fileinfo \
    ${PHP}-mbstring \
    ${PHP}-openssl \
    ${PHP}-xml \
    ${PHP}-zip \
    wget \
    unzip && \
    sed -i "s|listen = 127.0.0.1:9000|listen = 9000|g" \
      /etc/${PHP}/php-fpm.d/www.conf && \
    sed -i "s|;listen.owner = nobody|listen.owner = nobody|g" \
      /etc/${PHP}/php-fpm.d/www.conf && \
    sed -i "s|;listen.group = nobody|listen.group = nobody|g" \
      /etc/${PHP}/php-fpm.d/www.conf && \
    rm -f /var/cache/apk/*

#Sets the current working directory
WORKDIR /var/www

#web get & copy & delete
RUN wget https://wordpress.org/latest.zip && \
    unzip latest.zip && \
    cp -rf wordpress/* . && \
    rm -rf wordpress latest.zip

#Grants full access permissions to everyone in wp-content/
RUN chmod -R 0777 wp-content/

#Starts the PHP FastCGI Process Manager in the foreground when the container is launched
CMD ["/usr/sbin/php-fpm8", "-F"]