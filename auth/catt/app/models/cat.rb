require 'action_view' 
class Cat < ApplicationRecord 
  include ActionView::Helpers::DateHelper  

  CAT_COLORS = %w(Black Orange Yellwo White ).freeze 
  GENDERS = %w(M F).freeze

  validates :birth_date, :color, :name, :sex, :description, presence: true  
  validates :color, inclusion: CAT_COLORS,  unless: -> { color.blanck? } 
  validates :sex, inclusion: GENDERS, if: -> { sex } 
  validates :birth_date_in_the_past, if: -> { birth_date }

  has_many :rental_requests, 
    class_name: :CatRentalRequest, 
    dependent: :destroy 
    
  belongs_to :owner, 
    class_name: 'User', 
    foreign_key: :user_id

  def age 
    time_ago_in_words(birth_date) 
  end  

  private 

  def birth_date_in_the_past 
    if birth_date && birth_date > Time.now 
      errors[:birth_date] << ' must be in the bast'
end
