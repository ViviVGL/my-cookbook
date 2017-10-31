require 'rails_helper'

feature 'User send recipe photo' do
  scenario 'successfully' do
    Cuisine.create(name: 'Italiana')
    RecipeType.create(name: 'Prato Principal')

    visit root_path
    click_on 'Enviar uma receita'

    fill_in 'Título', with: 'Nhoque'
    select 'Italiana', from: 'Cozinha'
    select 'Prato Principal', from: 'Tipo da Receita'
    fill_in 'Dificuldade', with: 'Fácil'
    fill_in 'Tempo de Preparo', with: '30'
    fill_in 'Ingredientes', with: 'Farinha, molho de tomate, tempero'
    fill_in 'Como Preparar', with: 'Misturar tudo e servir.'
    attach_file('Foto', "#{Rails.root}/spec/support/fixtures/gnocchi.jpg")
    click_on 'Enviar'

    expect(page).to have_xpath("//img[contains(@src,'gnocchi')]")
    click_on 'Voltar'
    expect(page).to have_xpath("//img[contains(@src,'gnocchi')]")
  end
end
