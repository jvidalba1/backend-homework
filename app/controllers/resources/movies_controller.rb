class Resources::MoviesController < ResourcesController
  before_action :set_pagination_options, only: [:index]

  def index
    movies = MovieAccessibilityQuery.new(params[:accessibility], current_user, @pagination_options).call
    render json: {
      data: {
        movies: movies
      },
      pagination: {
        total_pages: movies.total_pages,
        current_page: movies.current_page
      }
    }, status: :ok
  end

  def create
    movie = current_user.movies.new(movie_params)

    if movie.save
      render json: { data: { movie: movie } }, status: :created
    else
      render json: { errors: movie.errors.full_messages }, status: :bad_request
    end
  end

  def update
    # this line could be current_user.movies.find(params[:id]) to get only own movies
    # but for exercise description, point 3e, its managed by cancancan ability
    # to raise access denied when trying to update not own movie
    movie = Movie.find(params[:id])
    authorize! :update, movie

    if movie.update(movie_params)
      render json: { data: { movie: movie } }, status: :ok
    else
      render json: { errors: movie.errors.full_messages }, status: :bad_request
    end
  end

  private

  def movie_params
    params.require(:movie).permit(:name, :producer, :accessibility, :released_date)
  end

  def set_pagination_options
    page = params[:page] || 1
    page_size = params[:page_size]
    @pagination_options = { page: page, page_size: page_size }
  end
end
