require 'rails_helper'

feature 'User authentication' do
  scenario 'to edit recipe' do
    user = User.create(email: 'cat@user.com', password: 'kittycat')
    wrong_cuisine = Cuisine.create(name: 'Thai')
    cuisine = Cuisine.create(name: 'Italiana')
    recipe_type = RecipeType.create(name: 'Prato Principal')
    recipe = Recipe.create(title: 'Nhoque', recipe_type: recipe_type,
                          cuisine: wrong_cuisine, difficulty: 'Fácil',
                          cook_time: 40, ingredients: 'feijão',
                          method: 'Comprar pronto e colocar no microondas',
                          user: user)

    visit root_path
    click_on 'Entrar'
    fill_in 'Email', with: 'cat@user.com'
    fill_in 'Senha', with: 'kittycat'
    click_on 'Log in'
    click_on recipe.title

    expect(page).to have_link 'Editar'
  end
  scenario 'to edit only their recipe' do
    user_1 = User.create(email: 'cat@user.com', password: 'kittycat')
    user_2 = User.create(email: 'bird@user.com', password: 'tinybird')
    cuisine = Cuisine.create(name: 'Italiana')
    recipe_type = RecipeType.create(name: 'Prato Principal')
    recipe_1 = Recipe.create(title: 'Nhoque', recipe_type: recipe_type,
                          cuisine: cuisine, difficulty: 'Fácil',
                          cook_time: 40, ingredients: 'massa, molho, tempero',
                          method: 'Comprar pronto e colocar no microondas',
                          user: user_1)
    recipe_2 = Recipe.create(title: 'Macarronada', recipe_type: recipe_type,
                          cuisine: cuisine, difficulty: 'Muito fácil',
                          cook_time: 20, ingredients: 'macarrão, molho',
                          method: 'cozinhar o macarrão e adicionar molho',
                          user: user_2)

    visit root_path
    click_on 'Entrar'
    fill_in 'Email', with: 'cat@user.com'
    fill_in 'Senha', with: 'kittycat'
    click_on 'Log in'
    click_on recipe_2.title

    expect(page).not_to have_link 'Editar'

    click_on 'Voltar'
    click_on recipe_1.title

    expect(page).to have_link 'Editar'

  end
end
