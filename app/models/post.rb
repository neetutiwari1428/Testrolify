class Post < ApplicationRecord
    resourcify
    has_many :users, -> { distinct }, through: :roles, class_name: 'User', source: :users
    has_many :creators, -> { where(roles:  {name: :creator}) }, through: :roles, class_name: 'User', source: :users
    has_many :editor, -> { where(roles:  {name: :editor}) }, through: :roles, class_name: 'User', source: :users
    def self.policy_class
        PostablePolicy
    end
    def policy_class
        PostablePolicy
    end
end
