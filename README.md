# Rdi

Welcome to your new gem! In this directory, you'll find the files you need to be able to package up your Ruby library into a gem. Put your Ruby code in the file `lib/rdi`. To experiment with that code, run `bin/console` for an interactive prompt.

TODO: Delete this and the text above, and describe your gem

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'rdi'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install rdi

## Usage


We have two primary entities: the _container_ and the _context_.
First, we should create and fill a container, and then convert it to a context, to be used globally.

Lets create a container:
```ruby
require 'rdi'
container = RDI.container(:development)
```

Lets see how to fill the container using a block:
```ruby
container.build do
  add_dependency :repository do
    Repository.new
  end
  add_dependency :writer do
    Writer.new(repository)
  end
  override_dependency :repository do
    RepositoryWithCache.new
  end
end
```

Another option is having a configuration file:
```ruby
container.read('resources/rdi/development')
```

This configuration file should look like this:
```ruby
add_dependency :repository do
  Repository.new
end
add_dependency :writer do
  Writer.new(repository)
end
override_dependency :repository do
  RepositoryWithCache.new
end
```

Lets convert the container to a context:
```ruby
RDI.context = RDI.container(:development).context
```

Now we can enjoy using dependency injection!
```ruby
writer = RDI.context.dependency(:writer)
```

Another approach: you can create autowired accessors...
```ruby
require 'rdi/autowired'
class Writer
  autowired :repository
  def write(something)
    repository.save(something)
  end
end
```

And the autowired accessor can have a custom name:
```ruby
require 'rdi/autowired'
class Writer
  autowired :elasticsearch_repository, as: :repository
  def write(something)
    repository.save(something)
  end
end
```

## Testing


Lets see an example in RSpec:
```ruby
require 'rdi/autowired'
require 'rspec'

RSpec.describe Writer do

  let(:repository_mock) { double 'repository' }

  before :each do
    RDI.context.inject(:repository) { repository_mock }
  end

  it 'should call repository#save' do
    expect(repository_mock).to receive(:save).with('something').once
    writer = Writer.new
    writer.write('something')
  end

end
```
