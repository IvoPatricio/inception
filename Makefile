name = inception
env_path = /home/ifreire-/.env

COLOR_RESET = \033[0m
COLOR_YELLOW = \033[1;33m

all:
	@printf "$(COLOR_YELLOW)\nRunning make all$(COLOR_RESET)\n"
	@bash srcs/requirements/wordpress/tools/make_data.sh
	@docker-compose -f ./srcs/docker-compose.yml --env-file ${env_path} up -d

build:
	@printf "$(COLOR_YELLOW)\nRunning build$(COLOR_RESET)\n"
	@bash srcs/requirements/wordpress/tools/make_data.sh
	@docker-compose -f ./srcs/docker-compose.yml --env-file ${env_path} -d --build

down:
	@printf "$(COLOR_YELLOW)\nRunning down$(COLOR_RESET)\n"
	@docker-compose -f ./srcs/docker-compose.yml --env-file ${env_path}  down

re: down
	@printf "$(COLOR_YELLOW)\nRunning re$(COLOR_RESET)\n"
	@docker-compose -f ./srcs/docker-compose.yml --env-file ${env_path} up -d --build

clean: down
	@printf "$(COLOR_YELLOW)\nRunning clean$(COLOR_RESET)\n"
	@docker system prune -a

fclean:
	@printf "$(COLOR_YELLOW)\nRunning fclean$(COLOR_RESET)\n"
	@printf "Total clean of all configurations docker\n"
	@docker stop $$(docker ps -qa)
	@docker system prune --all --force --volumes
	@docker network prune --force
	@docker volume prune --force

test1: 
	@printf "$(COLOR_YELLOW)\nRunning 1sd test$(COLOR_RESET)\n"
	docker exec -it wordpress ps aux | grep 'php'

test2:
	@printf "$(COLOR_YELLOW)\nRunning 2nd test:$(COLOR_RESET)\n"
	docker exec -it wordpress php -v

test3:
	@printf "$(COLOR_YELLOW)\nRunning 3rd test:$(COLOR_RESET)\n"
	docker exec -it wordpress php -m

test-all: test1 test2 test3

.PHONY	: all build down re clean fclean test-all

#docker exec -it wordpress ps aux | grep 'php' &&  docker exec -it wordpress php -v && docker exec -it wordpress php -m