require "hours_and_minutes"
require "active_record"

class HoursAndMinutes
  class Type < ActiveRecord::Type::String
    # @param value [HoursAndMinutes, Numeric, String]
    # @return [HoursAndMinutes, nil]
    def cast(value)
      HoursAndMinutes.cast(value)
    rescue ParseError
      nil
    end

    # @param value [String, nil]
    # @return [HoursAndMinutes, nil]
    def deserialize(value)
      return if value.nil?

      HoursAndMinutes.parse(value)
    end

    # @param value [HoursAndMinutes, nil]
    # @return [String, nil]
    def serialize(value)
      return if value.nil?

      value.to_s
    end
  end

  # @param date [Date]
  # @param.zone [ActiveSupport::TimeZone]
  # @return [ActiveSupport::TimeWithZone]
  def in_date(date, zone = Time.zone)
    zone.local(date.year, date.month, date.day, hour, min)
  end
end

ActiveRecord::Type.register(:hours_and_minutes, HoursAndMinutes::Type)
