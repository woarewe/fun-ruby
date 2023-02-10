# *Fun*ctional Ruby 🚀

An experimental toolbox for writing "functional" Ruby.

![Alt Text](assets/fun.gif)

## Motivation

In 2020 I started looking into functional programming and got really
excited about having a Ruby library that would make programming in Ruby feel
as much close as possible to using "pure" functional languages.

## Features

### Action first, data last

### 100% Curried

### Placeholder

### Definition container

## Installation

### Useful resources

Add this line to your application's Gemfile:

```ruby
gem 'fun-ruby'
```

And then execute:
```shell 
bundle install
```

Or install it yourself as:
```shell
gem install fun-ruby
```

## Useful resources to dive into functional programming

 - [Hey Lodash, you're doing it wrong!](https://www.youtube.com/watch?v=ixbJrJTOnF8)
 - [Ramda JS](https://ramdajs.com/)
 - [Ramda JS Ruby Port](https://github.com/lazebny/ramda-ruby)
 - [Lambda Calculus - Fundamentals of Lambda Calculus & Functional Programming in JavaScript](https://www.youtube.com/watch?v=3VQ382QG-y4)
 - [Why Isn't Functional Programming the Norm? – Richard Feldman](https://www.youtube.com/watch?v=QyJZzq0v7Z4)

## Contributing

**All kinds of contributions are welcome!**

In case you don't really know where to start, just read the details down below 😉

### Library structure

1) All the implemented modules are located under `lib/fun_ruby/modules`.
Most of the modules have the names matching correspondent Ruby Core classes/modules.
For example, if you are looking for the entry point of `Array` you will find it
at `lib/fun_ruby/modules/array.rb`

2) A module entry point file contains only the module definition and
a method being used to coerce an input to the object that the module works with.

3) Each implemented function has its own file. For instance `Array#size` is located
under `lib/fun_ruby/modules/array/size.rb`

### CLI

The library goes with a useful command line interface that will help you
to add new modules and functions without typing much boilerplate.

**Adding a new module**
```shell
bin/generate module <MODULE_NAME>
```

**Adding a new function to a module**
```shell
 # TODO: Will be added soon
```
