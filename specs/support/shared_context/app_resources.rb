shared_context 'app_resources' do
  let(:user) { Bustle::Dummy::User.create! :name => 'Fred' }
  let(:post) { Bustle::Dummy::Post.create! :title => 'hello' }
  let(:comment) { Bustle::Dummy::Comment.create! :title => 'hi' }

  before(:all) do
    user.update_attribute :id, 42
    post.update_attribute :id, 69
    comment.update_attribute :id, 101
  end
end
