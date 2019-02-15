# laravel-docker-pdo-sqlsrv

Imagen de Docker para utilizarse dentro de proyectos que utilicen conectividad con Microsoft SQL Server y está el mismo configurado dentro de las variables/opciones de conexión.

Se utiliza regularmente para los sistemas de CI/CD del IFARHU. Para el resto se prefiere utilizar a través de Docker Compose.

## Prueba local

Para levantar hacer un _build_ del contenedor y arrancarlo, podemos ejecutar el siguiente comando:

```
docker build -t laravel-docker-pdo-sqlsrv . && docker run -it laravel-docker-pdo-sqlsrv
```

Si queremos ejecutar algún comando en el contenedor, podemos ejecutar las siguientes líneas:

```
docker ps # para obtener el ID del container
docker exec -it <ID del container> /bin/bash
```

## Copyright

DTI, IFARHU, 2019.
