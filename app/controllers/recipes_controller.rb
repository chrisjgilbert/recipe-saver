class RecipesController < ApplicationController
  def index
    @recipes = current_user.recipes
  end

  def new
    @recipe = current_user.recipes.build
  end

  def create
    @recipe = current_user.recipes.build(receipe_params)

    if @recipe.save
      redirect_to recipes_path
    else
      render :new
    end
  end

  private

  def receipe_params
    params.require(:recipe).permit(:name, :url)
  end
end
