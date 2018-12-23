# Docker 

## Expose local directory to docker container

Expose a directory (volume) to the docker container from the host 

`docker run -v /host/directory:/container/directory`


## Removing containers
1. First stop any running containers
2. `docker rm <container-name>`
3. `docker rmi <image-name>`

_NOTE_: Dangling images are layers that have no relationship to any tagged images. 
They no longer serve a purpose and consume disk space. Dangling containers can be
found by issuing: `docker images -f dangling=true`
