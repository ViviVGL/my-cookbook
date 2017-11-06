require 'rails_helper'

feature 'User send email to a friend' do
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

    expect(UserMailer).to receive(:email_friend)

    click_on 'Enviar para um amigo'
  end
end
