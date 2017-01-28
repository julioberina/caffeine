# ui.rb file
# user interface for game
require "gosu"
include Gosu

require_relative "screen"

class CaffeineUI < Gosu::Window
  
  def initialize
    super 800, 600
    self.caption = "Caffeine"
    @screen = Screen.new(:title)
    @frame = 0
  end
  
  # ---------- BEGIN Gosu Window functions ----------

  def button_up(id)
    case @screen.name
    when :title
      if id == KbReturn or id == KbEnter
        @screen.name = :gameplay
      end
    when @screen.name == :gameplay
    when @screen.name == :gameover
    end
  end
  
  def update
    @screen.draw_back(@frame) if @screen.name == :title
    
    if @frame >= 60 then @frame = 0 else @frame += 1 end
  end

  def draw
    @screen.render
  end
  
  # ---------- END Gosu Window functions ------------
end
