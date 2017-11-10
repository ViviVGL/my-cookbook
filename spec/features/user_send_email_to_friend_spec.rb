require 'rails_helper'

feature 'User send email to a friend' do
  scenario 'successfully' do
    user = User.create(email: 'cat@user.com', password: 'kittycat')
    cuisine = Cuisine.create(name: 'Italiana')
    recipe_type = RecipeType.create(name: 'Prato Principal')
    friend_email = 'friend@email.com'
    message_to_friend = 'Se liga nessa receita, você vai adorar!'
    recipe = Recipe.create(title: 'Nhoque', recipe_type: recipe_type,
                           cuisine: cuisine, difficulty: 'Fácil',
                           cook_time: 40, ingredients: 'massa, molho, tempero',
                           method: 'Comprar pronto e colocar no microondas',
                           user: user)

    visit root_path
    login_as(user)
    click_on recipe.title

    fill_in 'Email', with: friend_email
    fill_in 'Mensagem', with: message_to_friend

    expect(UserMailer).to receive(:email_to_friend).with(1, friend_email,
                                                         message_to_friend)

    click_on 'Enviar para um amigo'
  end
end
