module Public
  module Mypage
    class TopPageController < ::Public::Mypage::BaseController
      before_action :set_current_user, only: [:show]

      def show; end

      private

      def set_current_user
        @user = current_user
      end
    end
  end
end
