class Public::LearningDiariesController < ::Public::BaseController
  before_action :authenticate_user!
  before_action :set_learning_diary, only: [:show, :destroy]

  def index
    @learning_diaries = current_user.learning_diaries.order(created_at: "DESC")
  end

  def show; end

  def new
    @learning_diary = LearningDiary.new
    @study_time_array = {"15分": 15, "30分": 30, "1時間": 60, "1時間30分": 90, "2時間": 120, "2時間30分": 150, "3時間": 180, "3時間30分": 210, "4時間": 240, "4時間30分": 270, "5時間": 300, "5時間30分": 330, "6時間": 360, "6時間30分": 390, "7時間": 420, "7時間30分": 450, "8時間": 480, "8時間30分": 510, "9時間": 540, "10時間": 600, "10時間30分": 630, "11時間": 660, "11時間30分": 690, "12時間": 720 }
    @study_categories = current_user.study_categories
  end

  def create
    @study_time_array = {"15分": 15, "30分": 30, "1時間": 60, "1時間30分": 90, "2時間": 120, "2時間30分": 150, "3時間": 180, "3時間30分": 210, "4時間": 240, "4時間30分": 270, "5時間": 300, "5時間30分": 330, "6時間": 360, "6時間30分": 390, "7時間": 420, "7時間30分": 450, "8時間": 480, "8時間30分": 510, "9時間": 540, "10時間": 600, "10時間30分": 630, "11時間": 660, "11時間30分": 690, "12時間": 720 }
    @study_categories = current_user.study_categories
    @learning_diary = LearningDiary.new(learning_diary_params)
    @learning_diary.user = current_user
    if @learning_diary.save
      redirect_to public_learning_diaries_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    @learning_diary.destroy!
    redirect_back fallback_location: public_root_path
  end

  private
    def learning_diary_params
      params.require(:learning_diary).permit(
        :body,
        :study_day,
        :study_time,
        :study_category_id
      )
    end

    def set_learning_diary
      @learning_diary = LearningDiary.find(params[:id])
    end
end
