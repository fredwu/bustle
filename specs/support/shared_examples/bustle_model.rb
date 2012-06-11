shared_examples 'bustle_model' do
  STORAGES.each do |storage|
    context "storage #{storage}" do
      before(:all) do
        Bustle.config { |c| c.storage = storage }
      end

      it "has correct parent classes" do
        described_class.superclass.to_s.should == "#{Bustle.storage}::#{described_class.name.split('::').last}"
      end

      it "is able to create a new instance" do
        described_class.respond_to?(:create!).should == true
      end
    end
  end
end