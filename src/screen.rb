# screen.rb
# manages which screen to display for user interface

class Screen
  attr_accessor :name
  
  def initialize(scr = :none)
    # universal screen entities
    @name = scr
    @bgcolor = Gosu::Color::RED
    @bgmusic = Gosu::Song.new("assets/wav/techno.wav")
    @bgmusic.play(true)
    
    # title screen entities
    @coffee = Gosu::Image.new("assets/img/coffee.png")
    @title = Gosu::Image.from_text(self, "CAFFEINE!!!!", Gosu.default_font_name, 60)
    @play = Gosu::Image.from_text(self, "Press Enter to Play", Gosu.default_font_name, 60)

    # gameplay screen entities
  end

  def render
    case @name
    when :title
      draw_rect 0, 0, 800, 600, @bgcolor
      @coffee.draw 300, 150, 0
      @title.draw 275, 20, 0
      @play.draw 210, 525, 0
    end
  end

  def draw_back(frame)
    if frame < 30
      @bgcolor = Gosu::Color::RED
    else
      @bgcolor = Gosu::Color::BLUE
    end
  end
end
