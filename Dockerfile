FROM php:8.1-fpm

# Copy composer.lock and composer.json
COPY composer.lock composer.json /var/www/

# Set working directory
WORKDIR /var/www

# Install dependencies
RUN apt-get update && apt-get install -y \
    build-essential \
    libpng-dev \
    libjpeg62-turbo-dev \
    libfreetype6-dev \
    locales \
    zip \
    jpegoptim optipng pngquant gifsicle \
    vim \
    unzip \
    git \
    curl \
    nano \
    libonig-dev \
    libzip-dev \
    libgd-dev

# Instalando Node.js (versão LTS)
RUN curl -fsSL https://deb.nodesource.com/setup_lts.x | bash - &&\
    apt-get install -y nodejs

# Limpar cache
RUN apt-get clean && rm -rf /var/lib/apt/lists/*

# Instalar o Artillery
RUN npm install -g artillery

# Instalar extensões PHP
RUN docker-php-ext-install pdo_mysql mbstring zip exif pcntl
RUN docker-php-ext-configure gd --with-external-gd
RUN docker-php-ext-install gd

# Instala a extensão OpenTelemetry
RUN pecl install opentelemetry && docker-php-ext-enable opentelemetry

# Instala a extensão gRPC
RUN pecl install grpc && docker-php-ext-enable grpc

# Install composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# Add user for laravel application
RUN groupadd -g 1000 www
RUN useradd -u 1000 -ms /bin/bash -g www www

# Definir o diretório de trabalho
WORKDIR /var/www

# Copiar o código do Laravel para o diretório de trabalho
COPY . /var/www

RUN chmod 777 -R storage/

# Instalar as dependências do Composer (se ainda não fez isso)
RUN composer install

# Expose port 9000 and start php-fpm server
EXPOSE 9000
CMD ["php-fpm"]
