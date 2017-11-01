require 'rails_helper'

feature 'Visitor dont register recipe' do
  scenario 'successfully' do
    #cria os dados necessários, nesse caso não vamos criar dados no banco
    Cuisine.create(name: 'Arabe')
    RecipeType.create(name: 'Entrada')
    # simula a ação do usuário
    visit root_path

    expect(page).not_to have_content 'Enviar uma receita'
  end

  scenario 'forcing the new recipe url' do
    visit new_recipe_path

    expect(current_path).to eq new_user_session_path
  end
end
