class Public::StudyCategoriesController < ::Public::BaseController
  before_action :authenticate_user!
  before_action :set_study_category, only: [:destroy]

  def new
    @study_category = StudyCategory.new
  end

  def create
    @study_category = StudyCategory.new(study_category_params)
    @study_category.user = current_user
    if @study_category.save!
      redirect_to public_study_categories_path
    else
      render :new
    end
  end

  def index
    @study_categories = current_user.study_categories
  end

  def destroy
    @study_category.destroy!
    redirect_back fallback_location: public_root_path
  rescue
    redirect_back fallback_location: public_root_path, alert: "#{@study_category.name}をカテゴリに設定した学習日記があるため削除できません"
  end

  private
    def study_category_params
      params.require(:study_category).permit(
        :name
      )
    end

    def set_study_category
      @study_category = StudyCategory.find(params[:id])
    end
end
