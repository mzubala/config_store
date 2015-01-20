module ConfigStore

  module Manager

    def method_missing method, *args
      if setter?(method)
        value_name = value_name(method)
        Value.create_or_update(value_name, args[0])
        args[0]
      else
        Value.with_name(method)
      end
    end

    private

    def setter? method
      method =~ /^.+=$/
    end

    def value_name method
      method.to_s.match(/^(.+)=$/)[1]
    end

  end

end