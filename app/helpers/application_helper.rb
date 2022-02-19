# frozen_string_literal: true

module ApplicationHelper
  def display_date(date)
    date ? date.strftime('%d-%m-%Y') : nil
  end

  def display_datetime(datetime)
    datetime ? datetime.in_time_zone('Paris').strftime('%d-%m-%Y %H:%M') : nil
  end

  def menu_link(url:, icon:, content:, controller: nil, model: nil, policy_method: nil)
    return if model.present? && policy_method.present? && !policy(model.constantize).public_send(policy_method)

    tag.li class: 'nav-item' do
      link_to url, class: "nav-link #{controller_name == controller ? 'active' : ''}" do
        out = capture { tag.i class: "#{icon} nav-icon" }
        out << capture { tag.p " #{content}" }
      end
    end
  end
end
