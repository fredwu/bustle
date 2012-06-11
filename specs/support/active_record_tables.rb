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
      t.string  :action
      t.integer :publisher_id, :null => false
      t.timestamps
    end

    create_table :bustle_publishers, :force => true do |t|
      t.string  :resource_class, :null => false
      t.integer :resource_id,    :null => false
      t.timestamps
    end

    create_table :bustle_subscribers, :force => true do |t|
      t.string  :resource_class, :null => false
      t.integer :resource_id,    :null => false
      t.timestamps
    end

    create_table :bustle_subscriptions, :force => true do |t|
      t.integer :publisher_id,  :null => false
      t.integer :subscriber_id, :null => false
      t.timestamps
    end
  end
end
