$:<< File.dirname(__FILE__)

require 'gosu'
require 'rubygems'
include Gosu

require_relative 'editor/EditorWindow.rb'
require_relative 'editor/SceneEditor.rb'

$window = EditorWindow.new
$window.show
