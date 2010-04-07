# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  
  def flash_notice
    return nil if flash[:notice]. blank?
    "<div class=\"flash_notice\">#{flash[:notice]}</div>"
  end
  
end
