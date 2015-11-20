# Alien_Game 
Author: Giancarlo M. Guerra
A simple platformer game using the Gosu library. 

I am following this tutorial: https://corruptgd.wordpress.com/tutorials-creating-a-platformer-in-ruby-gosu/

In no way am I claiming that this game is originally mine. This is just something I'm doing to get myself familiar with the Gosu library + game programming in Ruby in general. Some of the explanations and method calls are deprecated, so i'll also document this experience here for future use (maybe to communicate it to the author of the tutorial?)

ISSUES:

1. when calling load_tiles, it is no longer necessary to include $window. Also, you must pass a hash as a parameter for the optional values. 
  
  DOESNT WORK => Image.load_tiles($window, "some_image_path.png", 32,32, false)
  WORKS => Image.load_tiles("some_image_path.png", 32,32,{:tileable => false})

