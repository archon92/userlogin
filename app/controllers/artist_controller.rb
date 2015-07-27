class ArtistController < ApplicationController
  require 'open-uri'
  require 'json'
  api_key="2fd8afcac7a86aa151106909183bcd5e"
  before_action :confirm_logged_in


  def search
  @art=Artistinfo.where(:user_id => session[:userid]).order("created_at desc")    
  end

  def details          
    @artist=Artistinfo.new
    @artist.artistname = params[:artistname]
    session[:artist_name]=params[:artistname]
    @artist.user_id=session[:userid]
    @artist.save
    if @artist.save
      name=params[:artistname]
      if !single_word?(name)
        name.gsub!(' ','%20').to_s
      end
      @result=JSON.parse(open("http://ws.audioscrobbler.com/2.0/?method=artist.getinfo&artist="+name+"&api_key="+"2fd8afcac7a86aa151106909183bcd5e"+"&format=json").read)
      @similar=JSON.parse(open("http://ws.audioscrobbler.com/2.0/?method=artist.getsimilar&artist="+name+"&api_key="+"2fd8afcac7a86aa151106909183bcd5e"+"&format=json").read)
          
    end
      
  end
  def single_word?(string)
    !string.strip.include? " "
  end

end
