module HasProfile
  extend ActiveSupport::Concern

  included do
    has_many  :passcodes,
      class_name: "UserPasscode",
      dependent: :destroy

    has_one   :profile,
      class_name: "UserProfile",
      dependent: :destroy

    # accepts_nested_attributes_for :profile
    # accepts_nested_attributes_for :passcodes
  end

  def create_profile(parent:, params:)
    profile_params = {
      fullname: params[:fullname],
      school: params[:school],
      gender: params[:gender] || 'male',
      user: self,
      parent_id: parent.id,
      phone: params[:phone],
      birth_year: params[:birth_year]
    }

    profile = UserProfile.new(profile_params)
    profile.save if profile.valid?
  end

  def update_profile(params)
    self.profile.update(params)
  end

  def profile_json
    return {} if self.profile.blank?

    {
      fullname: profile.fullname,
      school: profile.fullname,
      gender: profile.gender,
      address: profile.address,
      phone: profile.phone
    }
  end
end
