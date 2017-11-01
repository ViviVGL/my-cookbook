require 'rails_helper'

feature 'User authentication' do
  scenario 'to edit recipe' do
    wrong_cuisine = Cuisine.create(name: 'Thai')
    cuisine = Cuisine.create(name: 'Italiana')
    recipe_type = RecipeType.create(name: 'Prato Principal')
    recipe = Recipe.create(title: 'Nhoque', recipe_type: recipe_type,
                          cuisine: wrong_cuisine, difficulty: 'Fácil',
                          cook_time: 40, ingredients: 'feijão',
                          method: 'Comprar pronto e colocar no microondas')
    user = User.create(email: 'cat@user.com', password: 'kittycat')

    visit root_path
    click_on 'Entrar'
    fill_in 'Email', with: 'cat@user.com'
    fill_in 'Senha', with: 'kittycat'
    click_on 'Log in'
    click_on recipe.title

    expect(page).to have_link 'Editar'
  end

end
