class PositivistDate
  MONTHS = ["Moses", "Homer", "Aristotle", "Archimedes", "Caesar", "Saint Paul", "Charlemagne", "Dante", "Gutenberg", "Shakespeare", "Descartes", "Frederick", "Bichat"]
  WEEK_DAYS = %w(Monday Tuesday Wednesday Thursday Friday Saturday Sunday)
  START_YEAR = 1789
  DAY_OF_THE_DEAD = "Day of the Dead"
  WOMENS_DAY = "Women's Day"

  property year : Int32, month : (Nil | Int32), day : (Nil | Int32), hour : Int32, minute : Int32, second : Int32, millisecond : Int32, special : (Nil | String)

  def initialize(@year, @month = nil, @day = nil, @hour = 0, @minute = 0, @second = 0, @millisecond = 0, @special = nil)
    if special
      unless month.nil? && day.nil?
        raise ArgumentError.new "Invalid time"
      end
      return
    end

    _month = month; _day = day

    if _month && _day
      unless 1 <= year <= 9999 &&
          1 <= _month <= 13 &&
          1 <= _day <= 28 &&
          0 <= hour <= 23 &&
          0 <= minute <= 59 &&
          0 <= second <= 59 &&
          0 <= millisecond <= 999
        raise ArgumentError.new "Invalid time"
      end
    else
      raise ArgumentError.new "Invalid time"
    end
  end

  def self.from_time(t = Time)
    year = year_to_positivist_year(t.year)

    if t.day_of_year == 365
      return self.new(year: year, special: DAY_OF_THE_DEAD)
    end

    if t.day_of_year == 366
      return self.new(year: year, special: WOMENS_DAY)
    end

    month = t.day_of_year / 28 + 1
    day = t.day_of_year - (month - 1)  * 28

    self.new(year: year, month: month, day: day, hour: t.hour, minute: t.minute, second: t.second)
  end

  def self.now
    PositivistDate.from_time(Time.now)
  end

  def to_time
    _year = PositivistDate.positivist_year_to_year(year)

    if day_of_dead? || womens_day?
      return Time.new(_year, 12, 31, hour, minute, second, millisecond)
    end

    if PositivistDate.leap_year?(_year)
      days_in_month = Time::DAYS_MONTH_LEAP
    else
      days_in_month = Time::DAYS_MONTH
    end

    _days = day_of_year
    _month = 0

    if _days
      while _days > days_in_month[_month]
        _days -= days_in_month[_month]
        _month += 1
      end
      return Time.new(_year, _month, _days, hour, minute, second, millisecond)
    end
    return Time.new(0, 0, 0) # this shall never happen
  end

  def self.leap_year?(year)
    Time.leap_year?(PositivistDate.positivist_year_to_year(year))
  end

  def day_of_year
    if special == DAY_OF_THE_DEAD
      return 365
    end

    if special == WOMENS_DAY
      return 366
    end

    _month = month; _day = day
    return nil if _month.nil? || _day.nil?

    (_month-1) * 28 + _day
  end

  def month_name
    _month = month
    return nil if _month.nil?
    MONTHS[_month - 1]
  end

  def weekday
    return nil unless @special.nil?
    if _day = day
      WEEK_DAYS[(_day - ((_day / 7) * 7)) - 1]
    end
  end

  def day_of_dead?
    special == DAY_OF_THE_DEAD
  end

  def womens_day?
    special == WOMENS_DAY
  end

  def monday?
    weekday == "Monday"
  end

  def tuesday?
    weekday == "Tuesday"
  end

  def wednesday?
    weekday == "Wednesday"
  end

  def thursday?
    weekday == "Thursday"
  end

  def friday?
    weekday == "Friday"
  end

  def saturday?
    weekday == "Saturday"
  end

  def sunday?
    weekday == "Sunday"
  end

  def self.year_to_positivist_year(year)
    year - (START_YEAR - 1)
  end

  def self.positivist_year_to_year(positivist_year)
    positivist_year + (START_YEAR - 1)
  end
end
