class CatsController < ApplicationController
  def new  
    @cat = Cat.new 
    render :new 
  end

  def index 
    @cats = Cat.all   
    render :index 
  end

  def show 
    @cat = Cat.find(params[:id]) 
    render :show
  end

  def create 
    @cat = current_user.cats.new(cat_params) 
    if @cat.save 
      redirect_to cat_url(@cat)  
    else  
      flash.now[:error] = @cat.errors.full_message 
      render :new
    end 
  end 

  def edit 
    @cat = current_user.cats.find(params[:id]) 
    render :edit 
  end  
  
  def update 
    @cat = current_user.cats.find(params[:id]) 
    if @cat.update_attribute(cat_params)
      redirect_to cat_url(@cat) 
    else 
      flash.now[:errors] = @cat.errors.full_message 
      render :edit 
    end  
  end


  private 

  def cat_params 
    params.require(:cat).permit(:birth_date, :color, :description, :name, :sex) 
  end 
end
