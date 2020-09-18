# frozen_string_literal: true

module ApplicationHelper
  def display_date(date)
    date ? date.strftime('%d-%m-%Y') : nil
  end

  def display_datetime(datetime)
    datetime ? datetime.in_time_zone('Paris').strftime('%d-%m-%Y %H:%M') : nil
  end

  def string_to_hex_color(string)
    require 'digest/md5'
    "##{Digest::MD5.hexdigest(string)[0..5]}"
  end
end
