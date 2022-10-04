module Public::LearningDiariesHelper
  def weekly_study_time_array
    {"15分": 105, "30分": 210, "1時間": 420, "1時間30分": 630, "2時間": 840, "2時間30分": 1050, "3時間": 1120, "3時間30分": 1470, "4時間": 1680, "4時間30分": 1890, "5時間": 2100, "5時間30分": 2310, "6時間": 2520, "6時間30分": 2730, "7時間": 2940, "7時間30分": 3150, "8時間": 3360, "8時間30分": 3570, "9時間": 3780, "9時間30分": 3990, "10時間": 4200, "10時間30分": 4410, "11時間": 4620, "11時間30分": 4830, "12時間": 5040 }
  end

  def weekly_study_time(user)
    weekly_study_time_hh, weekly_study_time_mm = user.weekly_study_time.divmod(60)
    "#{weekly_study_time_hh}時間#{weekly_study_time_mm}分"
  end

  def avg_study_time(user)
    avg_study_time_hh, avg_study_time_mm = user.avg_daily_study_time.divmod(60)
    "#{avg_study_time_hh}時間#{avg_study_time_mm}分"
  end
end
