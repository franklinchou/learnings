# Docker 

## Build a docker container from a Dockerfile

Docker containers are built from a Dockerfile and a "context." The context is the set of files from which the container will
be built (i.e., the source code). Build an image by issuing: `docker build -t {{image-name}} {{context}} -f {{docker-file-location}}`

- `image-name` will be the docker image tag (can be in the `name:tag` format)
- `context` is the directory where the sources files are located; this is generally `.` (i.e., the current working directory)
- `docker-file-location` = `/path/to/Dockerfile`, generally this is `deploy/Dockerfile`

The result of this will be a built docker *image*. You can find images by issuing `docker images ls`.


## Expose local directory to docker container

Expose a directory (volume) to the docker container from the host 

`docker run -v /host/directory:/container/directory`

**NOTE**: For `/container/directory/` substitute something like `/opt/artifacts` or `/opt/resources`.


## Removing images
1. First stop any running containers (`docker stop {{container-name}}`)
2. `docker rm {{container-name}}`
3. `docker rmi {{image-name}}`

**NOTE**: Docker images consist of multiple layers. 
Dangling images are layers that have no relationship to any tagged images. 
They no longer serve a purpose and consume disk space. Dangling images can be
found by issuing: `docker images -f dangling=true`

**NOTE**: Difference between docker images and docker containers: 
Docker Image is a set of files which has no state, whereas Docker Container is the instantiation of Docker Image. In other words, Docker Container is the run time instance of images.
Docker containers are stateful!
