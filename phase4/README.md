Phase 4
Rid ourselves of sqlite3

Inside passenger folder:
docker build -t="irbtodo/passenger" .

Inside app folder:
docker build -t="irbtodo/phase3" .
docker run -dit -p 80:80 irbtodo/phase3

At root:
docker-compose up

Files edited:
+ app/Dockerfile
+ app/Gemfile
+ docker-compose.yml
