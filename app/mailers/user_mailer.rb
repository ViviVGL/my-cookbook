class UserMailer < ApplicationMailer
  def email_to_friend(recipe_id, friend_email, message_to_friend)
    @recipe = Recipe.find(recipe_id)

    mail(subject: message_to_friend, to: friend_email)
  end
end
