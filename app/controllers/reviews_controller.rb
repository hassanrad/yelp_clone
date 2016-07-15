class ReviewsController < ApplicationController

  before_action :authenticate_user!

  def new
    @restaurant = Restaurant.find(params[:restaurant_id])
    @review = Review.new
  end


  def create
    @restaurant = Restaurant.find(params[:restaurant_id])
    @review = Review.create(review_params)
    @review.restaurant_id = @restaurant.id
    @review.user_id = current_user.id
    @review.restaurant = Restaurant.find(params[:restaurant_id])

    if @review.save
      redirect_to restaurants_path
    else
      if @review.errors[:user]
        redirect_to restaurants_path, alert: 'You have already reviewed this restaurant'
      else
        render :new
      end
    end
  end

  private
    def review_params
      params.require(:review).permit(:thoughts, :rating, :current_user)
    end
end
