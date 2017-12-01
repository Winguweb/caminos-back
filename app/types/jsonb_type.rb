class JsonbType < ActiveModel::Type::Value
  include ActiveModel::Type::Helpers::Mutable

  def type
    :jsonb
  end

  def deserialize(value)
    if value.is_a?(::String)
      Oj.load(value) rescue nil
    else
      value
    end
  end

  def serialize(value)
    if value.is_a?(Array)
      value = value.map do |item|
        item.is_a?(ActiveSupport::HashWithIndifferentAccess) ? item.to_hash : item
      end
    end
    if value.nil?
      nil
    else
      Oj.dump(value)
    end
  end

  def accessor
    ActiveRecord::Store::StringKeyedHashAccessor
  end
end
