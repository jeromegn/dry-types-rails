require 'spec_helper'

describe Dry::Types::Rails::Railtie do
  def clear_autoload
    ActionDispatch::Reloader.prepare!
    ActiveSupport::Dependencies.clear
  end

  before(:each) do |example|
    if example.metadata[:clear_autoload]
      clear_autoload
    end
  end

  describe "non-autoload" do
    context "types" do
      it "registers them" do
        expect(Types::Coercible::String[1234]).to eq("1234")
      end

      it "doesn't remove them", :clear_autoload do
        expect(Types::Coercible::String[1234]).to eq("1234")
      end
    end

    context "custom types" do
      it "registers them" do
        expect(CustomTypes::ZeroBox[nil]).to eq(0)
      end

      it "doesn't remove them", :clear_autoload do
        expect(CustomTypes::ZeroBox[nil]).to eq(0)
      end
    end

    context "structs" do
      it "registers them" do
        expect{ Dry::Types[SchemaStruct] }.to_not raise_error
      end

      it "doesn't remove them", :clear_autoload do
        expect(Dry::Types[SchemaStruct]).to_not be_nil
      end
    end
  end

  describe "autoload" do
    context "types" do
      it "loads them" do
        expect(Autoload::Types::Coercible::String[1234]).to eq("1234")
      end

      it "doesn't remove them" do
        expect(Autoload::Types::Coercible::String[1234]).to eq("1234")
        clear_autoload
        expect(Autoload::Types::Coercible::String[1234]).to eq("1234")
      end
    end

    context "custom types" do
      it "loads them" do
        expect(Autoload::CustomTypes::ZeroBox[nil]).to eq(0)
      end

      it "doesn't remove them", :clear_autoload do
        expect(Autoload::CustomTypes::ZeroBox[nil]).to eq(0)
        clear_autoload
        expect(Autoload::CustomTypes::ZeroBox[nil]).to eq(0)
      end
    end

    context "structs" do
      before(:each) do
        Autoload::SchemaStruct
      end

      it "registers them" do
        expect{ Dry::Types[Autoload::SchemaStruct] }.to_not raise_error
      end

      it "deregisters after clearing autoload" do
        identifier = Dry::Types.identifier(Autoload::SchemaStruct)
        expect(ActiveSupport::Dependencies.autoloaded?(Autoload::SchemaStruct)).to be_truthy

        expect{ Dry::Types[identifier] }.to_not raise_error
        clear_autoload
        expect{ Dry::Types[identifier] }.to raise_error(Dry::Container::Error)
      end

      it "doesn't retain a refernce to the previous class" do
        class Autoload::SchemaStruct
          def self.previous_ref
            true
          end
        end

        expect(Autoload::SchemaStruct).to respond_to(:previous_ref)
        expect(Dry::Types[Autoload::SchemaStruct]).to respond_to(:previous_ref)
        clear_autoload
        expect(Autoload::SchemaStruct).to_not respond_to(:previous_ref)
        expect(Dry::Types[Autoload::SchemaStruct]).to_not respond_to(:previous_ref)
      end
    end
  end
end
