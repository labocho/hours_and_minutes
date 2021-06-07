require "hours_and_minutes/version"

class HoursAndMinutes
  class ParseError < StandardError; end

  include Comparable

  attr_reader :hour, :min

  # @param s [String]
  # @return [HoursAndMinutes]
  def self.parse(s)
    s = s.to_s.gsub(/[^\d:]/, "")
    raise ParseError, "Cannot parse #{s.inspect}" unless s =~ /\A(\d+):(\d{1,2})\z/

    h, m = $~.captures
    min(h.to_i * 60 + m.to_i)
  end

  # @param i [Integer]
  # @return [HoursAndMinutes]
  def self.min(i)
    new(i / 60, i % 60)
  end

  # @param value [HoursAndMinutes, Numeric, String]
  # @return [HoursAndMinutes, nil]
  def self.cast(value)
    case value
    when HoursAndMinutes
      value
    when Numeric
      HoursAndMinutes.min(value.to_i)
    when String
      HoursAndMinutes.parse(value)
    end
  end

  # @param hour [Integer]
  # @param min [Integer]
  def initialize(hour, min)
    raise ArgumentError, "Cannot support negative value" if hour.negative? || min.negative?

    i = hour.to_i * 60 + min.to_i
    @hour = i / 60
    @min = i % 60
  end

  # @return [String]
  def to_s
    format("%02d:%02d", hour, min)
  end

  alias_method :inspect, :to_s

  # @return [Integer]
  def to_i
    hour * 60 + min
  end

  # @param other [HoursAndMinutes, Numeric, String]
  # @return [HoursAndMinutes]
  def +(other)
    other = Type.new.cast(other)
    if other.nil?
      raise ArgumentError, "Cannot add to HoursAndMinutes: #{other.inspect}"
    end

    self.class.min(to_i + other.to_i)
  end

  # @param other [HoursAndMinutes]
  # @return [Boolean]
  def ==(other)
    return false if other.nil?

    (self <=> other) == 0
  end

  # @param other [HoursAndMinutes]
  # @return [Integer]
  def <=>(other)
    raise ArgumentError, "Cannot compare #{inspect} to #{other.inspect}" unless other.is_a?(self.class)

    to_i <=> other.to_i
  end
end
