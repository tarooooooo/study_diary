class Public::TopPageController < ::Public::BaseController
  def show
    if user_signed_in?
      @learning_diaries_chart_data = []
      days = ["月", "火", "水", "木", "金", "土", "日"]

      # 未指定カテゴリのチャート用データ作成
      uncategorized_diary_day_and_study_times = []
      if current_user.learning_diaries
        # カラムチャート用データ追加（カテゴリなし）
        days.each_with_index do | day, number_of_day |
          uncategorized_diary_day_and_study_times.push(["#{day}", current_user.learning_diaries.uncategorized_diary_until(number_of_day).sum(:study_time) ])
        end
        @learning_diaries_chart_data.push({ name: "カテゴリ未指定", data: uncategorized_diary_day_and_study_times})

        # カテゴリ別の円チャート用データ作成（カテゴリなし））
        uncategorized_diaries_study_time = current_user.learning_diaries.uncategorized_diary_until_today.sum(:study_time)
        category_and_study_time_hash = {"カテゴリ未指定" => uncategorized_diaries_study_time}
      end

      # カテゴリ別チャート用データ作成
      if current_user&.study_categories
        # カテゴリ別のカラムチャート用データの追加
        current_user.study_categories.each  do | study_category |
          categorize_diary_day_and_study_time = []
          days.each_with_index do | day, number_of_day |
            categorize_diary_day_and_study_time.push(["#{day}", study_category.learning_diaries.weekly_diaries(number_of_day).sum(:study_time) ])
          end
          @learning_diaries_chart_data.push({ name: study_category.name, data: categorize_diary_day_and_study_time })
        end
        # カテゴリ別の円チャート用データ追加（カテゴリあり）
        @category_and_study_time_hash = category_and_study_time_hash.merge(current_user.study_categories.joins_diary_until_today.group(:name).sum("learning_diaries.study_time")).sort_by { |_, v| -v }.to_h
      end

      # 1日の平均学習時間を算出
      @weekly_study_time_hh, @weekly_study_time_mm = current_user.weekly_study_time.divmod(60)
      @avg_study_time_hh, @avg_study_time_mm = current_user.avg_daily_study_time.divmod(60)

      # 学習目標設定
      @study_plan = StudyPlan.new
      @study_time_array = {"15分": 105, "30分": 210, "1時間": 420, "1時間30分": 630, "2時間": 840, "2時間30分": 1050, "3時間": 1120, "3時間30分": 1470, "4時間": 1680, "4時間30分": 1890, "5時間": 2100, "5時間30分": 2310, "6時間": 2520, "6時間30分": 2730, "7時間": 2940, "7時間30分": 3150, "8時間": 3360, "8時間30分": 3570, "9時間": 3780, "9時間30分": 3990, "10時間": 4200, "10時間30分": 4410, "11時間": 4620, "11時間30分": 4830, "12時間": 5040 }
      @current_study_plan = current_user.current_study_plan
      @study_plan_time_hh, @study_plan_time_mm = @current_study_plan.weekly_target_time.divmod(60)
      @extra_time = @current_study_plan.extra_time
      @study_plan_weekly_progress = @current_study_plan.total_progress

      # 学習目標タイトル
      @study_plan_title = @current_study_plan.title.present? ? @current_study_plan.title : "学習目標を立てましょう"
    end
  end
end
