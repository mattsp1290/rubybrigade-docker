# rubybrigade-docker
Phase 6
Builds are pretty cool.

Inside passenger folder:
docker build -t="irbtodo/passenger" .

Inside app folder:
docker build -t="irbtodo/phase6" .

At root:
docker-compose up

Files edited:
+ app/Gemfile
+ app/spec/models/todo_spec.rb
+ build.gradle
+ docker-compose.yml
+ docker-compose-test.yml
+ spec/models/todo_spec.rb
+ `rails generate rspec:install`
+ `gradle init`
