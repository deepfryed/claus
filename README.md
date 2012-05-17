# Claus

Simple rule expression using a combination of Array and Hash.

## Example

```ruby

require 'claus'
claus = Claus.new(foo: 1, bar: 2)
claus.match(foo: 1, bar: 2)           #=> true
claus.match(foo: 1, bar: 3)           #=> false
claus.match(foo: 1, bar: 2, baz: 3)   #=> true

claus = Claus.new(foo: 1, bar: 1..2)
claus.match(foo: 1, bar: 2)           #=> true

claus = Claus.new([{foo:1}, {bar:2}])
claus.match?(foo: 1)                  #=> true
claus.match?(bar: 2)                  #=> true
claus.match?(baz: 3)                  #=> false
```

# License
[Creative Commons Attribution - CC BY](http://creativecommons.org/licenses/by/3.0)
