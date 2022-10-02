# frozen_string_literal: true

class Public::Users::RegistrationsController < Devise::RegistrationsController
  layout 'public'
  def new
    super
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      flash[:notice] = "ユーザー認証メールを送信いたしました。認証が完了しましたらログインをお願いいたします。"
      StudyPlan.create!(user: current_user, weekly_study_time: 120)
      redirect_to new_user_session_path
    else
      flash[:alert] = "ユーザー登録に失敗しました。"
      render action: :new and return
    end
  end

  private
  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end
