# eSchool backend



## starting container with mysql DB
```
docker run --name eschool-mysql \
    -p 3306:3306 \
    --network eschool-network \
    --env-file ./$BASEDIR/.env
    -d mysql:5.6
```

## building app image
```
docker build -t itca_back:v1 ../.
```

## starting app container
```
docker run --name itca_back \
     --env-file ./$BASEDIR/.env \
     --network eschool-network \
     -p 8080:8080 \
     -d itca_back:v1
```