class ConfigStore::Value < ActiveRecord::Base

  self.table_name = :config_store_values

  validates_presence_of :name
  validates_presence_of :data_type

  ALLOWED_TYPES = {
    Fixnum => lambda { |v| v.to_i },
    Float => lambda { |v| v.to_f },
    TrueClass => lambda { |v| v == "true" },
    FalseClass => lambda { |v| v == "false" },
    String => lambda { |v| v },
    NilClass => lambda { |v| nil }
  }

  def self.create_or_update value_name, value
    raise ArgumentError.new(allowed_message) unless allowed?(value)
    to_store = where(name: value_name).first || new(name: value_name)
    to_store.value = value.to_s
    to_store.data_type = value.class.to_s
    to_store.save!
    Rails.cache.write(cache_name(value_name), to_store.value_type_casted)
  end

  def self.with_name name
    cached_value = Rails.cache.fetch(cache_name(name))
    if cached_value
      cached_value
    else
      value = where(name: name).first
      type_casted = value.value_type_casted if value
      Rails.cache.write(cache_name(name), type_casted)
      type_casted
    end
  end

  def value_type_casted
    type = data_type.constantize
    ALLOWED_TYPES[type].call(value)
  end

  private

  def self.cache_name value_name
    "config_store/#{value_name}"
  end

  def self.allowed? value
    ALLOWED_TYPES.include?(value.class)
  end

  def self.allowed_message
    "Only following data types can be stored: #{ALLOWED_TYPES.keys.map(&:to_s).join(", ")}"
  end

end