shared_examples '_pubsub_resource' do
  context "pubsub_resource" do
    let(:pubsub_resource) { Bustle::Dummy::User.create! :name => 'Fred' }
    let(:factory_class)   { described_class }
    let(:factory_name)    { factory_class.to_s.split('::').last.downcase.to_sym }

    let(:record) do
      resource = pubsub_class.add pubsub_resource
      create factory_name,
        "#{pubsub_type}_id" => resource.id
    end

    it "references the resource" do
      record.send("#{pubsub_type}_resource").should == pubsub_resource
    end
  end
end
