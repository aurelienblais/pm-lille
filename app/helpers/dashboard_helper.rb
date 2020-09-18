module DashboardHelper
  WDAY = %w[L M M J V S D].freeze
  MONTHS = %w[Janvier Février Mars Avril Mai Juin Juillet Août Septembre Octobre Novembre Decembre].freeze

  def wday_to_s(day)
    WDAY[day]
  end

  def month_to_s(month)
    MONTHS[month - 1]
  end
end
