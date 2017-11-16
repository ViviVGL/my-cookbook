require 'rails_helper'

feature 'User see last recipes' do
  scenario 'successfully' do
    user = User.create(email: 'cat@user.com', password: 'kittycat')
    cuisine = Cuisine.create(name: 'Brasileira')
    recipe_type = RecipeType.create(name: 'Salgado')
    Recipe.create(title: 'Coxinha de Alcachofra 1', cuisine: cuisine,
                  recipe_type: recipe_type, difficulty: 'Médio',
                  cook_time: 60, ingredients: 'Farinha, alcachofra, óleo',
                  method: 'Misture e frite no óleo', featured: true, user: user)
    Recipe.create(title: 'Coxinha de Alcachofra 2', cuisine: cuisine,
                  recipe_type: recipe_type, difficulty: 'Médio',
                  cook_time: 60, ingredients: 'Farinha, alcachofra, óleo',
                  method: 'Misture e frite no óleo', featured: true, user: user)
    Recipe.create(title: 'Coxinha de Alcachofra 3', cuisine: cuisine,
                  recipe_type: recipe_type, difficulty: 'Médio',
                  cook_time: 60, ingredients: 'Farinha, alcachofra, óleo',
                  method: 'Misture e frite no óleo', featured: true, user: user)
    Recipe.create(title: 'Coxinha de Alcachofra 4', cuisine: cuisine,
                  recipe_type: recipe_type, difficulty: 'Médio',
                  cook_time: 60, ingredients: 'Farinha, alcachofra, óleo',
                  method: 'Misture e frite no óleo', featured: true, user: user)
    Recipe.create(title: 'Coxinha de Alcachofra 5', cuisine: cuisine,
                  recipe_type: recipe_type, difficulty: 'Médio',
                  cook_time: 60, ingredients: 'Farinha, alcachofra, óleo',
                  method: 'Misture e frite no óleo', featured: true, user: user)
    Recipe.create(title: 'Coxinha de Alcachofra 6', cuisine: cuisine,
                  recipe_type: recipe_type, difficulty: 'Médio',
                  cook_time: 60, ingredients: 'Farinha, alcachofra, óleo',
                  method: 'Misture e frite no óleo', featured: true, user: user)
    Recipe.create(title: 'Coxinha de Alcachofra 7', cuisine: cuisine,
                  recipe_type: recipe_type, difficulty: 'Médio',
                  cook_time: 60, ingredients: 'Farinha, alcachofra, óleo',
                  method: 'Misture e frite no óleo', featured: true, user: user)

    visit root_path

    expect(page).to have_content 'Coxinha de Alcachofra 7'
    expect(page).to have_content 'Coxinha de Alcachofra 6'
    expect(page).to have_content 'Coxinha de Alcachofra 5'
    expect(page).to have_content 'Coxinha de Alcachofra 4'
    expect(page).to have_content 'Coxinha de Alcachofra 3'
    expect(page).to have_content 'Coxinha de Alcachofra 2'
    expect(page).not_to have_content 'Coxinha de Alcachofra 1'
  end
end
