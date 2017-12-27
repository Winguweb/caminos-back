module Service
  module Base
    attr_reader :result

     module ClassMethods
      def call(*args)
        new(*args).call
      end
    end

    def self.prepended(base)
      base.extend ClassMethods
    end

    def call
      fail NotImplementedError unless defined?(super)

      @result = super
      @called = true

      self
    end

    def success?
      called? && !failure?
    end

    def failure?
      called? && errors.any?
    end

    def errors
      @errors ||= Service::Errors.new
    end

    private

    def called?
      @called ||= false
    end

    def boolean(value)
      ActiveModel::Type::Boolean.new.cast(value)
    end
  end
end
