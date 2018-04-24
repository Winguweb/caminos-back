module Service
  module Support
    module User

      private

      def roles(roles_hash)
        roles_hash.each_with_object([]) do |(role_key, enable), _array|
          _array << role_key.to_sym if enable == "1"
        end
      end

    end
  end
end
