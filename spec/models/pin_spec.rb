require 'spec_helper'

describe Pin do
  describe ".after_create" do
    it "destroy_over_limit_pins called" do
      pin = FactoryGirl.build(:pin)
      expect(pin).to receive(:destroy_over_limit_pins)
      pin.save
    end
  end

  describe "#destroy_over_limit_pins" do
    before {
      allow(Settings).to receive(:save_pin_limit).and_return(1)
      @member = FactoryGirl.create(:member, password: 'mala', password_confirmation: 'mala')
      @old_pin = FactoryGirl.create(:pin, member: @member, link: "link_1")
    }
    context "not over limit" do
      it "nop" do
        @pin = FactoryGirl.build(:pin, member: @member, link: "link_2")
        @pin.destroy_over_limit_pins
        expect { @old_pin.reload }.not_to raise_error # be_destroyed
      end
    end
    context "over limit" do
      it "older pin is destroyed" do
        @pin = FactoryGirl.create(:pin, member: @member, link: "link_2") # run after_create
        expect { @old_pin.reload }.to raise_error ActiveRecord::RecordNotFound # be_destroyed
        expect { @pin.reload }.not_to raise_error # not be_destroyed
      end
    end
  end
end
