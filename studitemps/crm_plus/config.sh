#############################################################
##### Elasticsearch                                     #####
#############################################################
export ELASTICSEARCH_VERSION=2.4.0
export ELASTICSEARCH_PORT=9200
export ELASTICSEARCH_WAIT_TIME=5
\curl -sSL https://raw.githubusercontent.com/codeship/scripts/master/packages/elasticsearch.sh | bash -s
#############################################################
##### PostgreSQL database configuration                 #####
#############################################################
sed -i "s|5432|5434|" "config/database.yml"
sed -i "s|^test:|ci:|" "config/database.yml"
#############################################################
##### Ruby (RVM)                                        #####
#############################################################
rvm use 2.4.0 --install
#############################################################
##### PhantomJS                                         #####
#############################################################
PHANTOMJS_VERSION="2.1.1"
rm -rf ~/.phantomjs
mkdir ~/.phantomjs
mkdir -p ~/cache/phantomjs
if [ ! -e ~/cache/phantomjs/phantomjs${PHANTOMJS_VERSION}.tar.bz2 ]; then wget https://bitbucket.org/ariya/phantomjs/downloads/phantomjs-${PHANTOMJS_VERSION}-linux-x86_64.tar.bz2 -O ~/cache/phantomjs/phantomjs${PHANTOMJS_VERSION}.tar.bz2;fi
tar -xf ~/cache/phantomjs/phantomjs${PHANTOMJS_VERSION}.tar.bz2 --strip-components=1 -C ~/.phantomjs
#############################################################
##### Rubygems                                          #####
#############################################################
gem install bundler
# bundle config build.nokogiri --use-system-libraries
bundle install
#############################################################
##### Database setup and migration                      #####
#############################################################
export RAILS_ENV=ci
bundle exec rails db:create db:migrate