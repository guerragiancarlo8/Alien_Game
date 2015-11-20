=begin
	
Project: Platformer "FuZeD"
Start date: 20/11/15
Author: Giancarlo M. Guerra

=end

$:<<File.dirname(__FILE__)
require 'gosu'
require 'rubygems'
include Gosu
require_relative 'scripts/GameWindow.rb'
require_relative 'scripts/SceneMap.rb'
require_relative 'scripts/Player.rb'

window = GameWindow.new
window.show