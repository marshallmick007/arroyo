require "spec_helper"

describe Arroyo::HumanTime do
  describe 'humanize' do
    it "handles dates a long time ago" do
      time = Time.new('2001-01-01')
      ret = Arroyo::HumanTime.humanize(time)
      puts ret
      expect(ret).not_to be nil
    end
  end
end