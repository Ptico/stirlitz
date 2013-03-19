# Stirlitz

Spy/Fake-object library

## Installation

Add this to your application's Gemfile:

    gem 'stirlitz', group: test

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install stirlitz

## Usage

### Spy

```ruby
spy = Stirlitz::Spy.new { |a, b| a + b }

spy.call(1, 2)

spy.called? #=> true
spy.call_count #=> 1
spy.calls[0].args #=> [1, 2]
spy.calls[0].block #=> nil
```

### Fake

```ruby
fake = Stirlitz::Fake.new

fake.my_method(1, 2)

fake[:my_method].called? #=> true
fake[:my_method].call_count #=> 1
fake[:my_method].calls[0].args #=> [1, 2]
fake.called_methods #=> [:my_method]
```

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

## Credits

In memory of [Vyacheslav Tikhonov](http://en.wikipedia.org/wiki/Vyacheslav_Tikhonov)
