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
    # energy bar
    @energy = [[10, 40], [30, 40], [50, 40], [70, 40], [90, 40]]

    # box chosen
    @box_chosen = false
    
    # box color
    @boxes = [[50, 250], [200, 250], [350, 250], [500, 250], [650, 250]]
    @box_color = Gosu::Color::YELLOW

    # current hour
    @hour = 0
    @current_hour = "Hour " + @hour.to_s
    
    # text to be displayed on screen
    @energy_text = Gosu::Image.from_text(self, "Energy", Gosu.default_font_name, 25)
    @select_text = Gosu::Image.from_text(self, "Select box to reveal its contents", Gosu.default_font_name, 40)
    @hour_text = Gosu::Image.from_text(self, @current_hour, Gosu.default_font_name, 25)
  end

  def render
    case @name
    when :title
      draw_rect 0, 0, 800, 600, @bgcolor
      @coffee.draw 300, 150, 0
      @title.draw 275, 20, 0
      @play.draw 210, 525, 0
    when :gameplay
      @bgcolor = Gosu::Color::GRAY
      draw_rect 0, 0, 800, 600, @bgcolor
      @energy_text.draw 10, 10, 0
      @select_text.draw 175, 150, 0
      @energy.each { |e| draw_rect e[0], e[1], 20, 20, Gosu::Color::GREEN }
      @boxes.each { |box| draw_rect box[0], box[1], 100, 100, @box_color }
    end
  end

  def box_chosen
    return @box_chosen
  end

  def gray_out_boxes
    @box_color = Gosu::Color::GRAY
  end

  def draw_back(frame)
    if frame < 30
      @bgcolor = Gosu::Color::RED
    else
      @bgcolor = Gosu::Color::BLUE
    end
  end
end
