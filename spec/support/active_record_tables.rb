require 'active_record'

ActiveRecord::Base.establish_connection(:adapter => 'sqlite3', :database => ":memory:")

ActiveRecord::Migration.suppress_messages do
  ActiveRecord::Schema.define(:version => 0) do
    create_table :users, :force => true do |t|
      t.string :name
    end

    create_table :posts, :force => true do |t|
      t.string :title
    end

    create_table :comments, :force => true do |t|
      t.string :title
    end

    create_table :bustle_activities, :force => true do |t|
      t.string  :resource_class
      t.integer :resource_id
      t.string  :action, :default => ''
      t.text    :data,   :default => ''
      t.integer :publisher_id
      t.timestamps
    end

    create_table :bustle_publishers, :force => true do |t|
      t.string  :resource_class
      t.integer :resource_id
      t.timestamps
    end

    create_table :bustle_subscribers, :force => true do |t|
      t.string  :resource_class
      t.integer :resource_id
      t.timestamps
    end

    create_table :bustle_subscriptions, :force => true do |t|
      t.integer :publisher_id
      t.integer :subscriber_id
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
