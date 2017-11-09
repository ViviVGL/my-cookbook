class FavoritesController < ApplicationController
  def index
    @favorites = current_user.recipes
  end
end
