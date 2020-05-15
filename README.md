# Grouper

**This project has been archived and is no longer under active development.**

Grouper was a web application for pairing groups of people together based on
their interests. It was intended to be used at Tech@NYU club events for our
weekly "After Hours" sessions (like mini-hackathons).

Grouper was a [Ruby on Rails](https://rubyonrails.org/) web app where users
would enter their interests, which were run then through K-means clustering
(provided by the [kmeans](https://rubygems.org/gems/kmeans/versions/0.1.1)
gem) to generate the groups. The results were visualized via
[D3](https://d3js.org/).
