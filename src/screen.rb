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
    @energy = [[10, 40], [30, 40], [50, 40], [70, 40], [90, 40],
               [110, 40], [130, 40], [150, 40], [170, 40], [190, 40]]

    # box chosen
    @box_chosen = false

    # box highlighted
    @box_highlighted = 0
    
    # box color
    @boxes = [[50, 250], [200, 250], [350, 250], [500, 250], [650, 250]]
    @box_color = Gosu::Color::YELLOW

    # what's inside the box
    @boxes_contents = ["brew", "donut", "empty", "empty", "empty"]
    @boxes_contents.shuffle!
    @box_item = nil
    @last_chosen = ""
    
    # current hour
    @hour = 0

    # hour font
    @font = Gosu::Font.new(40)

    # carbs count
    @carbs_count = 0
    
    # text to be displayed on screen
    @energy_text = Gosu::Image.from_text(self, "Energy", Gosu.default_font_name, 25)
    @select_text = Gosu::Image.from_text(self, "Select box to reveal its contents", Gosu.default_font_name, 40)
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
      @font.draw "Hour " + @hour.to_s,  350, 10, 0
      @energy.each { |e| draw_rect e[0], e[1], 20, 20, Gosu::Color::GREEN }
      @boxes.length.times do |i|
        if i == @box_highlighted and @box_chosen == false
          draw_rect @boxes[i][0], @boxes[i][1], 100, 100, Gosu::Color::WHITE
        else
          draw_rect @boxes[i][0], @boxes[i][1], 100, 100, @box_color
        end
      end
      
      @box_item.draw(@boxes[@box_highlighted][0], @boxes[@box_highlighted][1], 0) unless @box_item.nil?
    end
  end

  def inc_hour
    @hour += 1

    unless @last_chosen == "brew" or @carbs_count == 3
      @energy.pop
      @carbs_count = 0 if @carbs_count >= 3
    end
  end

  def box_chosen
    return @box_chosen
  end

  def choose_box
    @last_chosen = @boxes_contents[@box_highlighted]
    
    if @boxes_contents[@box_highlighted] == "empty"
      @box_item = nil
    else
      @box_item = Gosu::Image.new("assets/img/" + @boxes_contents[@box_highlighted] + ".png")
      @carbs_count += 1 if @boxes_contents[@box_highlighted] == "donut"
    end
    
    @box_chosen = true
  end

  def zero_energy
    return @energy.empty?
  end

  def continue_game
    @box_chosen = false
    @box_color = Gosu::Color::YELLOW
    @boxes_contents.shuffle!
    inc_hour
    @box_item = nil
  end
  
  def highlight_left_box
    if @box_highlighted == 0 then @box_highlighted = 4 else @box_highlighted -= 1 end
  end

  def highlight_right_box
    if @box_highlighted == 4 then @box_highlighted = 0 else @box_highlighted += 1 end 
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
