require 'rails_helper'

describe UserMailer, type: :mailer do
  describe 'send email to a friend' do
    it 'and render email addresses and subject' do
      user = User.create(email: 'cat@user.com', password: 'kittycat')
      cuisine = Cuisine.create(name: 'Italiana')
      recipe_type = RecipeType.create(name: 'Prato Principal')
      recipe = Recipe.create(title: 'Nhoque', recipe_type: recipe_type,
                             cuisine: cuisine, difficulty: 'Fácil',
                             cook_time: 40,
                             ingredients: 'massa, molho, tempero',
                             method: 'Comprar pronto e colocar no microondas',
                             user: user)
      friend_email = 'friend@email.com'
      message_to_friend = 'Se liga nessa receita, você vai adorar!'
      mail = UserMailer.email_to_friend(recipe.id, friend_email,
                                        message_to_friend)

      expect(mail.subject).to eq message_to_friend
      expect(mail.from).to include 'no-reply@cookbook.com'
      expect(mail.to).to include friend_email
    end
    it 'and email body' do
      user = User.create(email: 'cat@user.com', password: 'kittycat')
      cuisine = Cuisine.create(name: 'Italiana')
      recipe_type = RecipeType.create(name: 'Prato Principal')
      recipe = Recipe.create(title: 'Nhoque', recipe_type: recipe_type,
                             cuisine: cuisine, difficulty: 'Fácil',
                             cook_time: 40,
                             ingredients: 'massa, molho, tempero',
                             method: 'Comprar pronto e colocar no microondas',
                             user: user, photo: File.new("#{Rails.root}/spec/support/fixtures/gnocchi.jpg"))
      friend_email = 'friend@email.com'
      message_to_friend = 'Se liga nessa receita, você vai adorar!'
      mail = UserMailer.email_to_friend(recipe.id, friend_email,
                                        message_to_friend)

      expect(mail.body).to include recipe.title.to_s
      expect(mail.body).to include recipe.photo.url(:medium).to_s
      expect(mail.body).to include recipe.cuisine.name.to_s
      expect(mail.body).to include recipe.recipe_type.name.to_s
      expect(mail.body).to include recipe.difficulty.to_s
      expect(mail.body).to include recipe.cook_time.to_s
      expect(mail.body).to include recipe.ingredients.to_s
      expect(mail.body).to include recipe.method.to_s
    end
  end
end
