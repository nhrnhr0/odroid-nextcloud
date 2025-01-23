#db.env
MYSQL_ROOT_PASSWORD=
MYSQL_PASSWORD=
MYSQL_DATABASE=
MYSQL_USER=


#rescan files

sudo docker exec -it --user www-data nc-app-1 ./occ files:scan --all

sudo docker exec -it --user www-data nc-app-1 ./occ recognize:classify
sudo docker exec -u www-data nc-app-1 php /var/www/html/occ preview:generate-all -vvv

sudo docker exec -it --user www-data nc-app-1 /bin/bash


docker compose logs -f app

tail -f /var/www/html/data/nextcloud.log
