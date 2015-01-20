require 'active_record'
require 'config_store'

ActiveRecord::Base.establish_connection adapter: "sqlite3", database: ":memory:"

load File.dirname(__FILE__) + '/schema.rb'

module Rails
  def self.cache
    @cache ||= ActiveSupport::Cache::MemoryStore.new
  end
end

RSpec.configure do |config|

  config.before(:each) do
    ActiveRecord::Base.connection.execute("delete from config_store_values")
    Rails.cache.clear
  end

end