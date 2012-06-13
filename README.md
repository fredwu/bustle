# Bustle [![Build Status](https://secure.travis-ci.org/fredwu/bustle.png?branch=master)](http://travis-ci.org/fredwu/bustle) [![Dependency Status](https://gemnasium.com/fredwu/bustle.png)](https://gemnasium.com/fredwu/bustle) [![Code Climate](https://codeclimate.com/badge.png)](https://codeclimate.com/github/fredwu/bustle)

Activities recording and retrieving using a simple Pub/Sub architecture.

The typical use cases are:

- Timeline (e.g. tracking activities such as posting and commenting for users)
- Logging

The advantages of Bustle are:

- It is lightweight and simple to use
- It is largely self-contained and separated from you core app logic
- It works nicely with ActiveRecord out of box
- It is ORM-agnostic therefore can be extended to use with other databases
- It has full unit test coverage

Bustle is built for simplicity and extensibility. If you are after high performance pub/sub then this gem is not for you.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'bustle'
```

## Usage

### Configuration

First of all, you will need to configure Bustle. If you are using Rails, you can put the following code in an initializer (e.g. `config/initializers/bustle.rb`).

```ruby
Bustle.config do |c|
  # Specify a storage strategy for storing activities
  # Bustle ships with an ActiveRecord storage strategy
  c.storage = Bustle::Storage::ActiveRecord
end
```

For ActiveRecord, you will need the following migration file:

```ruby
class CreateBustleTables < ActiveRecord::Migration
  def change
    create_table :bustle_activities do |t|
      t.string  :resource_class
      t.integer :resource_id
      t.string  :action,       :default => ''
      t.text    :data,         :default => ''
      t.integer :publisher_id, :null => false
      t.timestamps
    end

    create_table :bustle_publishers do |t|
      t.string  :resource_class, :null => false
      t.integer :resource_id,    :null => false
      t.timestamps
    end

    create_table :bustle_subscribers do |t|
      t.string  :resource_class, :null => false
      t.integer :resource_id,    :null => false
      t.timestamps
    end

    create_table :bustle_subscriptions do |t|
      t.integer :publisher_id,  :null => false
      t.integer :subscriber_id, :null => false
      t.timestamps
    end

    add_index :bustle_activities, :publisher_id
    add_index :bustle_publishers, [:resource_class, :resource_id], :unique => true
    add_index :bustle_subscribers, [:resource_class, :resource_id], :unique => true
    add_index :bustle_subscriptions, :publisher_id
    add_index :bustle_subscriptions, :subscriber_id
    add_index :bustle_subscriptions, [:publisher_id, :subscriber_id], :unique => true
  end
end
```

### Flow

Upon subscribing:

1. Subscriber registers itself if not already registered
2. Publisher registers itself if not already registered
3. A Subscription is created for Subscriber and Publisher

When activities occur:

1. Publisher registers itself if not already registered
2. Publisher publishes activity

### API

#### Register a Subscriber

```ruby
Bustle::Subscribers.add subscriber

# example
user = User.find(1)
Bustle::Subscribers.add user
```

#### Register a Publisher

```ruby
Bustle::Publishers.add publisher

# example
post = Post.find(1)
Bustle::Publishers.add post
```

#### Create a Subscription

```ruby
Bustle::Subscriptions.add bustle_publisher, bustle_subscriber

# example
publisher  = Bustle::Publishers.get(Post.first)
subscriber = Bustle::Subscribers.get(User.first)
Bustle::Subscriptions.add publisher, subscriber
```

#### Find a Subscriber/Publisher/Subscription

```ruby
Bustle::Subscribers.get subscriber
Bustle::Publishers.get publisher
Bustle::Subscriptions.get bustle_publisher, bustle_subscriber # => Bustle::Subscription
Bustle::Subscriptions.by bustle_publisher # => an array of Bustle::Subscription by the publisher
Bustle::Subscriptions.for bustle_subscriber # => an array of Bustle::Subscription for the subscriber
```

#### Remove a Subscriber/Publisher/Subscription

```ruby
Bustle::Subscribers.remove subscriber
Bustle::Publishers.remove publisher
Bustle::Subscriptions.remove bustle_publisher, bustle_subscriber
```

Or:

```ruby
Bustle::Subscribers.get(subscriber).destroy
Bustle::Publishers.get(publisher).destroy
Bustle::Subscriptions.get(bustle_publisher, bustle_subscriber).destroy
```

#### Publish an Activity

```ruby
Bustle::Activities.add bustle_publisher, {
  :resource => some_resource,
  :action   => some_string,
  :data     => some_text
}
# or
Bustle::Publisher.publish({
  :resource => some_resource,
  :action   => some_string,
  :data     => some_text
})

# example
post    = Post.find(1)
comment = post.comments.add(:content => "I'm a comment")
Bustle::Publishers.add post
publisher = Bustle::Publishers.get post
publisher.publish({
  :resource => comment,
  :action   => 'new,
  :data     => 'a new comment has been posted'
})
```

#### Activities

##### Retrieve Activities for a Subscriber

```ruby
Bustle::Activities.for bustle_subscriber
# or
Bustle::Subscriber.activities

# example
subscriber = Bustle::Subscribers.get(User.first)
subscriber.activities
```

##### Retrieve Activities by a Publisher

```ruby
Bustle::Activities.by bustle_publisher
# or
Bustle::Publisher.activities

# example
publisher = Bustle::Publishers.get(Post.first)
publisher.activities
```

#### Filtering (for Activities and Subscriptions)

```ruby
Bustle::Activities.filter :key => :value
Bustle::Subscriptions.filter :key => :value
# or
Bustle::Subscriber.activities :key => :value

# example
subscriber = Bustle::Subscribers.get(User.first)
subscriber.activities :action => 'new'
```

## License

This gem is released under the [MIT License](http://www.opensource.org/licenses/mit-license.php).

## Author

[Fred Wu](https://github.com/fredwu), originally built for [500 Startups](http://500.co).
