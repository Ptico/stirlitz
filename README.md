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
spy.calls[0].time #=> # Time of calling
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

### Fake stubs

```ruby
fake = Stirlitz::Fake.new

fake.stub(:find).with(3).and_return({ id: 3, name: 'John' })
fake.stub(:find).with(4).and_return(id: 4, name: 'Jack')
fake.stub(:where).with(name: 'Jack').and_return(id: 4, name: 'Jack')

fake.find(3) #=> { id: 3, name: 'John' }
fake.where(name: 'Jack') #=> { id: 4, name: 'Jack' }

fake.called_methods #=> [:find, :where] # You catch the idea…
```

### Strict fakes

```ruby
fake = Stirlitz::Fake.new(true)

fake.stub(:foo)

fake.foo #=> Success
fake.bar #=> NoMethodError
```

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

## Credits

In memory of [Vyacheslav Tikhonov](http://en.wikipedia.org/wiki/Vyacheslav_Tikhonov)
