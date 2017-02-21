sleep 30
echo "  database: $DB_NAME" >> /usr/share/nginx/app/config/database.yml
echo "  username: $DB_USER" >> /usr/share/nginx/app/config/database.yml
echo "  password: $DB_PASS" >> /usr/share/nginx/app/config/database.yml
cd /usr/share/nginx/app && bash -l -c "bundle exec rake db:seed RAILS_ENV=production"
/usr/sbin/nginx -g 'daemon off;'
