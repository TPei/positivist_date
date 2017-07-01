# positivist_date [![Build Status](https://travis-ci.org/TPei/positivist_date.svg?branch=master)](https://travis-ci.org/TPei/positivist_date)

Implementation of the [Positivist Calendar](https://en.wikipedia.org/wiki/Positivist_calendar) as an alternative to Crystal's [Time](https://crystal-lang.org/api/latest/Time.html)

## Installation

Add to your shard.yml

```yaml
dependencies:
  positivist_date:
    github: tpei/positivist_date
    branch: master
```

and then install the library into your project with

```bash
$ crystal deps
```

## Usage

```crystal
# Can be used as Time would be
pd = PositivistDate.new(224, 6, 13, 13, 37)
pd.hour # => 13
pd.saturday? # => true

# allows converting to time instance
pd.to_time # => 2012-06-30 13:37:00

# PostivistDate instances can be created from Time instances
PositivistDate.from_time Time.now # => #<PositivistDate:0x1084f9f50>
```

## Development

TODO: Write development instructions here

## Contributing

1. Fork it ( https://github.com/tpei/positivist_date/fork )
2. Create your feature branch (git checkout -b my-new-feature)
3. Commit your changes (git commit -am 'Add some feature')
4. Push to the branch (git push origin my-new-feature)
5. Create a new Pull Request

## Contributors

- [tpei](https://github.com/tpei) TPei - creator, maintainer
