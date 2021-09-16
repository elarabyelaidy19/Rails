require 'rails_helper'

RSpec.describe Cat, type: :model do
  
  subject(:cat) { FactoryBot.build(:cat) }
  describe "Validations" do 
    it { should validate_presence_of(:name) } 

    it "should validate presence of sex" do 
      cat = Cat.new(sex: nil) 
      expect(cat.valid?).to be false 
    end  

    it "should validate color" do 
      cat = Cat.new(color: 'yellow') 
      expect(cat.valid?).to be false 
    end

    it "should validate color is white" do 
      white_cat = FactoryBot.build(:cat, color: "white") 
      white_cat.valid? 
      expect(white_cat).to be true 
    end  


  end  

  describe "associations" do 
    it { should have_many(:rental_requests) } 
  end 
end
