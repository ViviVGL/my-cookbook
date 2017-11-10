require 'rails_helper'

feature 'User set favorite recipe' do
  scenario 'successfully' do
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
    click_on 'Marcar como Favorita'

    expect(page).to have_css('h3', text: 'Minhas Receitas Favoritas')
    expect(page).to have_link 'Nhoque'
    expect(page).to have_xpath("//img[contains(@src,'#{recipe.photo_file_name}')]")
    expect(page).to have_css('li', text: recipe.recipe_type.name)
    expect(page).to have_css('li', text: recipe.cuisine.name)
    expect(page).to have_css('li', text: recipe.difficulty)
    expect(page).to have_css('li', text: recipe.cook_time)
  end
  scenario 'but forgets to login' do
    user = User.create(email: 'cat@user.com', password: 'kittycat')
    cuisine = Cuisine.create(name: 'Italiana')
    recipe_type = RecipeType.create(name: 'Prato Principal')
    recipe = Recipe.create(title: 'Nhoque', recipe_type: recipe_type,
                           cuisine: cuisine, difficulty: 'Fácil',
                           cook_time: 40, ingredients: 'massa, molho, tempero',
                           method: 'Comprar pronto e colocar no microondas',
                           user: user)

    visit root_path
    click_on recipe.title

    expect(page).not_to have_link 'Marcar como Favorita'
  end
  scenario 'and mark more than one' do
    user = User.create(email: 'cat@user.com', password: 'kittycat')
    first_cuisine = Cuisine.create(name: 'Italiana')
    first_recipe_type = RecipeType.create(name: 'Prato Principal')
    first_recipe = Recipe.create(title: 'Nhoque',
                                 recipe_type: first_recipe_type,
                                 cuisine: first_cuisine, difficulty: 'Fácil',
                                 cook_time: 40,
                                 ingredients: 'massa, molho, tempero',
                                 method: 'Colocar no microondas', user: user)
    second_cuisine = Cuisine.create(name: 'Brasileira')
    second_recipe_type = RecipeType.create(name: 'Sobremesa')
    second_recipe = Recipe.create(title: 'Bolo de cenoura',
                                  recipe_type: second_recipe_type,
                                  cuisine: second_cuisine, difficulty: 'Médio',
                                  cook_time: 60,
                                  ingredients: 'Farinha, açucar, cenoura',
                                  method: 'Cozinhe a cenoura, misture tudo',
                                  user: user)

    visit root_path
    login_as(user)
    click_on first_recipe.title
    click_on 'Marcar como Favorita'
    click_on 'Voltar para a Tela Inicial'

    expect(current_path).to eq(root_path)

    click_on second_recipe.title
    click_on 'Marcar como Favorita'

    expect(page).to have_content first_recipe.title
    expect(page).to have_content second_recipe.title
  end
  scenario 'but cant mark the same again' do
    user = User.create(email: 'cat@user.com', password: 'kittycat')
    cuisine = Cuisine.create(name: 'Italiana')
    recipe_type = RecipeType.create(name: 'Prato Principal')
    recipe = Recipe.create(title: 'Nhoque', recipe_type: recipe_type,
                           cuisine: cuisine, difficulty: 'Fácil',
                           cook_time: 40, ingredients: 'massa, molho, tempero',
                           method: 'Comprar pronto e colocar no microondas',
                           user: user)
    favorite = Favorite.create(user: user, recipe: recipe)

    visit root_path
    login_as(user)

    click_on recipe.title

    expect(page).not_to have_link 'Marcar como Favorita'
  end
end
