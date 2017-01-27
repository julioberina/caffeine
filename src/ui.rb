# ui.rb file
# user interface for game
require "gosu"
include Gosu

require_relative "engine"
require_relative "screen"

class CaffeineUI < Gosu::Window
  
  def initialize
    super 800, 600
    self.caption = "Caffeine"
    @engine = Engine.new
    @screen = Screen.new(:title)
  end
  
  # ---------- BEGIN Gosu Window functions ----------

  def button_down(id)
    if id == Gosu::KbSpace
      @screen.name = :gameplay
    elsif id == Gosu::KbReturn
      @screen.name = :title
    end
  end
  
  def update
    
  end

  def draw
    @screen.render
  end
  
  # ---------- END Gosu Window functions ------------
end
