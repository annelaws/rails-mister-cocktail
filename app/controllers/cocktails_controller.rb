class CocktailsController < ApplicationController
  def index
    @cocktails = Cocktail.all
  end

  def show
    @cocktail = Cocktail.find(params[:id])
    @ingredients = Dose.where(cocktail_id: @cocktail.id)
    @dose = Dose.new
  end

  def new
    @cocktail = Cocktail.new
  end

  def create
    @cocktail = Cocktail.new(cocktails_params)
    if @cocktail.save
      redirect_to cocktails_path
    else
      render "new"
    end
  end

  def cocktails_params
    params.require(:cocktail).permit(:name, :image_url)
  end
end
