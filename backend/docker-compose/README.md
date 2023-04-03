# eSchool APP

## start app
```
docker-compose up -d
```
# handed start
## create network
```
docker network create eschool-network
```
## un docker container front
```
docker run \
    -p 80:80 \
    --network eschool-network \
    -d itca_front:v1
```
## un docker container database
```
docker run --name eschool-mysql \
    -p 3306:3306 \
    --network eschool-network \
    --env-file ./$BASEDIR/.env \
    -d mysql:latest
```
## run docker container back
```
docker run --name itca_back \
    --env-file ./$BASEDIR/.env \
    --network eschool-network \
    -p 8080:8080 \
    -d itca_back:v1
```

# buil docker command
## front
```
docker build -t itca_front:v1 --build-arg base_url=localhost:8080 .
```
## back
```
docker build -t itca_back:v1 .
```
# username-password
```
admin
admin
```