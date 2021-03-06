class RecipesController < ApplicationController
  before_action :set_recipe, only: %i[show edit update email_to_friend
                                      favorite]
  before_action :authenticate_user!, only: %i[new edit]

  def show
    @favorite = Favorite.where(recipe: @recipe, user: current_user).any?
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
      flash[:notice] = 'Receita gravada com sucesso.'
      redirect_to @recipe
    else
      set_error_before_render
      render :new
    end
  end

  def edit
    redirect_to root_url if @recipe.user != current_user
    @recipe_types = RecipeType.all
    @cuisines = Cuisine.all
  end

  def update
    @recipe.update(recipe_params)
    redirect_to @recipe
  end

  def email_to_friend
    @friend_email = params[:friend_email]
    @message_to_friend = params[:message_to_friend]
    UserMailer.email_to_friend(@recipe.id, @friend_email, @message_to_friend)
  end

  def favorite
    Favorite.create(recipe: @recipe, user: current_user)
    redirect_to user_favorites_path
  end

  private

  def set_recipe
    @recipe = Recipe.find(params[:id])
  end

  def set_error_before_render
    @cuisines = Cuisine.all
    @recipe_types = RecipeType.all
    flash[:error] = 'Você deve informar todos os dados da receita'
  end

  def recipe_params
    params.require(:recipe).permit(:title, :recipe_type_id, :cuisine_id,
                                   :difficulty, :cook_time, :ingredients,
                                   :method, :featured, :photo, :user_id)
  end
end
