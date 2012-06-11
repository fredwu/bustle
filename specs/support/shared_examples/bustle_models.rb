shared_examples 'bustle_models' do
  STORAGES = [
    Bustle::Storage::ActiveRecord
  ]

  STORAGES.each do |storage|
    context "storage #{storage}" do
      before(:all) do
        Bustle.config { |c| c.storage = storage }
      end

      it "has correct parent classes" do
        described_class.superclass.to_s.should == "#{Bustle.storage}::#{described_class.name.split('::').last}"
      end
    end
  end
end