# litestar-hello

## Commands

Build an image:
```commandline
docker build -t hello . -f Dockerfile.prod
```

Create a container:
```commandline
docker create -p 9001:8000 --restart always --name litestar-hello hello
```

Start the container:
```commandline
docker start litestar-hello
```