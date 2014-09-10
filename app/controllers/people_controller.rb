class PeopleController < ApplicationController
  def new
  end

  def create
    @person = Person.new(person_params)
    if @person.save
      flash[:sucess] = 'Thanks for signing in.'
      redirect_to root_path
    else
      render 'new'
    end
  end

  private

  def person_params
    params.require(:person).permit(:name, :school, :skills)
  end
end
