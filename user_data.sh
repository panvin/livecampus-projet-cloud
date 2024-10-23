#!/bin/bash
yum update -y
yum install -y nginx php php-fpm php-mysqlnd php-opcache php-gd php-xml php-mbstring php-curl

# Install php-imagick on Amazon Linux
yum -y install php-pear php-devel gcc ImageMagick ImageMagick-devel
bash -c "yes '' | pecl install -f imagick"
bash -c "echo 'extension=imagick.so' > /etc/php.d/imagick.ini"

# Install php-pecl-zip on Amazon Linux
yum -y install libzip libzip-devel

# Will enable zip extension in /etc/php.ini
pecl upgrade zip 

iterator=0
while [ $iterator -lt 10 ]
do
    wget https://wordpress.org/wordpress-${wp_version}.zip -O wordpress.zip
    wget https://wordpress.org/wordpress-${wp_version}.zip.md5 -O wordpress.zip.md5
    md5sum wordpress.zip | cut -d " " -f 1 | tr -d "\n" > sum.md5

    if cmp -s sum.md5 wordpress.zip.md5 
    then
        break
    else
        ((iterator++))
    fi

    sleep 20
    if [ $iterator == '10' ] 
    then
        exit 1;
    fi
done

unzip wordpress.zip -d /usr/share/nginx/html/
mv /usr/share/nginx/html/wordpress /usr/share/nginx/html/foodbox-wordpress
chown nginx:nginx /usr/share/nginx/html/foodbox-wordpress
cp /usr/share/nginx/html/foodbox-wordpress/wp-config-sample.php /usr/share/nginx/html/foodbox-wordpress/wp-config.php

# Settings php-fpm
sed -i -e 's/user = apache/user = nginx/g' /etc/php-fpm.d/www.conf
sed -i -e 's/group = apache/group = nginx/g' /etc/php-fpm.d/www.conf

# Settings Wordpress
sed -i -e 's/database_name_here/${db_name}/g' /usr/share/nginx/html/foodbox-wordpress/wp-config.php
sed -i -e 's/username_here/${db_user}/g' /usr/share/nginx/html/foodbox-wordpress/wp-config.php
sed -i -e 's/password_here/${db_password}/g' /usr/share/nginx/html/foodbox-wordpress/wp-config.php
sed -i -e 's/localhost/${db_endpoint}/g' /usr/share/nginx/html/foodbox-wordpress/wp-config.php

# Settings nginx
sed -i -e 's/html;/html\/foodbox-wordpress;/g' /etc/nginx/nginx.conf

# Adding website configuration
cat > /etc/nginx/conf.d/foodbox-wordpress.conf << EOF
server {
    listen 80;

    server_name example.com;
    root /usr/share/nginx/html/foodbox-wordpress;
    index index.php index.html index.htm;

    location / {
        try_files \$uri \$uri/ /index.php?\$args;
    }

    location = /favicon.ico {
        log_not_found off;
        access_log off;
    }

    location ~* \.(js|css|png|jpg|jpeg|gif|ico)$ {
        expires max;
        log_not_found off;
    }

    location = /robots.txt {
        allow all;
        log_not_found off;
        access_log off;
    }

    location ~ \.php$ {
        include /etc/nginx/fastcgi_params;
        fastcgi_pass unix:/run/php-fpm/www.sock;
        fastcgi_index index.php;
        fastcgi_param SCRIPT_FILENAME \$document_root\$fastcgi_script_name;
    }
}
EOF

# Disable default website
cat > /etc/nginx/nginx.conf << EOF
# For more information on configuration, see:
#   * Official English Documentation: http://nginx.org/en/docs/
#   * Official Russian Documentation: http://nginx.org/ru/docs/

user nginx;
worker_processes auto;
error_log /var/log/nginx/error.log notice;
pid /run/nginx.pid;

# Load dynamic modules. See /usr/share/doc/nginx/README.dynamic.
include /usr/share/nginx/modules/*.conf;

events {
    worker_connections 1024;
}

http {
    log_format  main  '\$remote_addr - \$remote_user [\$time_local] "\$request" '
                      '\$status \$body_bytes_sent "\$http_referer" '
                      '"\$http_user_agent" "\$http_x_forwarded_for"';

    access_log  /var/log/nginx/access.log  main;

    sendfile            on;
    tcp_nopush          on;
    keepalive_timeout   65;
    types_hash_max_size 4096;

    include             /etc/nginx/mime.types;
    default_type        application/octet-stream;

    # Load modular configuration files from the /etc/nginx/conf.d directory.
    # See http://nginx.org/en/docs/ngx_core_module.html#include
    # for more information.
    include /etc/nginx/conf.d/*.conf;

}
EOF

systemctl start php-fpm
systemctl enable php-fpm
systemctl start nginx
systemctl enable nginx