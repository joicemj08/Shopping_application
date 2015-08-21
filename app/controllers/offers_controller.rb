class OffersController < ApplicationController
   before_action :authenticate_user!
  def show
    @offer = Offer.find(params[:id])
    @product = @offer.product
  end

  def new
    @offer = Offer.new
  end

  def index
    @offers = Offer.all
    @product = @offers.product
  end

  def edit
    @offer = Offer.find(params[:id])
  end

  def update
    @offer = Offer.find(params[:id])
    if @offer.update(offer_params)
      redirect_to @offer
    else
      render 'edit'
    end
  end

  def create
    @offer = Offer.new(offer_params)
    @offer.save
    redirect_to @offer
  end

  def destroy
    @offer = Offer.find(params[:id])
    @offer.destroy
    redirect_to offers_path
  end

  private

  def offer_params
    params.require(:offer).permit(:product_id, :description, :avatar)
  end
end
