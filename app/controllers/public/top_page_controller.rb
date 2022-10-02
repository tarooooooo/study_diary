class Public::TopPageController < ::Public::BaseController
  PERCENT_CONVERTION_NUMBER = 100
  def show
    if user_signed_in?
      @learning_diaries_chart_data = []
      days = ["月", "火", "水", "木", "金", "土", "日"]

      # 未指定カテゴリのチャート用データ作成
      category_blank_daily_study_time = []
      if current_user.learning_diaries
        # カラムチャート用データ追加（カテゴリなし）
        days.each_with_index do | day, number |
          category_blank_daily_study_time.push(["#{day}", current_user.learning_diaries.where(study_category: nil, study_day: (Date.today.beginning_of_week + number)).sum(:study_time) ])
        end
        @learning_diaries_chart_data.push({ name: "カテゴリ未指定", data: category_blank_daily_study_time})

        # カテゴリ別の円チャート用データ作成（カテゴリなし））
        blank_category_learning_diaries_count = current_user.learning_diaries.where(study_day: Date.today.beginning_of_week..Date.current, study_category: nil ).sum(:study_time)
        study_categories_count = {"カテゴリ未指定" => blank_category_learning_diaries_count}
      end

      # カテゴリ別チャート用データ作成
      if current_user&.study_categories
        # カテゴリ別のカラムチャート用データの追加
        current_user.study_categories.each  do | study_category |
          daily_study_time = []
          days.each_with_index do | day, number |
            daily_study_time.push(["#{day}", study_category.learning_diaries.where(study_day: (Date.today.beginning_of_week + number)).sum(:study_time) ])
          end
          @learning_diaries_chart_data.push({ name: study_category.name, data: daily_study_time })
        end
        # カテゴリ別の円チャート用データ追加（カテゴリあり）
        @study_categories_count = study_categories_count.merge(current_user.study_categories.joins(:learning_diaries).where(learning_diaries: { study_day: Date.today.beginning_of_week..Date.current }).group(:name).sum("learning_diaries.study_time")).sort_by { |_, v| -v }.to_h
      end

      # 1日の平均学習時間を算出
      avg_daily_study_time = current_user.learning_diaries.where(study_day: Date.today.beginning_of_week..Date.current).sum(:study_time) / (Date.today.beginning_of_week..Date.current).count
      @study_time_hh, @study_time_mm = avg_daily_study_time.divmod(60)

      # 1日の平均学習時間を算出
      avg_daily_study_time = current_user.learning_diaries.where(study_day: Date.today.beginning_of_week..Date.current).sum(:study_time) / (Date.today.beginning_of_week..Date.current).count
      @study_time_hh, @study_time_mm = avg_daily_study_time.divmod(60)

      # 学習目標設定
      @study_plan = StudyPlan.new
      @study_time_array = {"15分": 105, "30分": 210, "1時間": 420, "1時間30分": 630, "2時間": 840, "2時間30分": 1050, "3時間": 1120, "3時間30分": 1470, "4時間": 1680, "4時間30分": 1890, "5時間": 2100, "5時間30分": 2310, "6時間": 2520, "6時間30分": 2730, "7時間": 2940, "7時間30分": 3150, "8時間": 3360, "8時間30分": 3570, "9時間": 3780, "9時間30分": 3990, "10時間": 4200, "10時間30分": 4410, "11時間": 4620, "11時間30分": 4830, "12時間": 5040 }
      @current_study_plan = current_user&.study_plans&.last
      @study_plan_time_hh, @study_plan_time_mm = @current_study_plan.weekly_target_time.divmod(60)
      study_plan_weekly_progress = (current_user.learning_diaries.where(study_day: Date.today.beginning_of_week..Date.current).sum(:study_time) / @current_study_plan.weekly_target_time.to_f * PERCENT_CONVERTION_NUMBER).floor
      @extra_time = [(study_plan_weekly_progress - PERCENT_CONVERTION_NUMBER), 0].max
      @study_plan_weekly_progress = [study_plan_weekly_progress, 100].min

      # 学習目標タイトル
      @study_plan_title = @current_study_plan.title.present? ? @current_study_plan.title : "タイトル未設定"
    end
  end
end
