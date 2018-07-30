require "dig_deep/version"
require "json"

module DigDeep
  def dig_deep(target)
    results = serialize_for(self, target)

    results.size <= 1 ? results[0] : results
  end
end

class Hash
  include DigDeep
end

private

def serialize_for(obj, target)
  drill(obj, target).map do |m|
    string_to_array(m) ? string_to_array(m) : m
  end.compact
end

def drill(obj, target)
  if is_object?(obj)
    acc = (obj.is_a?(Hash) && obj.key?(target)) \
      ? obj[target].is_a?(Array) ? ["#{obj[target]}"] : [ obj[target] ] \
      : []

    obj.reduce(acc) do |acc, val|
      val.is_a?(Hash) \
        ? ( val.key?(target) \
              ? acc << (val[target].is_a?(Array) ? "#{val[target]}" : val[target]) \
              : acc << val.values.reduce([]){|acc,v| drill(v,target)} )
        : ( val.is_a?(Array) \
              ? acc << val.reduce([]){|acc, v| drill(v, target) if is_object?(v) } \
              : acc )
    end.flatten(1)
  end
end

def is_object?(obj)
  obj.class == Hash || obj.class == Array
end

def string_to_array(val)
  begin
    JSON.parse(val)
  rescue
    nil
  end
end
