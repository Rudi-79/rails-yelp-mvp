class ReviewsController < ApplicationController

before_action :set_restaurant, only: [:index, :new, :create]

  def index
    @reviews = @restaurant.reviews
  end

  def show
    @review = Review.find(params[:id])
  end

  def new
    # we need @restaurant in our `simple_form_for`
    @review = Review.new
  end

  def create
    @review = Review.new(review_params)
    @review.restaurant = @restaurant
    if @review.save
      redirect_to restaurant_path(@restaurant)
    else
      render :new
    end
    # we need `restaurant_id` to associate review with corresponding restaurant
  end

  private

  def review_params
    params.require(:review).permit(:content, :rating)
  end

  def set_restaurant
    @restaurant = Restaurant.find(params[:restaurant_id])
  end
end
