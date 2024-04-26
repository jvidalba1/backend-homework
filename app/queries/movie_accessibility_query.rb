class MovieAccessibilityQuery
  def initialize(filter, user, options = {})
    @filter = filter ||= 'public'
    @user = user
    @options = options
  end

  def call
    page = @options[:page] || 1
    page_size = @options[:page_size]

    return Movie.for_all.page(page).per(page_size) if @filter == 'public'
    return @user.movies.page(page).per(page_size) if @filter == 'private'
  end
end
