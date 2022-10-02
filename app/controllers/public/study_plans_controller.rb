class Public::StudyPlansController < ApplicationController
  before_action :authenticate_user!
  def create
    @study_plan = StudyPlan.new(study_plan_params)
    @study_plan.user = current_user
    if @study_plan.save
      redirect_to public_root_path
    else
      redirect_back fallback_location: public_root_path
    end
  end

  private
    def study_plan_params
      params.require(:study_plan).permit(
        :title,
        :weekly_target_time
      )
    end
end
