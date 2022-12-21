module StudentAction
  extend ActiveSupport::Concern

  def create_passcode
    if self.has_role? :student or self.has_role? :child
      UserPasscode.find_or_create_by!(user_id: self.id)
    end
  end

  def create_short_passcode
    return unless self.has_role? :student
    UserPasscode.create!(user_id: self.id, type: :short)
  end

  def auto_password
    SecureRandom.alphanumeric(8).upcase
  end

  def client_uid
    self.client&.uid
  end

  def parent
    return unless self.has_role? :student
    self.profile&.parent
  end

  def default_passcode
    return nil unless self.has_role? :student
    self.passcodes.where(type: UserPasscode::DEFAULT_TYPE).last&.code
  end

  def student_ids
    UserProfile.where(parent_id: self.id).pluck(:user_id).uniq.compact
  end

  class_methods do
    def add_student(parent, params)
      student = User.new()
      student.save!

      if student.persisted?
        assign_role(student)
        student.create_profile(parent: parent, params: params)
        student.create_passcode
        student.create_access_token(parent.client_uid)
      end

      student
    end

    private

    def build_student_params params
    end

    def assign_role(student)
      student.remove_role :parent
      student.add_role :child
      student.add_role :student
    end
  end
end
