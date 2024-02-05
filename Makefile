name = inception
env_path = /home/ifreire-/.env

COLOR_RESET = \033[0m
COLOR_YELLOW = \033[1;33m

all:
	@printf "$(COLOR_YELLOW)\nRunning make all$(COLOR_RESET)\n"
	@docker-compose -f ./srcs/docker-compose.yml --env-file ${env_path} up -d

down:
	@printf "$(COLOR_YELLOW)\nRunning down$(COLOR_RESET)\n"
	@docker-compose -f ./srcs/docker-compose.yml --env-file ${env_path} down

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

test:
	@printf "$(COLOR_YELLOW)\nRunning 1sd test: Showing dockers$(COLOR_RESET)\n"
	docker ps
	@printf "$(COLOR_YELLOW)\nRunning 2nd test: PhP Version$(COLOR_RESET)\n"
	docker exec -it wordpress php -v
	@printf "$(COLOR_YELLOW)\nRunning 3rd test: PhP Packages$(COLOR_RESET)\n"
	docker exec -it wordpress php -m
	@printf "$(COLOR_YELLOW)\nRunning 4nd test:$(COLOR_RESET)\n"
	docker exec -it mariadb mysql -u root -p

.PHONY	: all build down re clean fclean test
