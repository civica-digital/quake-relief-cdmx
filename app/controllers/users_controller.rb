class UsersController < ApplicationController
  def create
    user = User.find_or_create_by(email: params[:email])
    user.phone_number = params[:phone_number]
    user.twitter = params[:twitter]
    user.save

    TweetsAndSupportersCounter.find_by(need: params[:need],
                                       neighborhood: params[:neighborhood])
                              &.increment_counter(:supporters_counter)
                              &.save
  end
end
