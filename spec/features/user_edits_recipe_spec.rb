require 'rails_helper'

feature 'User edits recipe' do
  scenario 'successfully' do
    #dados
    wrong_cuisine = Cuisine.create(name: 'Thai')
    cuisine = Cuisine.create(name: 'Italiana')
    wrong_recipe_type = RecipeType.create(name: 'Sobremesa')
    recipe_type = RecipeType.create(name: 'Prato Principal')
    recipe = Recipe.create(title: 'Nhoque', recipe_type: recipe_type,
                          cuisine: wrong_cuisine, difficulty: 'Fácil',
                          cook_time: 40, ingredients: 'feijão',
                          method: 'Comprar pronto e colocar no microondas')
    #navegacao
    visit root_path
    click_on recipe.title
    click_on 'Editar'

    fill_in 'Título', with: 'Nhoque bolonhesa'
    select 'Prato Principal', from: 'Tipo da Receita'
    select 'Italiana', from: 'Cozinha'
    fill_in 'Dificuldade', with: 'Médio'
    fill_in 'Tempo de Preparo', with: '45'
    fill_in 'Ingredientes', with: 'batata, farinha, molho, carne moída'
    fill_in 'Como Preparar', with: 'Misturar tudo, cozinhar e temperar'
    click_on 'Enviar'
    #expectativas
    expect(page).to have_css('h1', text: 'Nhoque bolonhesa')
    expect(page).to have_css('p', text: 'Italiana')
    expect(page).to have_css('p', text: 'Prato Principal')
    expect(page).to have_css('p', text: 'Médio')
    expect(page).to have_css('p', text: '45 minutos')
    expect(page).to have_css('p', text: 'batata, farinha, molho, carne moída')
    expect(page).to have_css('p', text: 'Misturar tudo, cozinhar e temperar')
  end
end
