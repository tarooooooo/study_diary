class Public::TopPageController < ::Public::BaseController
  def show
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
      # カテゴリ別の円チャートようデータ追加（カテゴリあり）
      @study_categories_count = study_categories_count.merge(current_user.study_categories.joins(:learning_diaries).where(learning_diaries: { study_day: Date.today.beginning_of_week..Date.current }).group(:name).sum("learning_diaries.study_time")).sort_by { |_, v| -v }.to_h
    end

    # 1日の平均学習時間を算出
    avg_daily_study_time = current_user.learning_diaries.where(study_day: Date.today.beginning_of_week..Date.current).sum(:study_time) / (Date.today.beginning_of_week..Date.current).count
    @study_time_hh, @study_time_mm = avg_daily_study_time.divmod(60)

    # 学習目標設定
    @study_plan = StudyPlan.new
    @study_time_array = {"15分": 15, "30分": 30, "1時間": 60, "1時間30分": 90, "2時間": 120, "2時間30分": 150, "3時間": 180, "3時間30分": 210, "4時間": 240, "4時間30分": 270, "5時間": 300, "5時間30分": 330, "6時間": 360, "6時間30分": 390, "7時間": 420, "7時間30分": 450, "8時間": 480, "8時間30分": 510, "9時間": 540, "10時間": 600, "10時間30分": 630, "11時間": 660, "11時間30分": 690, "12時間": 720 }

    @current_study_plan = current_user&.study_plans&.last
  end
end
