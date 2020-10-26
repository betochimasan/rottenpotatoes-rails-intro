class MoviesController < ApplicationController

  def show
    id = params[:id] # retrieve movie ID from URI route
    @movie = Movie.find(id) # look up movie by unique ID
    # will render app/views/movies/show.<extension> by default
  end

  def index
    @all_ratings = Movie.all_ratings()
    """
    if params[:ratings]
      if params[:order]
        # ratings AND order parameters
        @ratings_to_show = params[:ratings].keys
        @column_selected = params[:order]
        session[:ratings] = params[:ratings]
        session[:order] = params[:order]
        @movies = Movie.with_ratings(@ratings_to_show).sort_by(params[:order])
      elsif session[:order]
        # ratings params but order via session
        @ratings_to_show = params[:ratings].keys
        @column_selected = session[:order]
        session[:ratings] = params[:ratings]
        @movies = Movie.with_ratings(@ratings_to_show).sort_by(session[:order])        
      else
        # ratings params but no order
        @ratings_to_show = params[:ratings].keys
        @column_selected = ""
        session[:ratings] = params[:ratings]
        @movies = Movie.with_ratings(@ratings_to_show)
      end      
    elsif session[:ratings]
      if params[:order]
        # order params but ratings via session
        @ratings_to_show = session[:ratings].keys
        @column_selected = params[:order]
        session[:order] = params[:order]
        @movies = Movie.with_ratings(@ratings_to_show).sort_by(params[:order])
      elsif session[:order]
        # both ratings and order via session
        @ratings_to_show = session[:ratings].keys
        @column_selected = session[:order]
        @movies = Movie.with_ratings(@ratings_to_show).sort_by(session[:order])
      else
        # ratings session but no order
        @ratings_to_show = session[:ratings].keys
        @column_selected = ""
        @movies = Movie.with_ratings(@ratings_to_show)
      end      
    else
      if params[:order]
        # no ratings but order params
        @ratings_to_show = []
        @column_selected = params[:order]
        session[:order] = params[:order]
        @movies = Movie.with_ratings(@ratings_to_show).sort_by(params[:order])
        session[:ratings] = {'G': 1, 'PG': 1, 'PG-13': 1, 'R': 1}
      elsif session[:order]
        # no ratings but order session
        @ratings_to_show = []
        @column_selected = session[:order]
        @movies = Movie.with_ratings(@ratings_to_show).sort_by(session[:order])
        session[:ratings] = {'G': 1, 'PG': 1, 'PG-13': 1, 'R': 1}
      else
        # neither ratings nor order
        @ratings_to_show = []
        @column_selected = ""
        @movies = Movie.with_ratings(@ratings_to_show)
        session[:ratings] = {'G': 1, 'PG': 1, 'PG-13': 1, 'R': 1}
      end  
    end
    """
    #redirect_to movies_path({:ratings => session[:ratings], :order => session[:order]})
    
    """
    if !(params[:ratings] or session[:ratings])
      # No saved ratings settings
      if !(params[:order] or session[:order])
        # No saved order settings, so no sorting
        @ratings_to_show = []
        @column_selected = ""
        @movies = Movie.with_ratings(@ratings_to_show)
        session[:ratings] = {'G': 1, 'PG': 1, 'PG-13': 1, 'R': 1}
        #redirect_to movies_path({:ratings => {'G': 1, 'PG': 1, 'PG-13': 1, 'R': 1}})
        #return
      elsif session[:order]
        # order session variables
        @ratings_to_show = []
        @column_selected = session[:order]
        @movies = Movie.with_ratings(@ratings_to_show).sort_by(session[:order])
        session[:ratings] = {'G': 1, 'PG': 1, 'PG-13': 1, 'R': 1}
        #redirect_to movies_path({:ratings => {'G': 1, 'PG': 1, 'PG-13': 1, 'R': 1}, :order => session[:order]})
        #return
      else
        # order parameters
        @ratings_to_show = []
        @column_selected = params[:order]
        session[:order] = params[:order]
        @movies = Movie.with_ratings(@ratings_to_show).sort_by(params[:order])
        session[:ratings] = {'G': 1, 'PG': 1, 'PG-13': 1, 'R': 1}
        #redirect_to movies_path({:ratings => {'G': 1, 'PG': 1, 'PG-13': 1, 'R': 1}, :order => session[:order]})
        #return
      end
    elsif session[:ratings]
      # ratings session variables
      if !(params[:order] or session[:order])
        # No saved order settings, so no sorting
        @ratings_to_show = session[:ratings].keys
        @column_selected = ""
        @movies = Movie.with_ratings(@ratings_to_show)
        #redirect_to movies_path({:ratings => session[:ratings]})
        #return
      elsif session[:order]
        # order session variables
        @ratings_to_show = session[:ratings].keys
        @column_selected = session[:order]
        @movies = Movie.with_ratings(@ratings_to_show).sort_by(session[:order])
        #redirect_to movies_path({:ratings => session[:ratings], :order => session[:order]})
        #return        
      else
        # order parameters
        @ratings_to_show = session[:ratings].keys
        @column_selected = params[:order]
        session[:order] = params[:order]
        @movies = Movie.with_ratings(@ratings_to_show).sort_by(params[:order])
        #redirect_to movies_path({:ratings => session[:ratings], :order => session[:order]})
        #return  
      end
    else
      # ratings parameters
      if !(params[:order] or session[:order])
        # No saved order settings, so no sorting
        @ratings_to_show = params[:ratings].keys
        @column_selected = ""
        session[:ratings] = params[:ratings]
        @movies = Movie.with_ratings(@ratings_to_show)
        #redirect_to movies_path({:ratings => session[:ratings]})
        #return
      elsif session[:order]
        # order session variables
        @ratings_to_show = params[:ratings].keys
        @column_selected = session[:order]
        session[:ratings] = params[:ratings]
        @movies = Movie.with_ratings(@ratings_to_show).sort_by(session[:order])
        #redirect_to movies_path({:ratings => session[:ratings], :order => session[:order]})
        #return        
      else
        # order parameters
        @ratings_to_show = params[:ratings].keys
        @column_selected = params[:order]
        session[:ratings] = params[:ratings]
        session[:order] = params[:order]
        @movies = Movie.with_ratings(@ratings_to_show).sort_by(params[:order])
        #redirect_to movies_path({:ratings => session[:ratings], :order => session[:order]})
        #return
      end
      redirect_to movies_path({:ratings => session[:ratings], :order => session[:order]})
      return
    end
    """
    
    if params[:ratings]
      @ratings_to_show = params[:ratings].keys
      session[:ratings] = params[:ratings]
    elsif session[:ratings]
      @ratings_to_show = session[:ratings].keys    
    else
      @ratings_to_show = []
    end
    if params[:order]
      @movies = Movie.with_ratings(@ratings_to_show).sort_by(params[:order])
      session[:order] = params[:order]
    elsif session[:order]
      @movies = Movie.with_ratings(@ratings_to_show).sort_by(session[:order])  
    else
      @movies = Movie.with_ratings(@ratings_to_show)
    end
    @column_selected = session[:order]
    
  end

  def new
    # default: render 'new' template
    session.clear
  end

  def create
    @movie = Movie.create!(movie_params)
    flash[:notice] = "#{@movie.title} was successfully created."
    redirect_to movies_path
  end

  def edit
    @movie = Movie.find params[:id]
  end

  def update
    @movie = Movie.find params[:id]
    @movie.update_attributes!(movie_params)
    flash[:notice] = "#{@movie.title} was successfully updated."
    redirect_to movie_path(@movie)
  end

  def destroy
    @movie = Movie.find(params[:id])
    @movie.destroy
    flash[:notice] = "Movie '#{@movie.title}' deleted."
    redirect_to movies_path
  end

  private
  # Making "internal" methods private is not required, but is a common practice.
  # This helps make clear which methods respond to requests, and which ones do not.
  def movie_params
    params.require(:movie).permit(:title, :rating, :description, :release_date)
  end
end
