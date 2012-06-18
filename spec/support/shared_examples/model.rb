shared_examples 'model' do
  BUSTLE_STORAGES.each do |storage|
    let(:factory_class) { described_class }
    let(:factory_name)  { factory_class.to_s.split('::').last.downcase.to_sym }

    before(:all) do
      Bustle.config { |c| c.storage = storage }

      _factory_class = described_class
      _factory_name  = factory_name

      FactoryGirl.define do
        factory _factory_name, :class => _factory_class do
        end
      end
    end

    context "storage #{storage}" do
      it "has correct parent classes" do
        described_class.superclass.to_s.should == "#{Bustle.storage}::#{described_class.name.split('::').last}"
      end

      it "is able to create a new instance" do
        described_class.to_adapter.respond_to?(:create!).should == true
      end

      it "is able to destroy itself" do
        described_class.new.respond_to?(:destroy).should == true

        create factory_name
        described_class.to_adapter.find_all({}).count.should == 1

        described_class.to_adapter.find_first({}).destroy
        described_class.to_adapter.find_all({}).count.should == 0
      end
    end
  end
end