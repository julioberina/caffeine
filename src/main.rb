# main.rb file
# main file for game
require_relative "ui"

class Main
  def initialize
    @ui = CaffeineUI.new
    @ui.show
  end
end

Main.new # run instance of main class
