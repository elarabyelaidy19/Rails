class KittyRentalRequestsController < Applica tionController
  def approve
    current_kitty_rental_request.approve!
    redirect_to kitty_url(current_kitty)
  end

  def create
    @rental_request = kittyRentalRequest.new(kitty_rental_request_params)
    if @rental_request.save
      redirect_to kitty_url(@rental_request.kitty)
    else
      flash.now[:errors] = @rental_request.errors.full_messages
      render :new
    end
  end

  def deny
    current_kitty_rental_request.deny!
    redirect_to kitty_url(current_kitty)
  end

  def new
    @rental_request = kittyRentalRequest.new
  end

  private

  def current_kitty_rental_request
    @rental_request ||=
      kittyRentalRequest.includes(:kitty).find(params[:id])
  end

  def current_kitty
    current_kitty_rental_request.kitty
  end

  def kitty_rental_request_params
    params.require(:kitty_rental_request).permit(:kitty_id, :end_date, :start_date, :status)
  end
end
