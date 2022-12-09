FROM php:8.1-fpm-alpine

WORKDIR /

COPY . ./

RUN set -ux \
    && apk add \
        git \
        p7zip \
        unzip \
    && cp $PHP_INI_DIR/php.ini-production $PHP_INI_DIR/php.ini \
    && curl -sSLf -o /usr/local/bin/install-php-extensions \
        "https://github.com/mlocati/docker-php-extension-installer/releases/latest/download/install-php-extensions" \
    && chmod +x /usr/local/bin/install-php-extensions \
    && apk add --no-cache nginx \
    && install-php-extensions \
        bcmath \
        bz2 \
        intl \
        pcntl \
        zip \
        opcache \
    && curl -sSf "https://getcomposer.org/installer" | php -- \
        --filename=composer \
        --install-dir=/usr/local/bin
