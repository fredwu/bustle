shared_examples 'target_resource' do
  context "target_resource" do
    let(:target_resource) { Bustle::Dummy::User.create! :name => 'Fred' }
    let(:factory_class)   { described_class }
    let(:factory_name)    { factory_class.to_s.split('::').last.downcase.to_sym }

    let(:record) do
      create factory_name,
        :resource_class => target_resource.class.name,
        :resource_id    => target_resource.id
    end

    it "references the target resource" do
      record.target_resource.should == target_resource
    end
  end
end
