#######################
# Install Erlang      #
#######################
# Declare an ERLANG_VERSION environment variable, otherwise default script version will be used
source /dev/stdin <<< "$(curl -sSL https://raw.githubusercontent.com/codeship/scripts/master/languages/erlang.sh)"
#######################
# Install Elixir      #
#######################
# Declare an ELIXIR_VERSION environment variable, otherwise default script version will be used
source /dev/stdin <<< "$(curl -sSL https://raw.githubusercontent.com/codeship/scripts/master/languages/elixir.sh)"
#######################
# Install phantomjs   #
#######################
# Declare an PHANTOMJS_VERSION environment variable, otherwise default script version will be used
source /dev/stdin <<< "$(curl -sSL https://raw.githubusercontent.com/codeship/scripts/master/packages/phantomjs.sh)"
phantomjs --wd >>phantomjs.output.txt 2>&1 &
#######################
# Prepare build       #
#######################
mix local.hex --force
mix local.rebar --force
mix deps.get
#######################
# Install Node.js     #
#######################
nvm install v$NODE_VERSION
npm --version
cd apps/unternehmensportal/assets/ && npm install
./node_modules/brunch/bin/brunch build
cd -
#######################
# Prepare database    #
#######################
cd apps/unternehmensportal
mix ecto.reset
cd -

cd apps/leistungsnachweis
mix ecto.reset
cd -