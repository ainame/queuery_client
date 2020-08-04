module QueueryClient
  class Configuration
    REQUIRED_KEYS = [:endpoint, :token, :token_secret]
    OPTIONAL_KEYS = [:host_header]

    def initialize(options = {})
      @options = options
    end

    def options
      @options ||= {}
    end

    def reset
      @options = nil
    end

    REQUIRED_KEYS.each do |key|
      define_method(key) do
        options.fetch(key)
      end

      define_method("#{key}=") do |value|
        options[key] = value
      end
    end

    OPTIONAL_KEYS.each do |key|
      define_method(key) do
        options[key]
      end

      define_method("#{key}=") do |value|
        options[key] = value
      end
    end

    def merge(other)
      Configuration.new(to_h.merge(other.to_h))
    end

    def to_h
      options
    end
  end
end
