require "dig_deep/version"

module DigDeep
  Hash.class_eval do
    def dig_deep(target)
      key?(target) \
        ? self[target] \
        : values.reduce(nil) do |acc, val|
            return acc if acc != nil;
            return val.dig_deep(target) if val.is_a?(Hash)
          end
    end
  end
end
