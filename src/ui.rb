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
    when :gameplay
      if id == KbReturn or id == KbEnter
        if @screen.box_chosen
          @screen.continue_game
        else
          @screen.choose_box
          @screen.gray_out_boxes
        end
      elsif id == KbRight or id == KbD
        @screen.highlight_right_box unless @screen.box_chosen
      elsif id == KbLeft or id == KbA
        @screen.highlight_left_box unless @screen.box_chosen
      end
    when :gameover
      if id == KbReturn or id == KbEnter
        @screen.reset_game
        @screen.name = :title
      end
    end
  end
  
  def update
    @screen.draw_back(@frame) if @screen.name == :title
    @screen.name = :gameover if @screen.zero_energy
    
    if @frame >= 60 then @frame = 0 else @frame += 1 end
  end

  def draw
    @screen.render
  end
  
  # ---------- END Gosu Window functions ------------
end
