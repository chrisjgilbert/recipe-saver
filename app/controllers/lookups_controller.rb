class LookupsController < ApplicationController
  before_action :authenticate_user!

  def new
  end

  def create
    url = lookup_params.fetch(:url)
    response = HTTParty.get(url)
    page = Nokogiri::HTML(response.body)
    title = page.css("meta[property='og:title']").first.attributes["content"].value
    desc = page.css("meta[property='og:description']").first.attributes["content"].value
    image_url = page.css("meta[property='og:image']").first.attributes["content"].value

    redirect_to new_recipe_path(title: title, description: desc, image_url: image_url, url: url)
  end

  private

  def lookup_params
    params.require(:lookup).permit(:url)
  end
end
