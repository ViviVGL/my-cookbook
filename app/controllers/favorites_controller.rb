class FavoritesController < ApplicationController
  before_action :authenticate_user!, only: %i[index]

  def index
    @favorites = current_user.recipes
  end
end
