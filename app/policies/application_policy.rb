# frozen_string_literal: true

class ApplicationPolicy
  attr_reader :user, :record

  def initialize(user, record)
    raise Pundit::NotAuthorizedError, "must be logged in" unless user
    @user   = user
    @record = record
  end

  def index?
    false
  end

  def show?
    @user = authorize [:admin, User.find(params[:id])]
  end

  def create?
    @publication = find_publication # assume this method returns any model that behaves like a publication
    # @publication.class => Post
    authorize @publication, policy_class: PublicationPolicy
    @publication.publish!
    redirect_to @publication
  end
  def admin_list?
    user.admin?
  end
  def new?
    create?
  end

  def update?
      @post = Post.find(params[:id])
    authorize @post
    if @post.update(post_params)
      redirect_to @post
    else
      render :edit
    end
  end

  def edit?
    update?
  end

  def destroy?
    false
  end
  
  def publish
    @post = Post.find(params[:id])
    authorize @post, :update?
    @post.publish!
    redirect_to @post
  end

  class Scope
    attr_reader :user, :scope
    def initialize(user, scope)
      raise Pundit::NotAuthorizedError, "must be logged in" unless user
      @user = user
      @scope = scope
    end

    def resolve
      raise NotImplementedError, "You must define #resolve in #{self.class}"
    end
  end
end
