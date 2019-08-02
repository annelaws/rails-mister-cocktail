class CocktailsController < ApplicationController
  def index
    if params[:search].nil?
      @cocktails = Cocktail.all
    else
      @ingredient = Ingredient.find_by(name: params[:search][:ingredient].capitalize)
      @cocktails = []
      Cocktail.all.each do |cocktail|
        cocktail.ingredients.each do |ingredient|
          if ingredient == @ingredient
            @cocktails << cocktail
          end
        end
      end
    end
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
    if params["cocktail"]["remote_photo_url"].present?
      @cocktail.remote_photo_url = params["cocktail"]["remote_photo_url"]
    end
    if @cocktail.save
      redirect_to cocktails_path
    else
      render "new"
    end
  end

  def cocktails_params
    params.require(:cocktail).permit(:name, :photo)
  end
end
