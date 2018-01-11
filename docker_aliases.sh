# docker-compose
alias dc='docker-compose'

## List

# Get container process
alias dps='docker ps'

# Get process included stop container
alias dpsa='docker ps -a'

# Get services
alias dcps='docker-compose ps'

# Get exited containers
alias dpse='docker ps -a -f "status=exited"'

# Get created containers
alias dpsc='docker ps -a -f "status=created"'

# Get images
alias di='docker images'

# Get networks
alias dnet='docker network ls'

# Get volumes
alias dvol='docker volume ls'



# Run container in background
alias drun='docker run -d'

# Execute interactive container
alias drunit='docker run -it'


# Status

# Stop specific container(s)
alias dstop='docker stop'

# Create specific container(s)
alias dcreate='docker create'

# Build specific container(s)
alias dbuild='docker build'

# Stop specific service(s)
alias dcstop='docker-compose stop'

# Create specific services(s)
alias dccreate='docker-compose create'

# Build specific container(s)
alias dcbuild='docker-compose build'

# Stop all containers
alias dastop='docker stop $(docker ps -a -q)'

# Build image
dbu() { docker build -t=$1 .; }

# Stop and remove container(s)
dcs() { docker-compose stop $1 && docker-compose rm -f $1; }

# Stop, remove, create and restart container(s)
dcr() { docker-compose stop $1 && docker-compose rm -f $1 && docker-compose create $1 && docker-compose start $1; }

# Rebuild and restart container(s)
dcb() { docker-compose stop $1 && docker-compose rm -f $1 && docker-compose build $1 && docker-compose create $1 && docker-compose start $1; }



## Remove

# Remove specific container(s)
alias drm='docker rm -f'

# Remove specific services(s)
alias dcrm='dc rm -f'

# Remove specific image(s)
alias drmi='docker rmi'

# Remove specific network(s)
alias drmnet='docker network rm'

# Remove specific volume(s)
alias drmvol='docker volume rm'

# Remove all containers
alias darm='docker rm $(docker ps -a -q)'

# Stop and Remove all containers
alias dastoprm='docker stop $(docker ps -a -q) && docker rm $(docker ps -a -q)'

# Remove all exited containers
alias darme='docker rm $(docker ps -a -q -f "status=exited")'

# Stop and Remove all exited containers
alias dastoprme='docker stop $(docker ps -a -q -f "status=exited") && docker rm $(docker ps -a -q -f "status=exited")'

# Remove all images
alias darmi='docker rmi $(docker images -q)'

# Remove all volumes
alias darmvol='docker volume rm $(docker volume ls -q -f)'

# Remove unused images (<none>)
alias darmin='docker rmi $(docker images -f "dangling=true" -q)'

# Removed unused volumes
alias darmvoln='docker volume rm $(docker volume ls -q -f dangling=true)'

# Remove unused images and volumes
alias dclean='docker rmi $(docker images -f "dangling=true" -q) && docker volume rm $(docker volume ls -q -f dangling=true)'

# Remove all networks
alias darmnet='docker network rm $(docker network ls)'

# Remove all unused containers, volumes, images and networks
alias dprune='docker system prune'

# Remove all containers, volumes, images and networks
alias daprune='docker system prune -a'


## Inspect

# Inspect object
alias dinsp='docker inspect'

# Get service's IP
dcip() { docker inspect --format='{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' $(docker-compose ps $1 | awk '{if (NR>2) {print $1}}'); }

# Get service's MAC address
dcmac() { docker inspect --format='{{range .NetworkSettings.Networks}}{{.MacAddress}}{{end}}' $(docker-compose ps $1 | awk '{if (NR>2) {print $1}}'); }

# Get service's image name
dciname() { docker inspect --format='{{.Config.Image}}' $(docker-compose ps $1 | awk '{if (NR>2) {print $1}}'); }

# Get service's name giving container name
dsname() { docker inspect --format='{{ index .Config.Labels "com.docker.compose.service"}}' $1; }

# Get service's binded ports
dcport() { docker port $(docker-compose ps $1 | awk '{if (NR>2) {print $1}}'); }


## Logs

# output logs of a container
alias dlog='docker logs'

# output logs of a container (keep alive)
alias dlogf='docker logs -f'

# output logs of a service
alias dclog='docker-compose logs'

# output logs of a service (keep alive)
alias dclogf='docker-compose logs -f'



## Execute commands

# Open Bash terminal into running service
dbash() { docker exec -it $(docker-compose ps $1 | awk '{if (NR>2) {print $1}}') bash; }

# Open Shell terminal into running service
dsh() { docker exec -it $(docker-compose ps $1 | awk '{if (NR>2) {print $1}}') sh; }


## List aliases

# Show all aliases related docker
dalias() { alias | grep 'docker' | sed "s/^\([^=]*\)=\(.*\)/\1 => \2/"| sed "s/['|\']//g" | sort && declare -f dbash dsh dport dsname dciname dcmac dcip dbu dcs dcr dcb;}

