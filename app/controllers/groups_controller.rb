# Display the groups for a given event.
class GroupsController < ApplicationController
  def index
  end

  def group_data
    respond_to do |format|
      format.json {}
    end
  end
end
