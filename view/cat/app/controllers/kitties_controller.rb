class KittiesController < ApplicationController
  def index
    @kitties = Kitty.all 
    render :index
  end

  def show 
    # kitty = Kitty.find(params[:id]) 
    render :show
  end
end
