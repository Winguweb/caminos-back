module Service
  class NotImplementedError < ::StandardError; end
  class Error < ::StandardError
    attr_reader :service

    def initialize(service)
      @service = service
      errors = @service.errors.map{ |key, value| "#{key}: #{value}" }.join(", ")
      message = I18n.t('errors.service.generic_error', errors: errors)

      super(message)
    end
  end

  class Errors < Hash
    def add(key, value, _opts = {})
      self[key] ||= []
      self[key] << value
      self[key].uniq!
    end

    def add_multiple_errors(errors_hash)
      errors_hash.each_pair do |key, values|
        values.each { |value| add(key, value) }
      end
    end

    def each
      each_key do |field|
        self[field].each { |message| yield(field, message) }
      end
    end
  end
end
