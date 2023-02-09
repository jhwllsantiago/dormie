module Accessible
  extend ActiveSupport::Concern
  included do
    before_action :check_user
  end

  protected
  def check_user
    if current_owner
      flash.clear
      redirect_to(root_path) and return
    elsif current_occupant
      flash.clear
      redirect_to(root_path) and return
    end
  end
end