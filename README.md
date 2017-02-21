# rubybrigade-docker
Phase 3
Make use of Docker inheritance

Inside passenger folder:
docker build -t="irbtodo/passenger" .

Inside app folder:
docker build -t="irbtodo/phase3" .
docker run -dit -p 80:8080 irbtodo/phase3

Files edited:
+ app/Dockerfile
+ passenger/config/app.conf
+ passenger/config/nginx.conf
+ passenger/config/passenger.conf
+ passenger/Dockerfile
