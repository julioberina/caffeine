# screen.rb
# manages which screen to display for user interface

class Screen
  attr_accessor :name
  
  def initialize(scr = :none)
    @name = scr
    @coffee = Gosu::Image.new("assets/img/coffee.png")
    @title = Gosu::Image.from_text(self, "CAFFEINE!!!!", Gosu.default_font_name, 60)
    @bgcolor = Gosu::Color::RED
  end

  def render
    case @name
    when :title
      draw_rect 0, 0, 800, 600, @bgcolor
      @coffee.draw 300, 150, 0
      @title.draw 275, 20, 0
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
