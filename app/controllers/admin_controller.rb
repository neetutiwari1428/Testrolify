class AdminController < ApplicationController
    def policy_scope(scope)
        super([:admin, scope])
    end
    
    def authorize(record, query = nil)
        super([:admin, record], query)
    end
end
class Admin::PostController < AdminController
    def index
        @sheets = policy_scope(Sheet)
    end
  
    def show
      post = authorize Post.find(params[:id])
    end
  end