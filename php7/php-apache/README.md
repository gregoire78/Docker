# 🐳 PHP 7  Docker dev image 🐘
Hi! This is my **Dockerfile** for php develop environnement.
It use the lastest version of PHP (Current build ***7.2.1***) for something of great again !
This Image include French language locale 🥖,  **wkhtmltopdf** (and wkhtmltoimage), **PDO**, **OpCache**, **Imagick**, **GD**,**xDebug** and include **Apache**.

## 🐋 Docker-compose 
You can easely integrate it to a docker-compose file 😁 !
```yml
web:
 image: greg78/php7-apache-xdebug
 ports:
  - "80:80"
 volumes:
  - /var/www:/var/www/html
  - /var/www/docker/php7/sites:/etc/apache2/sites-enabled
  - /var/www/docker/php7/php-apache/php.ini:/usr/local/etc/php/conf.d/30-custom.ini
 links:
  - db:db
  - mailhog:mailhog
db:
 image: mysql
 volumes:
  - /var/www/docker/mysql:/var/lib/mysql
 environment:
  - MYSQL_ROOT_PASSWORD=root
 ports:
  - "127.0.0.1:3306:3306"
mailhog:
 image: mailhog/mailhog
 ports: 
  - "1080:8025"
```
## <img src="https://getcomposer.org/img/logo-composer-transparent.png" alt="Drawing" height='50'/>  Composer

🎼 I recommended to you to use composer for manage your PHP package !
You have to get Composer ! see here -> [Composer](https://getcomposer.org/download/)
It's work fine like it (use easely composer.phar file) :
```bash
docker run -it --rm --name composer -v $PWD:/var/www/html greg78/php7-apache-xdebug ./composer.phar --version`
```
if you use **docker-compose** : 
```bash
docker-compose exec web ./composer.phar --version
```
