# rubybrigade-docker
Phase 2
Move Application To Docker

Inside app folder:
docker build -t="irbtodo/phase2" .
docker run -dit -p 80:8080 irbtodo/phase2

Files edited:
+ config/database.yml
+ config/secrets.yml
+ docker/config/app.conf
+ docker/config/nginx.conf
+ docker/config/passenger.conf
+ Dockerfile
+ Gemfile
