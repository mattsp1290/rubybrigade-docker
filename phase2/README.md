Phase 2
Move Application To Docker

docker build -t="irbtodo/phase2" .
docker run -dit -p 80:80 irbtodo/phase2

Files edited:
+ docker/config/app.conf
+ docker/config/nginx.conf
+ docker/config/passenger.conf
+ Dockerfile