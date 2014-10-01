# Event attendees.
class User < ActiveRecord::Base
  before_save { known_skills.delete_if(&:empty?) }
  before_save { wanted_skills.delete_if(&:empty?) }
  before_save { school.downcase! }

  validates :name, presence: true, length: { maximum: 50 }
  validates :school, presence: true

  def interests
    known_skills | wanted_skills
  end

  def to_h
    { name => skills_to_hash(interests) }
  end

  private

  def skills_to_hash(skills)
    Skill.all.size.times.reduce({}) do |a, e|
      a.merge(Skill.find(e + 1).name => skills.include?((e + 1).to_s) ? 1 : 0)
    end
  end
end
