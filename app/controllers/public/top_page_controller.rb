class Public::TopPageController < ::Public::BaseController
  def show
    @daily_study_time = []
    @learning_diaries_chart_data = []
    if current_user&.study_categories
      current_user.study_categories.each_with_index  do | study_category, number |
        @daily_study_time.push(["#{Date.current - number}", study_category.learning_diaries.where(study_day: (Date.current - number)).sum(:study_time) ])
      end

      current_user.study_categories.each do | study_category |
        @learning_diaries_chart_data.push({ name: study_category.name, data: @daily_study_time })
      end
      @study_categories_count = current_user.study_categories.group(:name).count
    end
  end
end
