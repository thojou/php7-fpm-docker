FROM php:7-fpm-alpine

RUN apk add --update --no-cache --virtual .time \
    tzdata && \
    echo Europe/Berlin > /etc/timezone && \
    ln -sf /usr/share/zoneinfo/Europe/Berlin /etc/localtime && \
    apk del .time

RUN apk add --update --no-cache \
    bash \
    curl \
    icu-dev \
    libzip

RUN docker-php-ext-configure \
    intl

RUN docker-php-ext-install \
    intl \
    opcache \
    pdo_mysql 

RUN curl -sSL https://getcomposer.org/installer | php -- --install-dir=/usr/bin --filename=composer

COPY php.ini /etc/php7/conf.d/
COPY php.ini /etc/php7/cli/conf.d/
