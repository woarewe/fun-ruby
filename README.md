# *Fun*ctional Ruby 🚀

A toolbox for writing functional Ruby.

![Alt Text](assets/fun.gif)

## Inspirations

## Features

### Curried by design

### Placeholder

### Definition container

## Installation

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


## Contributing

**All kinds of contributions are welcome!**

However, you don't really know where to start read the details down below.

### Library structure

1) All the implemented modules are located under `lib/fun_ruby/modules`.
Most of the modules have the names that correspondent Ruby Core classes/modules have.
So, if you are looking for the entry point of `Array` you will find it
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
