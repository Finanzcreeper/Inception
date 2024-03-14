all: prep up

prep:
	@if [ ! -d "/home/nreher/data/mariadb" ]; then mkdir -p /home/nreher/data/mariadb; fi
	@if [ ! -d "/home/nreher/data/wordpress" ]; then mkdir -p /home/nreher/data/wordpress; fi

attached: prep
	@docker-compose -f srcs/docker-compose.yml up --build

up:
	@docker-compose -f srcs/docker-compose.yml up -d

build:
	@docker-compose -f srcs/docker-compose.yml up -d --build

down:
	@docker-compose -f srcs/docker-compose.yml down

reattach: fclean attached

re:	fclean
	@docker-compose -f srcs/docker-compose.yml up -d --build

clean: down
	@docker system prune -a

fclean:
	@-docker stop $$(docker ps -qa)
	@docker system prune --all --force --volumes
	@docker network prune --force
	@docker volume prune --force

reset: fclean
	sudo rm -rf /home/nreher/data/mariadb
	sudo rm -rf /home/nreher/data/wordpress


.PHONY	: all build down re clean fclean