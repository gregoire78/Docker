FROM php:7-apache

# modules apache
RUN a2enmod rewrite

# XDebug
# zend_extension=/usr/local/lib/php/extensions/no-debug-non-zts-20151012/xdebug.so
RUN apt-get update \
	&& apt-get install -y \
		php-pear
RUN pecl install xdebug
RUN echo 'zend_extension = /usr/local/lib/php/extensions/no-debug-non-zts-20151012/xdebug.so' >> /usr/local/etc/php/php.ini

# Install utilities used by TYPO3 CMS / Flow / Neos
RUN apt-get update \
	&& apt-get install -y \
		imagemagick \
		graphicsmagick \
		zip \
		unzip \
		wget \
		curl \
		git \
		mysql-client \
		moreutils \
		dnsutils \
	&& rm -rf /var/lib/apt/lists/*
	
# gd
RUN buildRequirements="libpng12-dev libjpeg-dev libfreetype6-dev" \
	&& apt-get update && apt-get install -y ${buildRequirements} \
	&& docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/lib \
	&& docker-php-ext-install gd \
	&& apt-get purge -y ${buildRequirements} \
	&& rm -rf /var/lib/apt/lists/*

# imagick
RUN runtimeRequirements="libmagickwand-6.q16-dev --no-install-recommends" \
	&& apt-get update && apt-get install -y ${runtimeRequirements} \
	&& ln -s /usr/lib/x86_64-linux-gnu/ImageMagick-6.8.9/bin-Q16/MagickWand-config /usr/bin/ \
	&& pecl install imagick \
	&& echo "extension=imagick.so" > /usr/local/etc/php/conf.d/ext-imagick.ini \
	&& rm -rf /var/lib/apt/lists/*
	
# exif
RUN docker-php-ext-install exif \
	&& docker-php-ext-configure exif --enable-exif
	
# opcache
RUN docker-php-ext-install opcache

# soap
RUN docker-php-ext-install soap

# zip
RUN docker-php-ext-install zip
	
# mbstring
RUN docker-php-ext-install mbstring
	
# pdo_mysql
RUN docker-php-ext-install pdo_mysql

# mysqli
RUN docker-php-ext-install mysqli

# pdo_pgsql
RUN apt-get update && apt-get install -y \
	libghc-postgresql-libpq-dev \
	&& docker-php-ext-configure pgsql -with-pgsql=/usr/include/postgresql/ \ 
	&& docker-php-ext-install pgsql pdo_pgsql

# Install program to configure locales
RUN apt-get update && \
	apt-get install -y locales
# Install needed default locale for PHP setlocale
RUN echo 'en_US.UTF-8 UTF-8' >> /etc/locale.gen && \
	echo 'fr_FR.UTF-8 UTF-8' >> /etc/locale.gen && \
	locale-gen
# Set default locale for the environment
ENV LC_ALL fr_FR.UTF-8
RUN apt-get autoremove -y