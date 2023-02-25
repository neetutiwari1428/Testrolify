class PostPolicy < ApplicationPolicy
  class Scope < Scope
    # NOTE: Be explicit about which records you allow access to!
    # def resolve
    #   scope.all
    # end
    def index
        @publications = PublicationPolicy::Scope.new(current_user, Post).resolve
    end
    def resolve
        if user.admin?
          scope.all
        else
          scope.where(published: true)
        end
      end
    end
   
    def initialize(user, scope)
        @user  = user
        @scope = scope
    end

    def resolve
        if user.admin?
        scope.all
        else
        scope.where(published: true)
        end
    end

    private

    attr_reader :user, :scope
    end

    def update?
        user.admin? or not record.published?
    end
    # def show
    #     # @post = policy_scope(Post).find(params[:id])
    # end
    def show
        record = Record.find_by(attribute: "value")
        if record.present?
          authorize record
        else
          skip_authorization
        end
    end
    def permitted_attributes
        if user.admin? || user.owner_of?(post)
          [:title, :body, :tag_list]
        else
          [:tag_list]
        end
    end
    def permitted_attributes_for_create
        [:title, :body]
    end
    
    def permitted_attributes_for_edit
        [:body]
    end
    
    def pundit_params_for(record)
        params.require(PolicyFinder.new(record).param_key)
    end
end
