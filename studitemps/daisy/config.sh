# We support all major ruby versions: 1.9.3, 2.0.0, 2.1.x, 2.2.x and JRuby
sed -i "s|5432|5434|" "config/database.yml"
rvm use 2.3.1 --install
bundle config build.nokogiri --use-system-libraries
bundle install
export RAILS_ENV=test
# bundle exec rake db:schema:load
bundle exec rails db:migrate db:test:prepare