shared_examples 'bustle_resource_model' do
  before(:all) do
    BUSTLE_COLLECTION_MODEL_DICT ||= {
      Bustle::Publishers  => Bustle::Publisher,
      Bustle::Subscribers => Bustle::Subscriber
    }
  end

  it "adds a model record" do
    described_class.add user
    model = BUSTLE_COLLECTION_MODEL_DICT[described_class].to_adapter.get(1)
    model.resource_class.should == 'Bustle::Dummy::User'
    model.resource_id.should == 42
  end
end