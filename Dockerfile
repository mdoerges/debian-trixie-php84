FROM debian:trixie-slim

RUN apt-get update
RUN apt-get -y upgrade
RUN apt-get install --no-install-suggests -y ca-certificates php8.4 php8.4-fpm php8.4-common \
    php8.4-mysql php8.4-zip php8.4-gd php8.4-mbstring php8.4-curl php8.4-sqlite3 \
    php8.4-bcmath php8.4-xml php8.4-intl php8.4-tidy php8.4-ldap php-common php-imagick imagemagick composer

RUN echo "[www]" > /etc/php/8.4/fpm/pool.d/www.conf \
    && echo "user = www-data" >> /etc/php/8.4/fpm/pool.d/www.conf \
    && echo "group = www-data" >> /etc/php/8.4/fpm/pool.d/www.conf \
    && echo "listen = 0.0.0.0:9000" >> /etc/php/8.4/fpm/pool.d/www.conf \
    && echo "listen.owner = www-data" >> /etc/php/8.4/fpm/pool.d/www.conf \
    && echo "listen.group = www-data" >> /etc/php/8.4/fpm/pool.d/www.conf \
    && echo "pm = dynamic" >> /etc/php/8.4/fpm/pool.d/www.conf \
    && echo "pm.max_children = 5" >> /etc/php/8.4/fpm/pool.d/www.conf \
    && echo "pm.start_servers = 2" >> /etc/php/8.4/fpm/pool.d/www.conf \
    && echo "pm.min_spare_servers = 1" >> /etc/php/8.4/fpm/pool.d/www.conf \
    && echo "pm.max_spare_servers = 3" >> /etc/php/8.4/fpm/pool.d/www.conf

RUN echo "daemonize = no" > /etc/php/8.4/fpm/php-fpm.conf \
    && echo "include=/etc/php/8.4/fpm/pool.d/*.conf" >> /etc/php/8.4/fpm/php-fpm.conf
RUN echo "max_execution_time = 200" >> /etc/php/8.4/fpm/php.ini \
    && echo "post_max_size = 100M" >> /etc/php/8.4/fpm/php.ini \
    && echo "upload_max_filesize = 20M" >> /etc/php/8.4/fpm/php.ini \
    && echo "memory_limit = 256M" >> /etc/php/8.4/fpm/php.ini

RUN apt-get clean && rm -rf /var/lib/apt/lists/*
CMD ["php-fpm8.4"]
