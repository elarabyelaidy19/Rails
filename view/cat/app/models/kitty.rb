class Kitty < ApplicationRecord 
  include ActionView::Helpers::DateHelper 

  COLORS = %w(red green blue yellow purple black).freeze 
  GENDER = %w(M F).freeze 
  validates :birth_date, :name,  presence: true 
  validates :color, presence: true, inclusion:  COLORS 
  validates :sex, presence: true, inclusion: GENDER 


  def age 
    num_years = Date.today.year - self.birth_date.year
    num_months = Date.today.month -self.birth_date.month
    num_days = Date.today.day - self.birth_date.day 

    from_time = Time.now - num_years.years - num_months.months - num_days.days 
    time_ago_in_words(from_time)  
  end 
end
