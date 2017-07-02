require "./spec_helper"

describe PositivistDate do
  describe ".from_time" do
    context "with special date" do
      it "converts to special date correctly" do
        t = Time.new(2017, 12, 31)
        pd = PositivistDate.from_time(t)
        pd.day_of_dead?.should eq true
        pd.special.should eq PositivistDate::DAY_OF_THE_DEAD
        pd.year.should eq (t.year - 1788)
        pd.month.should eq nil
        pd.day.should eq nil
      end
    end

    context "with regular date" do
      it "converts a time to PostivistDate correctly" do
        t = Time.new(2017, 6, 24, 10, 10, 10)
        pd = PositivistDate.from_time(t)
        pd.year.should eq t.year - 1788
        pd.month.should eq 7
        pd.month_name.should eq "Charlemagne"
        pd.day.should eq 7
        pd.hour.should eq t.hour
        pd.minute.should eq t.minute
        pd.second.should eq t.second
        pd.weekday.should eq "Sunday"
        pd.sunday?.should eq true
      end
    end
  end

  describe "#to_time" do
    it "converts into a correct time object" do
      t = Time.new(2017, 6, 24, 10, 10, 10)
      pd = PositivistDate.from_time(t)
      pd.to_time.should eq t
    end
  end

  describe "#leap_year" do
    it "takes leap years from 'regular' time" do
      (1990..2020).each do |year|
        PositivistDate.leap_year?(year-1788).should eq Time.leap_year?(year)
      end
    end
  end

  describe "#month_name" do
    it "returns the correct name" do
      PositivistDate.new(2017, 3, 13).month_name.should eq "Aristotle"
    end
  end

  describe "#weekday" do
    it "returns the correct name" do
      PositivistDate.new(2017, 3, 13).weekday.should eq "Saturday"
    end
  end

  describe "#day_of_year" do
    context "with special day" do
      it "returns correct day" do
        PositivistDate.new(year: 2017, special: "Day of the Dead").day_of_year.should eq 365
      end
    end

    context "with regular day" do
      it "behaves like time counterpart" do
        t = Time.now
        pd = PositivistDate.from_time(t)
        pd.day_of_year.should eq t.day_of_year
      end
    end
  end
end
