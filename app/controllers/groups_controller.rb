# Display the groups for a given event.
class GroupsController < ApplicationController
  def index
    @groups = Group.create_groups(5)
  end
end
