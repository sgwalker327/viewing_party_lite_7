class Movie
  attr_reader :id,
              :title,
              :vote_average,
              :summary,
              :runtime,
              :genres,
              :cast,
              :reviews,
              :review_count,
              :poster_path
  
  def initialize(data)
    require 'pry'; binding.pry
    @id = data[:id]
    @title = data[:title]
    @vote_average = data[:vote_average]
    @summary = data[:overview]
    @runtime = data[:runtime]
    @genres = data[:genres]
    @cast = cast_info(data[:cast])
    @reviews = review_info(data[:results])
    @review_count = data[:total_results]
    @poster_path = data[:poster_path]
  end

  def cast_info(info)
    
    hash = {}
    
    info.each do |cast|
      hash[cast[:name]] = cast[:character]
    end
   
    return hash.first(10).to_h
  end

  def review_info(info)
    hash = {}
    info.each do |review|
      hash[review[:author]] = review[:content]
    end
   return hash
  end
end