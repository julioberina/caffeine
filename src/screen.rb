# screen.rb
# manages which screen to display for user interface

class Screen
  attr_writer :name
  
  def initialize(scr = :none)
    @name = scr
    @entities = []
    @coffee = Gosu::Image.new("../assets/img/coffee.png")
  end

  def add_entity(entity)
    @entities << entity
  end

  def clear_entities
    @entities.pop until @entities.empty?
  end

  def render
    case @name
    when :gameplay
      draw_rect 0, 0, 800, 600, Gosu::Color::RED
      @coffee.draw 300, 200, 0
    end
  end
end
