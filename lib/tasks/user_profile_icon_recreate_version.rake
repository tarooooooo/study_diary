namespace :user_profile_icon_recreate_version do
  desc "user_profileのiconの画像をrecreateする"
  task :for_all_user_profile, ['id'] => :environment do |task, args|
    Rails.logger.info '--- start user_profile_icon_recreate_version for_all_user_profile  ----'

    if args[:id].present?
      unless !!(args[:id].to_s =~ /^[0-9]+$/)
        Rails.logger.info "--- #{args[:id]}が入力されました。整数を入力してください  ----"
        next
      else
        user_profiles = UserProfile.where(id: args[:id]..)
      end
    else
      user_profiles = UserProfile.all
    end

    user_profiles.find_each do |target_profile|
      target_profile.icon.recreate_versions!
      target_profile.save!(touch: false)
      Rails.logger.info "--- recreate user_profile_id: #{target_profile.id} ----"
    end

    Rails.logger.info "--- finished user_profile_icon_recreate_version for_all_user_profile ----"
  end
end
