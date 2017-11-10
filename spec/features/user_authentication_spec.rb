require 'rails_helper'

feature 'User authentication' do
  scenario 'to edit recipe' do
    user = User.create(email: 'cat@user.com', password: 'kittycat')
    cuisine = Cuisine.create(name: 'Italiana')
    recipe_type = RecipeType.create(name: 'Prato Principal')
    recipe = Recipe.create(title: 'Nhoque', recipe_type: recipe_type,
                           cuisine: cuisine, difficulty: 'Fácil',
                           cook_time: 40, ingredients: 'massa, molho, tempero',
                           method: 'Comprar pronto e colocar no microondas',
                           user: user)

    visit root_path
    login_as(user)
    click_on recipe.title

    expect(page).to have_link 'Editar'
  end
  scenario 'to edit only their recipe' do
    first_user = User.create(email: 'cat@user.com', password: 'kittycat')
    second_user = User.create(email: 'bird@user.com', password: 'tinybird')
    cuisine = Cuisine.create(name: 'Italiana')
    recipe_type = RecipeType.create(name: 'Prato Principal')
    first_recipe = Recipe.create(title: 'Nhoque', recipe_type: recipe_type,
                                 cuisine: cuisine, difficulty: 'Fácil',
                                 cook_time: 40,
                                 ingredients: 'massa, molho, tempero',
                                 method: 'Comprar pronto e por no microondas',
                                 user: first_user)
    second_recipe = Recipe.create(title: 'Macarronada',
                                  recipe_type: recipe_type,
                                  cuisine: cuisine, difficulty: 'Muito fácil',
                                  cook_time: 20,
                                  ingredients: 'macarrão, molho',
                                  method: 'cozinhar o macarrão e colocar molho',
                                  user: second_user)

    visit root_path
    login_as(first_user)
    click_on second_recipe.title

    expect(page).not_to have_link 'Editar'

    click_on 'Voltar'
    click_on first_recipe.title

    expect(page).to have_link 'Editar'
  end
  scenario 'cant edit other user recipe' do
    User.create(email: 'cat@user.com', password: 'kittycat')
    second_user = User.create(email: 'bird@user.com', password: 'tinybird')
    cuisine = Cuisine.create(name: 'Italiana')
    recipe_type = RecipeType.create(name: 'Prato Principal')
    recipe = Recipe.create(title: 'Macarronada',
                           recipe_type: recipe_type,
                           cuisine: cuisine, difficulty: 'Muito fácil',
                           cook_time: 20, ingredients: 'macarrão, molho',
                           method: 'cozinhar o macarrão e colocar molho',
                           user: second_user)

    visit root_path
    click_on 'Entrar'
    fill_in 'Email', with: 'cat@user.com'
    fill_in 'Senha', with: 'kittycat'
    click_on 'Log in'
    visit edit_recipe_path(recipe.id)

    expect(page).to have_css('h1', text: 'CookBook')
  end
end
