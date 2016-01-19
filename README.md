# Serpbook


## Installation

Add this line to your application's Gemfile:

```ruby
gem 'serpbook'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install serpbook

## Usage

1. Configure your master key and email

```ruby
Serpbook.config do |conf|
    conf.master_key = 'my_key'
    conf.email = 'my email'
end
````

2. Interact with a category

```ruby
cat = Serpbook::Category.new(name: 'My Category name')

# get your rankings
cat.rankings

#convinience methods to drill down
cat.rankings.for_keyword('my keyword')
cat.rankings.for_url('myurl.com')

# add a new keyword - note various options that can be included. see code at lib/serpbook/category.rb
cat.create('myurl.com', 'my keyword')

# delete a keyword
cat.delete('myurl.com', 'my keyword')
````



## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

Currently specs are setup to read in a .env.rb file in the spec directory with your master_key and email. (See the spec_helper file.)

TODO: make tests general enough to allow others to test without changing values

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/serpbook.

