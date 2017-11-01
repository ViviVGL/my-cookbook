class RecipesController < ApplicationController
  before_action :recipe_find, only: [:show, :edit, :update]
  before_action :authenticate_user!, only: [:new, :edit]

  def show
  end

  def new
    @recipe = Recipe.new
    @cuisines = Cuisine.all
    @recipe_types = RecipeType.all
  end

  def create
    @recipe = Recipe.new(recipe_params)
    @recipe.user = current_user

    if @recipe.save
      redirect_to @recipe
    else
      @cuisines = Cuisine.all
      @recipe_types = RecipeType.all
      flash[:error] = 'Você deve informar todos os dados da receita'
      render :new
    end
  end

  def edit
    if @recipe.user != current_user
      redirect_to root_url
    end
    @recipe_types = RecipeType.all
    @cuisines = Cuisine.all
  end

  def update
    @recipe.update(recipe_params)
    redirect_to @recipe
  end


  private

  def recipe_find
    @recipe = Recipe.find(params[:id])
  end

  def recipe_params
    recipe_params = params.require(:recipe).permit(:title, :recipe_type_id,
                                    :cuisine_id, :difficulty, :cook_time,
                                    :ingredients, :method, :featured, :photo,
                                    :user_id)
  end

end
