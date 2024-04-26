class Resources::MoviesController < ResourcesController
  def index
    movies = MovieAccessibilityQuery.new(filter_params[:accessibility], current_user).call
    render json: { data: { movies: movies } }, status: :ok
  end

  def create
    movie = current_user.movies.new(movie_params)

    if movie.save
      render json: { data: { movie: movie } }, status: :created
    else
      render json: { errors: 'Movie was not saved. Verify info.' }, status: :bad_request
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
      render json: { errors: 'Movie was not updated. Verify info.' }, status: :bad_request
    end
  end

  private

  def movie_params
    params.require(:movie).permit(:name, :producer, :accessibility, :released_date)
  end

  def filter_params
    params.require(:filter).permit(:accessibility)
  end
end
