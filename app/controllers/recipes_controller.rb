class RecipesController < ApplicationController
  before_action :authenticate_user!

  def index
    @recipes = current_user.recipes
  end

  def new
    @recipe = current_user.recipes.build
  end

  def create
    url = recipe_params.fetch(:url)
    response = HTTParty.get(url)
    html = Nokogiri::HTML(response.body)
    title = html.at_css("title").text
    desc = html.at_css("meta[name='description']")&.[]("content")
    image = html.at_css("meta[property='og:image']")&.[]("content")
    metadata = {title: title, description: desc, image: image}
    @recipe = current_user.recipes.build(metadata: metadata, url: url)

    if @recipe.save
      redirect_to recipes_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @recipe = current_user.recipes.find(params[:id])
  end

  def update
    @recipe = current_user.recipes.find(params[:id])

    if @recipe.update(receipe_params)
      redirect_to recipes_path
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @recipe = current_user.recipes.find(params[:id])
    @recipe.destroy
    redirect_to recipes_path
  end

  private

  def recipe_params
    params.require(:recipe).permit(:url)
  end
end
