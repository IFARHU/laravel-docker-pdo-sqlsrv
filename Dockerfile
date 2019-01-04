FROM dmiseev/php-fpm7.2

ARG DEBIAN_FRONTEND=noninteractive

## MSSQL Tools, UNIX ODBC
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

## Code Sniffer
RUN pear install PHP_CodeSniffer

## PDO SQL Server
RUN echo extension=pdo_sqlsrv.so >> /etc/php/7.2/fpm/conf.d/30-pdo_sqlsrv.ini \
&& echo extension=sqlsrv.so >> /etc/php/7.2/fpm/conf.d/20-sqlsrv.ini \
&& echo extension=pdo_sqlsrv.so >> /etc/php/7.2/cli/conf.d/30-pdo_sqlsrv.ini \
&& echo extension=sqlsrv.so >> /etc/php/7.2/cli/conf.d/20-sqlsrv.ini \
&& pecl install sqlsrv \
&& pecl install pdo_sqlsrv
