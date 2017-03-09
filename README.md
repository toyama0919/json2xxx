# json2xxx [![Build Status](https://secure.travis-ci.org/toyama0919/json2xxx.png?branch=master)](http://travis-ci.org/toyama0919/json2xxx)

convert jsonl to other format.

### Convert csv

```
$ cat test.json
{"integer_column":1,"strong_column":"strong1","this_record_column":"hoge"}
{"integer_column":2,"strong_column":"strong2"}
{"integer_column":3,"strong_column":"strong3"}
{"integer_column":4,"strong_column":"strong4"}
{"integer_column":5,"strong_column":"strong5"}

$ cat test.json | json2xxx csv
"integer_column","strong_column","this_record_column"
"1","strong1","hoge"
"2","strong2",""
"3","strong3",""
"4","strong4",""
"5","strong5",""

$ cat test.json | json2xxx csv -f strong_column this_record_column
"strong_column","this_record_column"
"strong1","hoge"
"strong2",""
"strong3",""
"strong4",""
"strong5",""
```

### Convert Excel

```
$ cat test.json | json2xxx excel
write 20170309140309.xls
```

## Installation

Add this line to your application's Gemfile:

    gem 'json2xxx'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install json2xxx

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new [Pull Request](../../pull/new/master)

## Information

* [Homepage](https://github.com/toyama0919/json2xxx)
* [Issues](https://github.com/toyama0919/json2xxx/issues)
* [Documentation](http://rubydoc.info/gems/json2xxx/frames)
* [Email](mailto:toyama0919@gmail.com)

## Copyright

Copyright (c) 2014 Hiroshi Toyama

See [LICENSE.txt](../LICENSE.txt) for details.
