class MoviesController < ApplicationController
  def index
    # FOR ACTIVE RECORD SEARCH
    # NOTE first simple search for a title
    # NOTE .present or .nil can work. .empty works for arrays
    # NOTE If params[:search] is present it will return the search results else it will return all of the movies
    if params[:query].present?
      # @movies = Movie.where(title: params[:query])

      # NOTE ILIKE is for case insensitive
      # @movies = Movie.where("title ILIKE ?", params[:query])

      # NOTE: LIKE -> search for words affliated with others words ex. "dog" will return "dog" and "dogville", etc.

      # For multiple columns
      # NOTE % is for wildcard(meaning that anything can be before or after the query)
      # NOTE: The OR operator searches both the title and synopsis for the query
      # @movies = Movie.where("title ILIKE :query OR synopsis ILIKE :query", query: "%#{params[:query]}%")

      # NOTE Full text search
      # NOTE @@ -> will search for multiple terms, as well as things like
        # @movies = Movie.where("title @@ :query OR synopsis @@ :query", query: "%#{params[:query]}%")
      # NOTE Search through associations / joins
      # NOTE Join the table before the query
      # Example: finding movies that have the director's name

      #   sql_query = " \
      #   movies.title ILIKE :query \
      #   OR movies.synopsis ILIKE :query \
      #   OR directors.first_name ILIKE :query \
      #   OR directors.last_name ILIKE :query \
      # "
      # @movies = Movie.joins(:director).where(sql_query, query: "%#{params[:query]}%")

      # FOR PG SEARCH
      @movies = Movie.search_by_title_and_synopsis(params[:query])

    else
      @movies = Movie.all
    end
  end
end
