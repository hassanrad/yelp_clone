class RestaurantsController < ApplicationController

  before_action :authenticate_user!, :except => [:index, :show]

  def index
    @restaurants = Restaurant.all
  end

  def new
    @restaurant = Restaurant.new
  end

  def create
    @restaurant = Restaurant.create(restaurant_params)
    @restaurant.user_id = current_user.id
    if @restaurant.save
      redirect_to restaurants_path
    else
      render 'new'
    end
  end

  def show
    @restaurant = Restaurant.find(params[:id])
  end

  def edit
    @restaurant = Restaurant.find(params[:id])
    if current_user.id != @restaurant.user_id
      flash[:notice] = 'Only owner of restaurant can edit'
      redirect_to '/'
    else
      render 'new'
    end
  end

  def update
    @restaurant = Restaurant.find(params[:id])
    if current_user.id == @restaurant.user_id
      @restaurant.update(restaurant_params)
      redirect_to '/'
    else
      flash[:notice] = 'You cannot edit a restaurant not owned by you'
      redirect_to '/'
    end
  end

  def destroy
    @restaurant = Restaurant.find(params[:id])
    if current_user.id == @restaurant.user_id
      @restaurant.destroy
      flash[:notice] = 'Restaurant deleted successfully'
      redirect_to '/restaurants'
    else
      flash[:notice] = 'You cannot delete a restaurant not owned by you'
      redirect_to '/restaurants'
    end
  end

  private

  def restaurant_params
    params.require(:restaurant).permit(:name, :description, :current_user)
  end

end
