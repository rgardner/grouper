namespace :db do
  desc 'Fill database with sample data'
  task populate: :environment do
    make_users
  end
end

def make_users
  50.times do
    name = Faker::Name.name
    school = Faker::Company.name
    known_skills = random_skills(Skill.all.count)
    wanted_skills = random_skills(Skill.all.count)
    User.create!(name:   name,
                 school: school,
                 known_skills:  known_skills,
                 wanted_skills: wanted_skills)
  end
end

def random_skills(number_skills)
  skills = (1..number_skills).map { [0, 1].sample }
  skills = skills.each_with_index.map { |value, i| i + 1 if value > 0 }
  skills.delete_if(&:nil?)
end
