require "dig_deep/version"
require "json"

module DigDeep
  Hash.class_eval do
    def dig_deep(target)
      results = dig_for(self, target)

      return nil if results.empty?
      return results[0] if results.length === 1
      return results
    end
  end
end


private

def dig_for(obj, target)
  drill(obj, target).map do |m|
    string_to_array(m) ? string_to_array(m) : m
  end.compact
end

def drill(obj, target)
  if is_object?(obj)
    if (obj.is_a?(Hash) && obj.key?(target))
      acc = obj[target].is_a?(Array) ? ["#{obj[target]}"] : [ obj[target] ]
    end

    obj.reduce(acc ||= []) do |acc, val|
      if (val.is_a?(Hash) && val.key?(target))
        acc << (val[target].is_a?(Array) ? "#{val[target]}" : val[target])
      elsif val.is_a?(Array)
        acc << val.reduce([]){|acc, v| drill(v, target) if is_object?(v) }
      elsif val.is_a?(Hash)
        acc << val.values.reduce([]){|acc,v| drill(v,target)}
      else
        acc
      end
    end.compact.flatten(1)
  end
end

def is_object?(obj)
  return true if ( obj.class == Hash || obj.class == Array )
  return false
end

def string_to_array(val)
  begin
    JSON.parse(val)
  rescue
    nil
  end
end
