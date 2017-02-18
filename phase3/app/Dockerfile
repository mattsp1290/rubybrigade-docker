FROM irbtodo/passenger
MAINTAINER "Matt Spurlin" <mattsp1290@gmail.com>

USER root
WORKDIR /usr/share/nginx/app

# Copy Rails Application
COPY app /usr/share/nginx/app/app
COPY bin /usr/share/nginx/app/bin
COPY config /usr/share/nginx/app/config
COPY db/migrate /usr/share/nginx/app/db/migrate
COPY db/schema.rb /usr/share/nginx/app/db/schema.rb
COPY db/seeds.rb /usr/share/nginx/app/db/seeds.rb
COPY lib /usr/share/nginx/app/lib
COPY public /usr/share/nginx/app/public
COPY config.ru /usr/share/nginx/app/config.ru
COPY Gemfile /usr/share/nginx/app/Gemfile
COPY Rakefile /usr/share/nginx/app/Rakefile

# Make log and tmp directories
RUN mkdir /usr/share/nginx/app/log
RUN mkdir /usr/share/nginx/app/tmp

RUN chown -R app:nginx /usr/share/nginx/app

# Install gems and prepare assets
USER app
RUN bash -l -c "bundle install"
RUN bash -l -c "bundle exec rake assets:precompile RAILS_ENV=production"
RUN bash -l -c "bundle exec rake assets:environment RAILS_ENV=production"
RUN bash -l -c "bundle exec rake db:migrate RAILS_ENV=production"
RUN bash -l -c "bundle exec rake db:seed RAILS_ENV=production"
RUN echo "  secret_key_base: `/usr/local/rvm/wrappers/ruby-$rubyver/bundle exec rake secret`" >> /usr/share/nginx/app/config/secrets.yml

USER root
RUN chown -R app:nginx /usr/share/nginx/app
RUN chmod -R 777 /usr/share/nginx/app/db
