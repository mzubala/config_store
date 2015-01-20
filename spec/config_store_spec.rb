require 'spec_helper'

describe "Configuration" do

  class Configuration
    extend ConfigStore::Manager
  end

  it "should store integer config values" do
    Configuration.my_int = 200
    expect(Configuration.my_int).to eq 200
  end

  it "should store boolean config values" do
    Configuration.some_bool = true
    expect(Configuration.some_bool).to eq true
  end

  it "should store float config values" do
    Configuration.some_float = 2.0
    expect(Configuration.some_float).to eq 2.0
  end

  it "should store string values" do
    Configuration.some_string = "some"
    expect(Configuration.some_string).to eq "some"
  end

  it "should store nil values" do
    Configuration.param = nil
    expect(Configuration.param).to be_nil
  end

  it "should update values" do
    Configuration.some_string = "some"
    expect(Configuration.some_string).to eq "some"
    Configuration.some_string = "else"
    expect(Configuration.some_string).to eq "else"
  end

  it "should store values in db" do
    Configuration.some = "some"
    Configuration.else = 2
    Configuration.else = 6
    expect(ConfigStore::Value.count).to eq 2
  end

  it "should allow type change" do
    Configuration.some = nil
    Configuration.some = 2
    expect(Configuration.some).to eq 2
  end

  it "should not store other types of values" do
    expect { Configuration.some_hash = {} }.to raise_error ArgumentError
  end

  it "should return nil if value is not stored" do
    expect(Configuration.some_val).to be_nil
  end

  it "should return stored values when storing" do
    expect(Configuration.v = "some").to eq "some"
  end

  it "should cache values" do
    Configuration.some_val = 400
    ConfigStore::Value.destroy_all
    expect(Configuration.some_val).to eq(400)
  end

end