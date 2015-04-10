require "spec_helper"
require "active_attr/typecasting"

module ActiveAttr
  describe Typecasting do
    subject(:model) { model_class.new }

    let :model_class do
      Class.new do
        include Typecasting
      end
    end

    describe "#typecast_attribute" do
      it "raises an ArgumentError when a nil type is given" do
        expect { model.typecast_attribute(nil, "foo") }.to raise_error(ArgumentError, "a typecaster must be given")
      end

      it "raises an ArgumentError when the given typecaster argument does not respond to #call" do
        expect { model.typecast_attribute(Object.new, "foo") }.to raise_error(ArgumentError, "a typecaster must be given")
      end

      it "returns the original value when the value is nil" do
        model_class.new.typecast_attribute(double(:call => 1), nil).should be_nil
      end
    end

    describe "#typecaster_for" do
      it "returns BigDecimalTypecaster for BigDecimal" do
        model.typecaster_for(BigDecimal).should eq Typecasting::BigDecimalTypecaster
      end

      it "returns BooleanTypecaster for Boolean" do
        model.typecaster_for(Typecasting::Boolean).should eq Typecasting::BooleanTypecaster
      end

      it "returns DateTypecaster for Date" do
        model.typecaster_for(Date).should eq Typecasting::DateTypecaster
      end

      it "returns DateTypecaster for Date" do
        model.typecaster_for(DateTime).should eq Typecasting::DateTimeTypecaster
      end

      it "returns FloatTypecaster for Float" do
        model.typecaster_for(Float).should eq Typecasting::FloatTypecaster
      end

      it "returns IntegerTypecaster for Integer" do
        model.typecaster_for(Integer).should eq Typecasting::IntegerTypecaster
      end

      it "returns StringTypecaster for String" do
        model.typecaster_for(String).should eq Typecasting::StringTypecaster
      end

      it "returns ObjectTypecaster for Object" do
        model.typecaster_for(Object).should eq Typecasting::ObjectTypecaster
      end
    end
  end
end
