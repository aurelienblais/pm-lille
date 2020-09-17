module DashboardHelper
  WDAY = %w[L M M J V S D].freeze
  def wday_to_s(day)
    WDAY[day]
  end
end
