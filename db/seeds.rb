skills = ["graphic design", "interaction design", "design research",
          "design thinking", "game design", "illustration", "game art", "ruby",
          "python", "node", "html/css", "unity", "computer vision",
          "machine learning/artificial intelligence", "data visualization",
          "data science", "data journalism"]

skills.each do |skill|
  Skill.create(name: skill)
end
