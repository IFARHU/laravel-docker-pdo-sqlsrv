FROM dmiseev/php-fpm7.2

## No interactive mode
ARG DEBIAN_FRONTEND=noninteractive

## Replace shell with bash (for source)
RUN rm /bin/sh && ln -s /bin/bash /bin/sh

## MSSQL Tools, UNIX ODBC, SQL lite 3 for PHP
RUN apt-get update \
    && apt-get install apt-transport-https ca-certificates -y \
    && curl https://packages.microsoft.com/keys/microsoft.asc | apt-key add - \
    && curl https://packages.microsoft.com/config/ubuntu/16.04/prod.list > /etc/apt/sources.list.d/mssql-release.list \
    && apt-get update \
    && ACCEPT_EULA=Y apt-get install msodbcsql17 -y \
    && ACCEPT_EULA=Y apt-get install mssql-tools -y \
    && echo 'export PATH="$PATH:/opt/mssql-tools/bin"' >> ~/.bash_profile \
    && echo 'export PATH="$PATH:/opt/mssql-tools/bin"' >> ~/.bashrc \
    && apt-get install unixodbc-dev

## sqlite & php intl
RUN apt-get update \
    && apt-get -y -o Dpkg::Options::="--force-confdef" -o Dpkg::Options::="--force-confold" install php7.2-sqlite php7.2-intl

## Code Sniffer
RUN composer global require "squizlabs/php_codesniffer=*"
ENV PATH /root/.composer/vendor/bin:$PATH

## PDO SQL Server
RUN echo extension=pdo_sqlsrv.so >> /etc/php/7.2/fpm/conf.d/30-pdo_sqlsrv.ini \
    && echo extension=sqlsrv.so >> /etc/php/7.2/fpm/conf.d/20-sqlsrv.ini \
    && echo extension=pdo_sqlsrv.so >> /etc/php/7.2/cli/conf.d/30-pdo_sqlsrv.ini \
    && echo extension=sqlsrv.so >> /etc/php/7.2/cli/conf.d/20-sqlsrv.ini \
    && pecl install sqlsrv \
    && pecl install pdo_sqlsrv

## Node and NPM (NVM)
ENV NVM_DIR /usr/local/nvm
ENV NODE_VERSION 8.10.0

RUN curl --silent -o- https://raw.githubusercontent.com/creationix/nvm/v0.31.2/install.sh | bash

RUN source $NVM_DIR/nvm.sh \
    && nvm install $NODE_VERSION \
    && nvm alias default $NODE_VERSION \
    && nvm use default

ENV NODE_PATH $NVM_DIR/v$NODE_VERSION/lib/node_modules
ENV PATH $NVM_DIR/versions/node/v$NODE_VERSION/bin:$PATH

RUN node -v
RUN npm -v
