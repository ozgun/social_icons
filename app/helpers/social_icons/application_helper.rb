module SocialIcons
  module ApplicationHelper

    # default options that can be overridden on the global level
    @@social_icons_options = {
      :icon_set     => 'default'
    }
    mattr_reader :social_icons_options

    def facebook_comments(opts)
      load_social_icon_js(:facebook)
      default_opts = {:title => "", :desc => "", :link => ""}
      opts = default_opts.merge(opts)
      %^<div class="fb-comments" data-href="#{opts[:link]}" data-num-posts="2" data-width="470"></div>^.html_safe
    end

    def print_social_icon(button_name, opts = {})
      content_tag :span, class: "social_button social_button_#{button_name}" do
        eval("#{button_name}_button(opts)").html_safe
      end
    end

    def load_social_icon_js(js, opts = {})
      @social_icon_javascripts ||= []
      return if @social_icon_javascripts.include?(js) 

      case js
      when :facebook
        content_for :after_body do
          '<div id="fb-root"></div>'.html_safe
        end
        content_for :head do
          render("/social_icons/shared/facebook_like_js").html_safe
        end
      when :google_plus
        content_for :head do
          render("/social_icons/shared/google_plus_js", opts: opts).html_safe
        end
      end
      @social_icon_javascripts << js
    end

    def facebook_like_button(opts = {})
      load_social_icon_js(:facebook)
      %^<div class="fb-like" data-href="#{opts[:link]}" data-send="true" data-width="450" data-show-faces="true"></div>^
    end

    def twitter_tweet_button(opts)
      default_opts = {:title => "", :desc => "", :link => ""}
      opts = default_opts.merge(opts)
      %^<a href="https://twitter.com/share" class="twitter-share-button" data-url="#{opts[:link]}" data-text="#{CGI.escapeHTML(opts[:title])}">Tweet</a>
<script>!function(d,s,id){var js,fjs=d.getElementsByTagName(s)[0];if(!d.getElementById(id)){js=d.createElement(s);js.id=id;js.src="//platform.twitter.com/widgets.js";fjs.parentNode.insertBefore(js,fjs);}}(document,"script","twitter-wjs");</script>^
    end

    def google_plus_button(opts)
      load_social_icon_js(:google_plus, opts)
      default_opts = {lang: 'TR', :title => "", :desc => "", :link => ""}
      opts = default_opts.merge(opts)
 # "href" attribute'ü gönderilmezse mevcut sayfayı +1'ler
      %{<!-- Place this tag where you want the +1 button to render -->
<g:plusone size="medium" href="#{opts[:link]}"></g:plusone>}.html_safe
    end

  end
end
