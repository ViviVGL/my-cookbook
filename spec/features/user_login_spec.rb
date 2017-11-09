require 'rails_helper'

feature 'User login' do
  scenario 'successfully' do
    cuisine = Cuisine.create(name: 'Brasileira')
    recipe_type = RecipeType.create(name: 'Sobremesa')
    Recipe.create(title: 'Bolo de cenoura', recipe_type: recipe_type,
                  cuisine: cuisine, difficulty: 'Médio', cook_time: 60,
                  ingredients: 'Farinha, açucar, cenoura',
                  method: 'Misture tudo e leve ao forno', featured: true)
    user = User.create(email: 'meuemail@user.com', password: 'abcd1234')

    visit root_path
    click_on 'Entrar'
    fill_in 'Email', with: user.email
    fill_in 'Senha', with: user.password
    click_on 'Log in'

    expect(page).to have_css('h2', text: 'Minhas Receitas')
    expect(page).not_to have_content 'Logar-se'
    expect(page).to have_link 'Sair'
  end
end
