# app/policies/dashboard_policy.rb
class DashboardPolicy
    attr_reader :user
  
    # _record in this example will just be :dashboard
    def initialize(user, _record)
      @user = user
    end
  
    def show?
      user.admin?
    end
end