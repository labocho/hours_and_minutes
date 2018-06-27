# HoursAndMinutes

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'hours_and_minutes'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install hours_and_minutes

## Usage


```ruby
require "hours_and_minutes"

hm = HoursAndMinutes.new(12, 34)
hm.to_s # "12:34"
hm.hour # 12
hm.min # 34

HoursAndMinutes.parse("12:34") == hm # true
HoursAndMinutes.min(12 * 60 + 34) == hm # true
```

Call `require "hours_and_minutes/active_record"` to integrate ActiveRecord. It registers attribute type `:hours_and_minutes`.

```ruby
require "hours_and_minutes/active_record"

class Alarm
  # `at` is a string typed column
  attribute :at, :hours_and_minutes
end

alarm = Alarm.create!(at: "12:34")
alarm.reload.at == HoursAndMinutes.new(12, 34)
```


## Development

After checking out the repo, run `bin/setup` to install dependencies. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/labocho/hours_and_minutes.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
