class Candidate < ActiveRecord::Base
	has_many :news

  validates :name,
  					presence: true

  scope :by_id, lambda{ |id| where("id = ?", id) unless id.nil? }

  def self.apiall(data = {})
    candidates          = self.by_id(data[:id])
    paginate_candidates = candidates.limit(setlimit(data[:limit])).offset(data[:offset])

    return {
      candidates: paginate_candidates.map{|value| value.construct},
      count: paginate_candidates.count,
      total: candidates.count
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
