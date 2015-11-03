class News < ActiveRecord::Base
	belongs_to :candidate
	belongs_to :region
	belongs_to :resource

  validates :by_candidate_id, :by_resource_id,
  					presence: true

  scope :by_id, lambda{ |id| where("id = ?", id) unless id.nil? }
  scope :by_candidate_id, lambda{ |candidate_id| where("candidate_id = ?", candidate_id) unless candidate_id.nil? }
  scope :by_region_id, lambda{ |region_id| where("region_id = ?", region_id) unless region_id.nil? }
  scope :by_resource_id, lambda{ |resource_id| where("resource_id = ?", resource_id) unless resource_id.nil? }
  scope :by_description, lambda{ |description| where("description like ?", "%#{description}%") unless description.nil? }

  def self.apiall(data = {})
    news          = self.by_id(data[:id]).by_candidate_id(data[:candidate_id]).by_region_id(data[:region_id]).by_resource_id(data[:resource_id]).by_description(data[:description])
    paginate_news = news.limit(setlimit(data[:limit])).offset(data[:offset])

    return {
      news: paginate_news.map{|value| value.construct},
      count: paginate_news.count,
      total: news.count
		}
  end

  def construct
    return {
      id: id,
      candidate: handle(candidate),
      region: handle(region),
      resource: handle(resource),
      date: (date.strftime("%Y-%d-%m") rescue ""),
      link: link,
      description: description
    }
  end

protected
  def self.setlimit(limit)
    limit = (limit.to_i == 0 || limit.empty?) ? 1000 : limit
  end

  def handle(obj)
    obj.present? ? obj.construct : {}
  end

end
