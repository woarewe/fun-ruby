# *Fun*ctional Ruby 🚀

An experimental toolbox for writing "functional" Ruby.

![Alt Text](assets/fun.gif)

## Motivation

In 2020 I started looking into functional programming and got really
excited about having a Ruby library that would make programming in Ruby feel
as much close as possible to using "pure" functional languages.

## Features

### 100% Curried

A function will be called only after all the required arguments are
passed. Until that the function will be returning a wrapper
expecting the rest of arguments.

```ruby
# F::Modules::Hash.fetch requires two arguments:
# - a key
# - a hash

# Calling a function without any argument returns 
# a function expecting the rest arguments to be applied 
# either one by one or altogether at once
f = F::Modules::Hash.fetch 
f.(:number, { number: 3 }) # => 3
f.(:number).({ number: 3 }) # => 3
```

### Action first, data last

> For better understanding I strongly recommend
> to watch this [video](https://www.youtube.com/watch?v=ixbJrJTOnF8).

Given that functions are curried, changing function signatures
in order to have the params that change more rarely first and
the params that change more often last allows us to 
create new more specific functions from more generic ones.

```ruby
  rails = { stars: 52_300 }
  f_ruby = { stars: 3 }
  repos = [rails, f_ruby]
  
  # Creating a function that gets a number stars
  stars = F::Modules::Hash.fetch(:stars)
  stars.(rails) # => 52_300
  stars.(f_ruby) # => 3
  
  # Creating a function that gets a number of stars for an array
  stars_map = F::Modules::Enum.map(get_stars)
  stars_map.(repos) #=> [52_300, 3]
```

### Argument placeholders

However, there are situations when data remains the same
but the applicable actions differ. In such case there is
a placeholder `F._` that can help to achieve the desired behavior.

```ruby
rails = { stars: 52_300, forks: 10_000 } 
fetch_from_rails = F::Modules::Hash.fetch(F._, rails)
fetch_from_rails.(:stars) # => 52_300
fetch_from_rails.(:forks) # => 10_000
```

### Helpful utils

The library goes with a set of utils that will
help you achieve your goals in an elegant way.
For example, the pipe function:
```ruby
repos = [
  { name: 'Rails', stars: 52_300 },
  { name: 'FunRuby', stars: 3 }
]

label = F::Modules::Function.pipe(
  F::Modules::Hash.values_at([:name, :stars]), # returns pairs of [name, stars]
  F::Modules::Array.join(" -> "), # joins the pairs
)

labels = F::Modules::Enum.map(label)
labels.(repos) # => ["Rails -> 52300", "FunRuby -> 3"]
```

Or the curry function that will make the
functions from your codebase fully compatible with the library utils.

```ruby
# A function from your codebase
def join_three_values(first, second, third)
  [first, second, third].join(' ')
end

a, b, c  = ["A", "B", "C"]

join_three_values(a, b, c) #=> "A B C"

# Making it curried...
curried = F::Modules::Function.curry(method(:join_three_values))

# Using it as a library function
curried.(a).(b).(c) # => "A B C"

# It evens supports placeholders
paste_in_the_middle =  curried.("Beginning", F._, "End")
paste_in_the_middle.("I'm in the middle") # => "Beginning I'm in the middle End"
```

### Definition containers

Let's say we've got a pair of functions
and we would like to reuse them across the different parts
of our application. Since local variables are not exportable
to other files the ways we can share the functions are:
1. Assigning them to constants
2. Assigning them to global variables
3. Returning them from class singleton methods

But none of the approaches are really needed because
the library comes with a container where you can define.
Here is an example:

```ruby
# definition.rb

F.define do
  f(:repo_stars) { F::Modules::Hash.fetch(:stars) }
  f(:repo_name) { F::Modules::Hash.fetch(:name) }
end

# another_file.rb
repo = { stars: 33, name: 'FunRuby'}
F.container.fetch(:repo_name).(repo) # => "FunRuby"
F.container.fetch(:repo_stars).(repo) # => 33
```

What? Function names have the repetitive part **repo**? Let's puts
them under a namespace!


```ruby
# definition.rb
F.define do
  namespace :repo do
    f(:stars) { F::Modules::Hash.fetch(:stars) }
    f(:name) { F::Modules::Hash.fetch(:stars) }
  end
end

# another_file.rb
repo = { stars: 33, name: 'FunRuby'}
F.container.fetch("repo.name").(repo) # => "FunRuby"
F.container.fetch("repo.stars").(repo) # => 33
```

But what I we want to use the functions inside classes or modules?
The way we access the function and call it seems too long and inconvenient.
This is not a problem either because the container can be imported.

```ruby
# definition.rb
F.define do
  namespace :repo do
    f(:stars) { F::Modules::Hash.fetch(:stars) }
    f(:name) { F::Modules::Hash.fetch(:name) }
  end
  
  namespace :hello do
    f(:word) { -> { puts "Hello, world" } }
  end
end

# another_file.rb
class Feature
  include F.import(:repo, :hello)
  
  def execute(repo)
    puts f(:stars).(repo)
    puts f(:name).(repo)
    puts f(:word).()
  end
end

repo = { stars: 33, name: 'FunRuby'}
Feature.new.execute(repo)
```

Sometimes it also happens that the definition of
a function is deeply nested or there are two functions or two namespaces
that have the same name and we want them both to be present in the same scope.
The container imports support aliasing.
You can alias both a final function and a namespace.


```ruby
F.define do
  namespace :foo do
    namespace :buzz do
      namespace :bar do
        f(:hello) { -> { puts "Hello from Bar!" } }
        f(:goodbye) { -> { puts "Goodbye from Bar!" } }
      end
    end
  end
  
  namespace :green do
    namespace :red do
      namespace :blue do
        f(:hello) { -> { puts "Hello from Blue!" } }
        f(:goodbye) { -> { puts "Goodbye from Blue!" } }
      end
    end
  end
end

class Feature
  include F.import(
    'foo.buzz.bar' => 'top',
    'green.red.blue' => 'bottom',
    'foo.buzz.bar.goodbye' => 'top_bye',
    'green.red.blue.goodbye' => 'bottom_bye'
  )

  def execute
    puts f('top.hello').()
    puts f('bottom.hello').()
    puts f('top_bye').()
    puts f('bottom_bye').()
  end
end
```

### Comprehensive docs & reliable examples

All the functions have RubyDoc with examples
that are run as tests on CI. So, they are just working!

API Docs.

### Ruby core compatible

**In progress...**

The library is aimed to cover most of th methods the core ruby classes have.

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
