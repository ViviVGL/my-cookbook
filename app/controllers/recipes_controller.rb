class RecipesController < ApplicationController

  def show
    @recipe = Recipe.find(params[:id])
  end

  def new
    @recipe = Recipe.new
  end

  def create
    @recipe = Recipe.new(recipe_params)
    @recipe.save

    redirect_to recipe_url(@recipe)
  end

  private

  def recipe_params
    recipe_params = params.require(:recipe).permit(:title, :recipe_type,
                                    :cuisine, :difficulty, :cook_time,
                                    :ingredients, :method)
  end

end
