# Grpc Demo

This repository goes together with a [blog post](http://gustavocaso.github.io/2018/03/grpc-tutorial-with-ruby/) to explain how [Grpc](https://grpc.io/) works.

## Motivation

Understand how `Grpc` works and help others learn it as well.

## How to use it

The best way to use is by downloading the code to your machine and interact with it.

To interact with it you will need to download all the dependencies using `bundler` don't worry there are only two dependencies `grpc` and `grpc-tools` after that you can simply fire a console `bin/console` and start playing with it.

**Starting the server**

Inside the console, you can run `GrpcDemo.start_server` and it will start a `Grpc` server which we would interact with the client.

```ruby
irb(main):002:0> GrpcDemo.start_server
... running insecurely on 50051
```

**Using the client**

On another window terminal start a new console `bin/console` , and we can use the [client](https://github.com/GustavoCaso/grpc_ruby_demo/blob/master/lib/grpc_demo/client.rb) to send messages to the server.

Let say we want to get a location from the server we just execute `GrpcDemo.client_get_location` and we should see some output.

```ruby
irb(main):001:0> GrpcDemo.client_get_location
"GetLocation"
"----------"
"- found 'Berkshire Valley Management Area Trail, Jefferson, NJ, USA' at <Routeguide::Coordinate: latitude: 409146138, longitude: -746188906>"
"- found nothing at <Routeguide::Coordinate: latitude: 0, longitude: 0>"
# => [<Routeguide::Coordinate: latitude: 409146138, longitude: -746188906>, <Routeguide::Coordinate: latitude: 0, longitude: 0>]
```

We have for client functions that interact with the server `client_get_location`, `client_list_locations`, `client_record_route`, `client_route_chat` use them and see the output

**Recommendation**

Look through the code and read the [blog post](http://gustavocaso.github.io/2018/03/grpc-tutorial-with-ruby/) to get a better understanding of how everything is working.

If you want to recreate the,  Grpc files run `make`.

## Roadmap

- [ ] Allow client command to accept arguments, right now all the data is hardcoded.
- [ ] Add testing, this way we will be able to revisit part of the code and changed more secure.
- [ ] Investigate `ErrorHandling`
- [ ] ...

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/grpc_demo. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the GrpcDemo project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/[USERNAME]/grpc_demo/blob/master/CODE_OF_CONDUCT.md).
