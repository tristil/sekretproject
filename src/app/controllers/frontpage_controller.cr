require "amethyst"

class FrontpageController < Base::Controller
  actions :home

  view "home", "#{__DIR__}/../views"
  def home
    @name = "World"
    respond_to do |format|
      format.html { render "home" }
    end
  end
end
