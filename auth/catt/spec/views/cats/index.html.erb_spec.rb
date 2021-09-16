require 'rails_helper'

RSpec.describe "cats/index", type: :view do
  it "render cats names" do 
    assign(:cats, [
      Cat.create!(:name => "jet"),  
      Cat.create!(:name => "blo") 
    ])

    render 

    expect(rendered).to match /jet/ 
    expect(rendered).to match /blo/ 
  end 

end
