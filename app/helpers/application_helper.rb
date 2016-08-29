module ApplicationHelper
  def copyright_notice_year_range(start_year)
    start_year = start_year.to_i
    current_year = Time.new.year

    if current_year > start_year
      "#{start_year} - #{current_year}"
    else
      "#{current_year}"
    end
  end
end
