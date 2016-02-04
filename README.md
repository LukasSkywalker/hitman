# Hitman

Welcome to your new gem! In this directory, you'll find the files you need to be able to package up your Ruby library into a gem. Put your Ruby code in the file `lib/hitman`. To experiment with that code, run `bin/console` for an interactive prompt.

TODO: Delete this and the text above, and describe your gem

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'hitman'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install hitman

## Usage

At the moment, Hitman can only auto-analyse Grape APIs, but if you have any other API, you can still use it by supplying the configuration manually.

First, define a target to attack. It is best to run your API locally, for speed reasons.

```ruby
t = Hitman::Target.new('my api', 'http://localhost:9292')
```

Hitman needs the name and the address of its target. He's gonna find out the rest. No need for a picture.

If your API uses param authentication, you can supply `postfix` data which will be attached to every request made, e.g. if you need to authenticate:

```ruby
t.postfix = { email: 'test@hitman.org', password: '12345678' }
```

Hitman first needs to analyse the target to find the best possible strategy to attack. Load your API class and pass it, along with a reference to your target, to Hitman:

```ruby
scanner = Hitman::Scanner.new
target = scanner.scan_grape(t, API)
```

Hitman is ready and armed now. Start the fuzzer and watch chaos unfold.

```ruby
fuzzer = Hitman::Fuzzer.new
fuzzer.start(target)
```

## Not using a Grape API? No problem.

You just manually need to supply some secret information to Hitman.

First, create a target:

```ruby
t = Hitman::Target.new('my api', 'http://localhost:9292')
```

Then, for every endpoint of your API, you need to supply the HTTP method, the path and possible parameters in the form

```ruby
route = Hitman::Route.new('post', '/api/users')
t.routes << route
route.params << Hitman::Param.new('email', 'string')
route.params << Hitman::Param.new('password', 'string')
route.params << Hitman::Param.new('password_confirmation', 'string')
```

You can use this example:

```ruby
my_api_routes.each do |api_route|
  route = Hitman::Route.new(api_route.method, api_route.path)
  t.routes << route
  api_route.params.each do |name, type|
    route.params << Hitman::Param.new(name, type)
  end
end
```

After that, you're ready to run the Fuzzer.

## Development

After checking out the repo, run `bin/setup` to install dependencies. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/hitman.