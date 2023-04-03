# eSchool frontend

## building app image
```
docker build -t itca_front:v1 --build-arg base_url=localhost:8080 .
```

## starting app container
```
docker run \
     --network eschool-network \
     -p 80:80 \
     -d itca_front:v1
```