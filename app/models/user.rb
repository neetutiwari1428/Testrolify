class User < ApplicationRecord
  rolify
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable


  after_create :assign_default_role
  validate :must_have_a_role , on: :update
  has_many :posts,through: :roles,source: :resource,source_type: :Post
  # has_many :creator_post, -> { where(roles: {name: :creator}) }, through: :roles, class_name: 'User', source: :Post
  # has_many :editor_post, -> { where(roles: {name: :editor}) }, through: :roles, class_name: 'User', source: :Post
  private
  def assign_default_role
    self.add_role(:newuser) if self.roles.blank?
  end
  def must_have_a_role
    unless roles.any?
      errors.add(:roles,"must have atleast one role")
    end

  end
end
