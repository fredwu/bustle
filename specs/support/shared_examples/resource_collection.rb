shared_examples 'resource_collection' do
  it "adds a model record" do
    described_class.add user
    model = described_class::RESOURCE_NAME.constantize.to_adapter.get(1)
    model.resource_class.should == 'Bustle::Dummy::User'
    model.resource_id.should == 42
  end
end