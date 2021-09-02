class Book < ApplicationRecord  
  validates :title, :author, presence: true
  
  def year_not_in_future
    errors[:year] << "cannot be in the future" unless year < 2016
  end
end 