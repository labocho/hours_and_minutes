require "spec_helper"

describe HoursAndMinutes do
  describe '.parse' do
    subject { HoursAndMinutes.parse(@s) }

    it 'parses 12:34' do
      @s = "12:34"
      should == HoursAndMinutes.new(12, 34)
    end

    it 'parses 0:61 as 1:01' do
      @s = "0:61"
      should == HoursAndMinutes.new(1, 1)
    end

    it 'cannot parse empty string and raise error' do
      @s = ""
      expect {
        subject
      }.to raise_error(HoursAndMinutes::ParseError)
    end
  end

  describe '.min' do
    subject { HoursAndMinutes.min(@i) }

    it 'can receive positive value' do
      @i = 123
      should == HoursAndMinutes.new(2, 3)
    end

    it 'cannot receive negative value' do
      @i = -123
      expect {
        subject
      }.to raise_error(ArgumentError)
    end

    it 'can receive zero' do
      @i = 0
      should == HoursAndMinutes.new(0, 0)
    end
  end

  describe 'initialize' do
    subject { HoursAndMinutes.new(@h, @m) }

    it 'can receive 12, 34' do
      @h = 12
      @m = 34
      expect(subject.hour).to eq 12
      expect(subject.min).to eq 34
    end

    it 'can receive 0, 61' do
      @h = 0
      @m = 61
      expect(subject.hour).to eq 1
      expect(subject.min).to eq 1
    end

    it 'cannot receive negative value' do
      @h = -1
      @m = 0
      expect {
        subject
      }.to raise_error(ArgumentError)
    end
  end
end
