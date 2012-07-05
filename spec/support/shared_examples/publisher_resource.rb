shared_examples 'publisher_resource' do
  let(:pubsub_class) { Bustle::Publishers }
  let(:pubsub_type)  { 'publisher' }

  it_behaves_like '_pubsub_resource'
end
