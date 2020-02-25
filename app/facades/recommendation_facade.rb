class RecommendationFacade
  attr_reader :token, :mood, :cuisine

  def initialize(params, token)
    @token = token
    @params = params
  end

  def moods
    service.recommendations[:mood][:playlists].map do |playlist_hash|
      Playlist.new(playlist_hash)
    end
  end

  def cuisines
    service.recommendations[:cuisine][:playlists].map do |playlist_hash|
      Playlist.new(playlist_hash)
    end
  end

  def combos
    service.recommendations[:combos][:playlists].map do |playlist_hash|
      Playlist.new(playlist_hash)
    end
  end

  private

  def service
    return @service if @service
    @service = BeetFarmerService.new(@token, @params)
  end
end