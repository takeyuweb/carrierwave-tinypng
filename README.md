# CarrierWave::TinyPNG

TinyPNG support for CarrierWave

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'carrierwave-tinypng'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install carrierwave-tinypng

## Usage

```ruby
CarrierWave::TinyPNG.configure do |config|
  config.key = ENV['TINYPNG_KEY']
end
```

```ruby
class YourUploader < CarrierWave::Uploader::Base
  include CarrierWave::RMagick
  include CarrierWave::TinyPNG
  process convert: 'png'
  process :tinypng
end
```

## Contributing

1. Fork it ( https://github.com/takeyuweb/carrierwave-tinypng/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
