# Bustle [![Build Status](https://secure.travis-ci.org/fredwu/bustle.png?branch=master)](http://travis-ci.org/fredwu/bustle) [![Dependency Status](https://gemnasium.com/fredwu/bustle.png)](https://gemnasium.com/fredwu/bustle) [![Code Climate](https://codeclimate.com/badge.png)](https://codeclimate.com/github/fredwu/bustle)

Activities recording and retrieving using a simple Pub/Sub architecture.

The typical use cases are:

- Timeline (e.g. tracking activities such as posting and commenting for users)
- Logging

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
      t.string  :action
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

#### Completion Status

Complete list of APIs to build:

- [x] `Bustle::Subscribers.add`
- [x] `Bustle::Publishers.add`
- [x] `Bustle::Subscriptions.add`
- [ ] `Bustle::Subscribers.find`
- [ ] `Bustle::Publishers.find`
- [ ] `Bustle::Subscriptions.find`
- [ ] `Bustle::Subscribers.remove`
- [ ] `Bustle::Publishers.remove`
- [ ] `Bustle::Subscriptions.remove`
- [ ] `Bustle::Subscriber.destroy`
- [ ] `Bustle::Publisher.destroy`
- [ ] `Bustle::Subscription.destroy`
- [x] `Bustle::Activities.add`
- [ ] `Bustle::Publisher.publish`
- [ ] `Bustle::Activities.for`
- [ ] `Bustle::Subscriber.activities`
- [ ] `Bustle::Activities.by`
- [ ] `Bustle::Publisher.activities`
- [ ] `Bustle::Activities.filter`
- [ ] `Bustle::Activities.delegate`

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
publisher  = Bustle::Publishers.find(Post.first)
subscriber = Bustle::Subscribers.find(User.first)
Bustle::Subscriptions.add publisher, subscriber
```

#### Find a Subscriber/Publisher/Subscription

```ruby
Bustle::Subscribers.find subscriber
Bustle::Publishers.find publisher
Bustle::Subscriptions.find bustle_publisher, bustle_subscriber # => Bustle::Subscription
Bustle::Subscriptions.find bustle_publisher # => an array of Bustle::Subscription for the publisher
Bustle::Subscriptions.find bustle_subscriber # => an array of Bustle::Subscription for the subscriber
```

#### Remove a Subscriber/Publisher/Subscription

```ruby
Bustle::Subscribers.remove subscriber
Bustle::Publishers.remove publisher
Bustle::Subscriptions.remove bustle_publisher, bustle_subscriber
```

Or:

```ruby
Bustle::Subscribers.find(subscriber).destroy
Bustle::Publishers.find(publisher).destroy
Bustle::Subscriptions.find(bustle_publisher, bustle_subscriber).destroy
```

#### Publish an Activity

```ruby
Bustle::Activities.add bustle_publisher, action, activity
# or
Bustle::Publisher.publish action, activity

# example
post    = Post.find(1)
comment = post.comments.add(:content => "I'm a comment")
Bustle::Publishers.add post
publisher = Bustle::Publishers.find post
publisher.publish 'new', comment
```

#### Activities

##### Retrieve Activities for a Subscriber

```ruby
Bustle::Activities.for bustle_subscriber
# or
Bustle::Subscriber.activities

# example
subscriber = Bustle::Subscribers.find(User.first)
subscriber.activities
```

##### Retrieve Activities by a Publisher

```ruby
Bustle::Activities.by bustle_publisher
# or
Bustle::Publisher.activities

# example
publisher = Bustle::Publishers.find(Post.first)
publisher.activities
```

##### Activities Filtering

```ruby
Bustle::Activities.for(bustle_subscriber).filter :key => :value
# or
Bustle::Subscriber.activities.filter :key => :value

# example
subscriber = Bustle::Subscribers.find(User.first)
subscriber.activities.filter :action => 'new'
subscriber.activities.by(publisher).filter(:action => 'new')
```

Activities are normal enumerable objects from your chosen storage, so in ActiveRecord's case, you may use any Arel methods to query the result:

```ruby
subscriber.activities.filter(:action => 'new').order('created_at ASC').limit(10)
```

## License

This gem is released under the [MIT License](http://www.opensource.org/licenses/mit-license.php).

## Author

[Fred Wu](https://github.com/fredwu), originally built for [500 Startups](http://500.co).
