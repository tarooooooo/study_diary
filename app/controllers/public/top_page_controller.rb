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

      # カテゴリ別の円チャート用データ作成（カテゴリなし））
      @learning_diaries_chart_data.push({ name: "カテゴリ未指定", data: category_blank_daily_study_time})
      blank_category_learning_diaries_count = current_user.learning_diaries.where(study_day: Date.today.beginning_of_week..Date.current, study_category: nil ).count
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
      @study_categories_count = study_categories_count.merge(current_user.study_categories.joins(:learning_diaries).where(learning_diaries: { study_day: Date.today.beginning_of_week..Date.current }).group(:name).count)
    end

    # 1日の平均学習時間を算出
    avg_daily_study_time = current_user.learning_diaries.where(study_day: Date.today.beginning_of_week..Date.current).sum(:study_time) / (Date.today.beginning_of_week..Date.current).count
    @study_time_hh, @study_time_mm = avg_daily_study_time.divmod(60)
  end
end
