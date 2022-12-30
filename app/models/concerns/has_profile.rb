module HasProfile
  extend ActiveSupport::Concern

  included do
    has_many  :passcodes,
      class_name: "UserPasscode",
      dependent: :destroy

    has_one   :profile,
      class_name: "UserProfile",
      dependent: :destroy

  end

  def create_profile(parent: nil, params: {})
    profile_params = {
      fullname: params[:fullname],
      school: params[:school],
      gender: params[:gender] || 'male',
      user: self,
      parent_id: parent&.id,
      phone: params[:phone],
      birth_year: params[:birth_year],
      address: params[:address],
      birth_day: params[:birth_day]
    }

    profile = UserProfile.new(profile_params)
    profile.save if profile.valid?
  end

  def update_profile(params)
    profile = self.profile

    profile = UserProfile.new(user: self).save! unless profile.present?

    profile.update(params)
  end

  def profile_json
    return {} if self.profile.blank?

    {
      fullname: profile.fullname,
      school: profile.school,
      gender: profile.gender,
      address: profile.address,
      birth_year: profile.birth_year,
      birth_day: profile.birth_day&.strftime("%d/%m/%Y")
    }
  end
end
