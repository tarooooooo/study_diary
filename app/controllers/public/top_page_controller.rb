class Public::TopPageController < ::Public::BaseController
  def show
    @learning_diaries_chart_data = []
    @day = (Date.current - 1)
    @day_2 = (Date.current - 2)
    @day_3 = (Date.current - 3)
    @day_4 = (Date.current - 4)
    @day_5 = (Date.current - 5)
    current_user.study_categories.each do | study_category |
      @learning_diaries_chart_data.push({ name: study_category.name, data: [
        ["#{@day_4}", study_category.learning_diaries.where(study_day: @day_4).sum(:study_time) ],
        ["#{@day_3}", study_category.learning_diaries.where(study_day: @day_3).sum(:study_time) ],
        ["#{@day_2}", study_category.learning_diaries.where(study_day: @day_2).sum(:study_time) ],
        ["#{@day}", study_category.learning_diaries.where(study_day: @day).sum(:study_time) ],
        ["#{Date.current}", study_category.learning_diaries.where(study_day: Date.current).sum(:study_time) ],
      ]})
    end
  end
end
