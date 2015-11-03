module Pemilu
  class APIv1 < Grape::API
    version 'v1', using: :accept_version_header
    prefix 'api'
    format :json

    resource :candidates do
      desc "Return list of candidates"
      get do
        results = Candidate.apiall(params)
        {
          results: results
        }
      end
    end

    resource :regions do
      desc "Return list of regions"
      get do
        results = Region.apiall(params)
        {
          results: results
        }
      end
    end

    resource :resources do
      desc "Return list of resources"
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