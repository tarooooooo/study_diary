class Public::TopPageController < ::Public::BaseController
  def show
    if user_signed_in?
      if current_user.learning_diaries
        @diary_column_chart_data = current_user.diary_column_chart_data
        @diary_pie_chart_data = current_user.diary_pie_chart_data
      end

      # 1日の平均学習時間を算出
      @weekly_study_time_hh, @weekly_study_time_mm = current_user.weekly_study_time.divmod(60)
      @avg_study_time_hh, @avg_study_time_mm = current_user.avg_daily_study_time.divmod(60)

      # 学習目標設定
      @study_plan = StudyPlan.new
      @weekly_study_time_array = {"15分": 105, "30分": 210, "1時間": 420, "1時間30分": 630, "2時間": 840, "2時間30分": 1050, "3時間": 1120, "3時間30分": 1470, "4時間": 1680, "4時間30分": 1890, "5時間": 2100, "5時間30分": 2310, "6時間": 2520, "6時間30分": 2730, "7時間": 2940, "7時間30分": 3150, "8時間": 3360, "8時間30分": 3570, "9時間": 3780, "9時間30分": 3990, "10時間": 4200, "10時間30分": 4410, "11時間": 4620, "11時間30分": 4830, "12時間": 5040 }
      @current_study_plan = current_user.current_study_plan
      @study_plan_time_hh, @study_plan_time_mm = @current_study_plan.weekly_target_time.divmod(60)

      # 学習目標タイトル
      @study_plan_title = @current_study_plan.title.present? ? @current_study_plan.title : "学習目標を立てましょう"
    end
  end
end
