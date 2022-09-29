class Public::TopPageController < ::Public::BaseController
  def show
    @learning_diaries_chart_data = []
    if current_user&.study_categories
      User.find(21).study_categories.each_with_index  do | study_category, number |
        @learning_diaries_chart_data.push(
          ["#{Date.current - number}", study_category.learning_diaries.where(study_day: (Date.current - number)).sum(:study_time) ]
        )
      end
      @study_categories_count = current_user.study_categories.group(:name).count
    end
  end
end
