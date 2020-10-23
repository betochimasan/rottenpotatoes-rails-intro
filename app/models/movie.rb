class Movie < ActiveRecord::Base
  def self.with_ratings(ratings_list)
    if ratings_list.empty?
      Movie.all
    else
      Movie.where(rating: ratings_list)
    end
  end
  
  def self.all_ratings()
     ['G','PG','PG-13','R']
  end
  
  def self.sort_by(means)
    Movie.order(means)
  end
    
end
