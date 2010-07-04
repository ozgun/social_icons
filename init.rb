# Include hook code here
require "social_icons/version"
require "social_icons/view_helpers"
ActionView::Base.send :include, SocialIcons::ViewHelpers 
