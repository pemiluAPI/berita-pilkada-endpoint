module Pemilu
  class APIv1 < Grape::API
    version 'v1', using: :accept_version_header
    prefix 'api'
    format :json

    resource :candidate do
      desc "Return list of candidate"
      get do
        results = Candidate.apiall(params)
        {
          results: results
        }
      end
    end

    resource :region do
      desc "Return list of region"
      get do
        results = Region.apiall(params)
        {
          results: results
        }
      end
    end

    resource :resource do
      desc "Return list of resource"
      get do
        results = Resource.apiall(params)
        {
          results: results
        }
      end
    end

    resource :news do
      desc "Return list of news"
      get do
        results = News.apiall(params)
        {
          results: results
        }
      end
    end

  end
end