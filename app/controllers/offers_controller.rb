#
# offers Controller -
#
# @author [Joice]
#
class OffersController < ApplicationController
  before_action :authenticate_user!
  # GET  /offers/:id
  def show
    @offer = Offer.find(params[:id])
    @product = @offer.product
  end
  # GET /offers/new
  def new
    @offer = Offer.new
  end
  # GET /offers
  def index
    if current_user.manager? || current_user.admin?
      @offers = Offer.order('product_id').page(params[:page])
      @product = @offers.product
    else
      flash[:notice] = NOT_AUTHORIZED
      redirect_to home_index_path
    end
  end
  # GET /offers/:id/edit
  def edit
    @offer = Offer.find(params[:id])
  end
  # PATCH /offers/:id
  def update
    @offer = Offer.find(params[:id])
    if @offer.update(offer_params)
      redirect_to @offer
    else
      render 'edit'
    end
  end
  # POST /offers
  def create
    @offer = Offer.new(offer_params)
    @offer.save
    redirect_to @offer
  end
  # DELETE /offers/:id
  def destroy
    @offer = Offer.find(params[:id])
    @offer.destroy
    redirect_to offers_path
  end

  private

  # Permitted params for offers
  def offer_params
    params.require(:offer).permit(:product_id, :description, :avatar)
  end
end
