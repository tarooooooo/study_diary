# frozen_string_literal: true

module Public
  module Mypage
    class ProfilesController < ::Public::Mypage::BaseController

      def new
        @profile = UserProfile.new
      end

      def create
        @profile = UserProfile.new(user_profile_params)
        @profile.user = current_user
        if @profile.save
          redirect_to public_mypage_root_path, notice: 'プロフィールを作成しました'
        else
          render :new
        end
      end

      def edit; end

      def update
        if current_user.profile.update(user_profile_params)
          redirect_to public_mypage_root_path, notice: 'プロフィールを更新しました。'
        else
          render :edit
        end
      end

      private

      def user_profile_params
        params
          .require(:user_profile)
          .permit(:icon, :name)
      end
    end
  end
end
