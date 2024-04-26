class MovieAccessibilityQuery
  def initialize(filter='public', user)
    @filter = filter
    @user = user
  end

  def call
    return Movie.for_all if @filter == 'public'
    return @user.movies if @filter == 'private'
  end
end
