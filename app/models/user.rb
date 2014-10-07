# Event attendees.
class User < ActiveRecord::Base
  before_save { known_skills.delete_if(&:empty?) }
  before_save { wanted_skills.delete_if(&:empty?) }
  before_save { email.downcase! }
  before_save { school.downcase! }

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i
  validates :name, presence: true, length: { maximum: 50 }
  validates :email, presence: true,
                    format: { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }
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
