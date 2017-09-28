# ToyRobot

## Description

* The application is a simulation of a toy robot moving
on a square tabletop, of dimensions 5 units x 5 units.
* There are no other obstructions on the table surface.
* The robot is free to roam around the surface of the table,
but must be prevented from falling to destruction.
Any movement that would result in the robot falling
from the table must be prevented, however further
valid movement commands must still be allowed.

## Task

Create an application that can read in commands of the following form:

```
PLACE X,Y,F
MOVE
LEFT
RIGHT
REPORT
```

* `PLACE` will put the toy robot on the table in position X,Y
and facing `NORTH`, `SOUTH`, `EAST` or `WEST`.
* The origin (0,0) can be considered to be the `SOUTH WEST` most corner.
* The first valid command to the robot is a `PLACE` command,
after that, any sequence of commands may be issued, in any order,
including another `PLACE` command.
The application should discard all commands in the sequence
until a valid `PLACE `command has been executed.
* `MOVE` will move the toy robot one unit forward
in the direction it is currently facing.
* `LEFT` and `RIGHT` will rotate the robot 90 degrees
in the specified direction
without changing the position of the robot.
* `REPORT` will announce the X,Y and F of the robot.
This can be in any form, but standard output is sufficient.

* A robot that is not on the table can choose
to ignore the `MOVE`, `LEFT`, `RIGHT` and `REPORT` commands.
* Input can be from a file, or from standard input, as the developer chooses.
* Provide test data to exercise the application.
* It is not required to provide any graphical output
showing the movement of the toy robot.

## Constraints

The toy robot must not fall off the table during movement.
This also includes the initial placement of the toy robot.
Any move that would cause the robot to fall must be ignored.

Example Input and Output:

```
# Example a
PLACE 0,0,NORTH
MOVE
REPORT
# Output: 0,1,NORTH
```


```
# Example b
PLACE 0,0,NORTH
LEFT
REPORT
# Output: 0,0,WEST
```


```
# Example c
PLACE 1,2,EAST
MOVE
MOVE
LEFT
MOVE
REPORT
# Output: 3,3,NORTH
```

## Acknowledgement

The Toy Robot Challenge was originally formulated by [Jon Eaves](https://twitter.com/joneaves)

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'toy_robot'
```

And then execute:

    $ bundle

Or install it yourself locally (the gem is not available on rubygems):

    $ git clone git@github.com:dcnorman/toy_robot.git
    $ cd toy_robot
    $ bundle exec rake install

## Usage

If you have installed the gem locally you can use the binary:

    $ toy_robot

Otherwise you can use the [non-executable binary included with the gem](https://github.com/bundler/bundler/pull/2380):

    $ ruby -I lib -S exe/toy_robot

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/dcnorman/toy_robot.

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
