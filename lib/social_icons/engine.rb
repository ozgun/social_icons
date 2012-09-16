module SocialIcons
  class Engine < ::Rails::Engine
    isolate_namespace SocialIcons

		initializer 'social_icons.helper' do |app|
      #app.config.assets.precompile += %w(social_icons.js)
      ActionView::Base.send :include, SocialIcons::ApplicationHelper 
    end
  end
end
