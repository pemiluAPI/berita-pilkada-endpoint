class Resource < ActiveRecord::Base
	has_many :news

  validates :name,
  					presence: true

  scope :by_id, lambda{ |id| where("id = ?", id) unless id.nil? }

  def self.apiall(data = {})
    resources          = self.by_id(data[:id])
    paginate_resources = resources.limit(setlimit(data[:limit])).offset(data[:offset])

    return {
      resources: paginate_resources.map{|value| value.construct},
      count: paginate_resources.count,
      total: resources.count
		}
  end

  def construct
    return {
      id: id,
      name: name
    }
  end

protected
  def self.setlimit(limit)
    limit = (limit.to_i == 0 || limit.empty?) ? 1000 : limit
  end

end
