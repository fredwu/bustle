shared_examples 'resource_collection' do
  let(:resource_class) { described_class::RESOURCE_NAME.constantize.to_adapter }

  before do
    described_class.add user
  end

  it "adds a model record" do
    model = resource_class.get(1)
    model.resource_class.should == 'Bustle::Dummy::User'
    model.resource_id.should == 42
  end

  it "finds a model record" do
    model = described_class.get user
    model.resource_class.should == 'Bustle::Dummy::User'
    model.resource_id.should == 42
  end

  it "removes a model record" do
    described_class.get(user).destroy
    resource_class.find_all({}).count.should == 0
  end
end