require 'rails_helper'

feature 'User marks featured recipe' do
  scenario 'successfully' do
    user = User.create(email: 'cat@user.com', password: 'kittycat')
    cuisine = Cuisine.create(name: 'Arabe')
    recipe_type = RecipeType.create(name: 'Entrada')
    recipe = Recipe.create(title: 'Tabule', cuisine: cuisine, recipe_type: recipe_type,
                  difficulty: 'Fácil', cook_time: 45,
                  ingredients: 'Trigo para quibe, cebola, tomate picado, azeite, salsinha',
                  method: 'Misturar tudo e servir. Adicione limão a gosto.',
                  featured: true, user: user)

    visit root_path

    expect(page).to have_xpath("//img[contains(@src, 'star')]")

    visit recipe_path(recipe)

    expect(page).to have_xpath("//img[contains(@src, 'star')]")
  end
end
