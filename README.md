# DigDeep

DigDeep will look up key/value pairs in a nested hash by a given key. It will recursively dig each nested object and return all matching key/values.

Ruby's dig method can perform similar tasks, but you need to specify the path to the target key.

With this gem, you will only need to specify the target key and it will do the digging.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'dig-deep'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install dig-deep

## Usage
#### Example 1:
Given the following hash:
```
data = {
  a: {
    b: {
      c: "abc"
    }
  }
}
```
Ruby `.dig`:
```
data.dig(:a, :b, :c)   // "abc"
```
With DigDeep:
```
require 'dig-deep'

data.dig_deep(:c)      // "abc"
```

#### Example 2:
Dig up all `:email`
```
data = {
  contacts: [{
    name: "John",
    email: "john@example.com"
  }, {
    name: "Mary",
    email: "mary@example.com"
  }],
  work: {
    contacts: [{
      name: "ACME Corp.",
      email: "acme@example.com"
    }, {
      name: "Asdf Inc.",
      email: "asdf@example.com"
    }]
  }
}
```
```
require 'dig-deep'

data.dig_deep(:email)  // ["john@example.com", "mary@example.com", "acme@example.com", "asdf@example.com"]
```

#### Example 3:
Object with boolean, string, array...
```
data = {
  :l1 => {
    :l2 => {
      :l3 => {
        :l4a => "Level 4",
        :l4b => {
          :l5a => false,
          :l5b => {
            :l6 => ["apple", "orange"]
          }
        } 
      }
    }
  },
  :l7 => true,
  :l8 => {
    :l9 => 9876
  }
}
```
```
require 'dig-deep'

data.dig_deep(:l4a)   // "Level 4"

data.dig_deep(:l5a)   // false

data.dig_deep(:l6)    // ["apple", "orange"]

data.dig_deep(:l9)    // 9876

data.dig_deep(:xyz)   // nil   (returns nil when key is not found)
```

## Contributing
#### Bug reports and pull requests are welcome!
Fork it, create your new branch, push and create a pull request.
 
## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the DigDeep project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/[USERNAME]/dig-deep/blob/master/CODE_OF_CONDUCT.md).
