# @author weichienhung
# portal controller
class PortalController < ApplicationController
  before_filter :authenticate_user!

  def index
  end

end
