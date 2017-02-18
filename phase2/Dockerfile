FROM centos:7
MAINTAINER "Matt Spurlin" <mattsp1290@gmail.com>

ENV rubyver 2.3.1
ENV container docker
EXPOSE 80/tcp 443/tcp

# Install EPEL
RUN yum install -y epel-release yum-utils
RUN yum-config-manager --enable epel
RUN yum clean all && yum update -y

# Install Various Repositories
RUN yum install -y  autoconf \
                    automake \
                    bison \
                    bzip2\
                    curl \
                    gcc-c++ \
                    git \
                    glibc-devel \
                    glib-headers \
                    initscripts \
                    libffi-devel \
                    libtool \
                    libyaml-devel \
                    openssl-devel \
                    patch \
                    pygpgme \
                    readline-devel \
                    sqlite-devel \
                    systemd \
                    which \
                    zlib-devel

# Update packages
RUN yum update -y

# Install Nginx with Passenger modules
RUN curl --fail -sSLo /etc/yum.repos.d/passenger.repo https://oss-binaries.phusionpassenger.com/yum/definitions/el-passenger.repo
RUN yum install -y nginx passenger || yum-config-manager --enable cr && yum install -y nginx passenger

# Give nginx a nice comfy directory to store its pid
RUN mkdir /run/nginx
RUN chown nginx:nginx /run/nginx
RUN chown nginx:nginx /run/passenger-instreg

# Install RVM
RUN gpg --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3
RUN \curl -sSL https://get.rvm.io | bash -s stable


# Create app user
RUN useradd -m -g nginx -s /bin/bash app
RUN usermod -g rvm app
RUN usermod -g rvm nginx

USER app

# Install ruby
RUN bash -l -c "rvm install $rubyver"
RUN bash -l -c "rvm default $rubyver"
RUN bash -l -c "gem install bundler"


# Copy config files
COPY docker/config/nginx.conf /etc/nginx/nginx.conf
COPY docker/config/passenger.conf /etc/nginx/conf.d/passenger.conf
COPY docker/config/app.conf /etc/nginx/conf.d/app.conf

USER root
RUN mkdir -p /usr/share/nginx/app
RUN chown app:nginx /usr/share/nginx/app

# Change the working director
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

# Start Nginx and keep it running
USER nginx
CMD /usr/sbin/nginx -g 'daemon off;'
