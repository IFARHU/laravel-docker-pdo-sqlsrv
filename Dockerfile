FROM dmiseev/php-fpm7.2

## MSSQL Tools, UNIX ODBC
RUN apt-get update
RUN apt-get install apt-transport-https ca-certificates -y
RUN curl https://packages.microsoft.com/keys/microsoft.asc | apt-key add -
RUN curl https://packages.microsoft.com/config/ubuntu/16.04/prod.list > /etc/apt/sources.list.d/mssql-release.list
RUN apt-get update
RUN ACCEPT_EULA=Y apt-get install msodbcsql17 -y
RUN ACCEPT_EULA=Y apt-get install mssql-tools -y
RUN echo 'export PATH="$PATH:/opt/mssql-tools/bin"' >> ~/.bash_profile
RUN echo 'export PATH="$PATH:/opt/mssql-tools/bin"' >> ~/.bashrc
RUN apt-get install unixodbc-dev

## PDO SQL Server
RUN echo extension=pdo_sqlsrv.so >> /etc/php/7.2/fpm/conf.d/30-pdo_sqlsrv.ini
RUN echo extension=sqlsrv.so >> /etc/php/7.2/fpm/conf.d/20-sqlsrv.ini
RUN echo extension=pdo_sqlsrv.so >> /etc/php/7.2/cli/conf.d/30-pdo_sqlsrv.ini
RUN echo extension=sqlsrv.so >> /etc/php/7.2/cli/conf.d/20-sqlsrv.ini
RUN pecl install sqlsrv
RUN pecl install pdo_sqlsrv

# PHP Code Sniffer
RUN sudo apt install php-codesniffer
