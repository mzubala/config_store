# ConfigStore

Config store is a gem that allows storing global configuration options in the database.

## Installation

```ruby
gem 'config_store', git: 'git@github.com:mzubala/config_store.git'
```

And then execute:

    $ bundle

Generate initializer file and migration

    $ rails generate config_store:install

Migrate

    $ rake db:migrate

## Usage

To store global configuration options just write:

 ```ruby
 Configuration.your_param1 = 1
 Configuration.your_param2 = 1.0
 Configuration.your_param3 = true
 Configuration.your_param4 = "string"
 Configuration.your_param5 = nil
 ```

Only integer, float, boolean, string and nil values are accepted. Param name can by any valid ruby identifier.

You can change the class name used to refer to configuration params to whatever you like. Just go to `config/initializers/config_store.rb` and change the class name.