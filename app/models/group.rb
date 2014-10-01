# Create groups of attendees using kmeans.
class Group < ActiveRecord::Base
  def self.create_groups(num_groups)
    hash = User.all.each.reduce({}) { |a, e| a.merge(e.to_h) }
    kmeans = Kmeans::Cluster.new(hash, centroids: num_groups, loop_max: 10)
    kmeans.make_cluster
    kmeans.cluster.values
  end
end
