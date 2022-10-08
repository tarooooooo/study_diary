class Public::TopPageController < ::Public::BaseController
  def show
    if user_signed_in?
      if current_user.learning_diaries
        @diary_column_chart_data = current_user.diary_column_chart_data
        @diary_pie_chart_data = current_user.diary_pie_chart_data
      end
      @study_plan = StudyPlan.new
      @current_study_plan = current_user.current_study_plan
      @weekly_first_study_plan = current_user.study_plans.where(created_at: Date.today.beginning_of_week..(Date.current + 1))
    end
  end
end
