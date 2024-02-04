FROM alpine:3.16

ARG PHP=php8 \
    MYSQL_NAME \
    MYSQL_USER \
    MYSQL_NAME
    
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
    ${PHP}-redis \
    wget \
    unzip && \
    sed -i "s|listen = 127.0.0.1:9000|listen = 9000|g" \
      /etc/${PHP}/php-fpm.d/www.conf && \
    sed -i "s|;listen.owner = nobody|listen.owner = nobody|g" \
      /etc/${PHP}/php-fpm.d/www.conf && \
    sed -i "s|;listen.group = nobody|listen.group = nobody|g" \
      /etc/${PHP}/php-fpm.d/www.conf && \
    rm -f /var/cache/apk/*

WORKDIR /var/www

RUN wget https://wordpress.org/latest.zip && \
    unzip latest.zip && \
    cp -rf wordpress/* . && \
    rm -rf wordpress latest.zip

COPY ./requirements/wordpress/conf/wp_config.sh .

RUN sh wp_config.sh && \
    rm wp_config.sh && \
    chmod -R 0777 wp-content/

CMD ["/usr/sbin/php-fpm8", "-F"]