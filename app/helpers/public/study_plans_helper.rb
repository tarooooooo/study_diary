module Public::StudyPlansHelper
  def study_plan_study_time(study_plan)
    study_plan_time_hh, study_plan_time_mm = study_plan&.weekly_target_time&.divmod(60)
    "#{study_plan_time_hh}時間#{study_plan_time_mm}分"
  end

  def study_plan_title(study_plan)
    study_plan.title.present? ? study_plan.title : "学習目標を立てましょう"
  end
end
