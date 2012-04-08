# Net::Http::Batch

Really simple batch requests around Net::HTTP::Persistent.

## Installation

``` ruby
gem 'net-http-batch'
```

``` bash
gem install net-http-batch
```

## Usage

``` ruby
require 'net/http/batch'
http = Net::HTTP::Batch.new
100.times { http.request URI("http://example.org"), Net::HTTP::Get.new("/") }
results = http.run
```

## TODO

 * Send patch for net-http-persistent shutdown bug
 * Use pipelining when available
 * Further allow for dynamic batches
 * Add evented collection interface
 * Add evented error handling interface

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
