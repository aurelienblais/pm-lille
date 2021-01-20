# frozen_string_literal: true

module AbsenceHelper
  WDAY = %w[L M M J V S D].freeze
  WDAY_CLASS = %w[monday tuesday wednesday thrusday friday saturday sunday].freeze
  MONTHS = %w[Janvier Février Mars Avril Mai Juin Juillet Août Septembre Octobre Novembre Decembre].freeze

  def string_to_hex_color(string)
    require 'digest/md5'
    "##{Digest::MD5.hexdigest(string)[0..5]}"
  end

  def wday_to_s(day)
    WDAY[day - 1]
  end

  def wday_to_class(day)
    WDAY_CLASS[day - 1]
  end

  def month_to_s(month)
    MONTHS[month - 1]
  end

  def day_class(agent, date)
    if (agent.arrival_date && agent.arrival_date > date) || (agent.departure_date && agent.departure_date < date)
      'disabled grayed'
    else
      wday_to_class(date.wday)
    end
  end
end
