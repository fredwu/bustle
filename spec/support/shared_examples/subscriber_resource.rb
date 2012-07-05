shared_examples 'subscriber_resource' do
  let(:pubsub_class) { Bustle::Subscribers }
  let(:pubsub_type)  { 'subscriber' }

  it_behaves_like '_pubsub_resource'
end
