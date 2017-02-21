# rubybrigade-docker
Phase 4
Rid ourselves of sqlite3

TODO: Fix issue with mysql not running at the same time

Inside passenger folder:
docker build -t="irbtodo/passenger" .

Inside app folder:
docker build -t="irbtodo/phase4" .
docker run -dit -p 80:80 irbtodo/phase4

At root:
docker-compose up

Files edited:
+ app/config/database.yml
+ app/docker/start.sh
+ app/Dockerfile
+ app/Gemfile
+ docker-compose.yml
