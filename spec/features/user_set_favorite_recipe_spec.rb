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
    click_on 'Entrar'
    fill_in 'Email', with: 'cat@user.com'
    fill_in 'Senha', with: 'kittycat'
    click_on 'Log in'
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
end
