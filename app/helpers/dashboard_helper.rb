module DashboardHelper
  WDAY = %w(L M M J V S D)
  def wday_to_s(day)
    WDAY[day - 1]
  end
end
