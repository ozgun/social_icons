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

    def print_social_icons(opts = {})
      link = "http://" + request.env["HTTP_HOST"] + request.path
      default_opts = {:size => 48, :link => link, :title => "", :icon_set => "default"}
      opts = default_opts.merge(opts)
      opts[:icon_path] = "social_icons/#{opts[:icon_set]}/#{opts[:size]}"
      out = ""
      out << "<div class=\"social_icons_container\">"
      #out << "<div class=\"social_icons\">"
      #out << "<span class=\"social_icon_twitter social_icon\">#{social_icon_twitter(opts)}</span>"
      #out << "<span class=\"social_icon_facebook social_icon\">#{social_icon_facebook(opts)}</span>"
     # out << "<span class=\"social_icon_delicious\">#{social_icon_delicious(opts)}</span>"
     # out << "<span class=\"social_icon_digg\">#{social_icon_digg(opts)}</span>"
     # out << "<span class=\"social_icon_reddit\">#{social_icon_reddit(opts)}</span>"
      out << "<span class=\"twitter_tweet_button social_button\">#{twitter_tweet_button(opts)}</span>"
      out << "<span class=\"google_plus_button social_button\">#{google_plus_button(opts)}</span>"
      out << "<span class=\"facebook_like_button social_button\">#{facebook_like_button(opts)}</span>"

      #out << "</div>"
      out << "</div>"
      out.html_safe
    end

    def load_social_icon_js(js)
      @social_icon_javascripts ||= []
      unless @social_icon_javascripts.include?(js)
        case js
        when :facebook
          content_for :after_body do
            '<div id="fb-root"></div>'.html_safe
          end
          content_for :head do
            %^
<script>(function(d, s, id) {
  var js, fjs = d.getElementsByTagName(s)[0];
  if (d.getElementById(id)) return;
  js = d.createElement(s); js.id = id;
  js.src = "//connect.facebook.net/en_US/all.js#xfbml=1";
  fjs.parentNode.insertBefore(js, fjs);
}(document, 'script', 'facebook-jssdk'));</script>
            ^.html_safe
          end
          @social_icon_javascripts << :facebook
        end
      end
    end

    def facebook_like_button(opts = {})
      load_social_icon_js(:facebook)
      url = opts[:link]
      #<div class="fb-like" data-href="#{}http://google.com?abc=&#xf6;l" data-send="true" data-width="450" data-show-faces="true"></div>
      out = %^<div class="fb-like" data-href="#{opts[:link]}" data-send="true" data-width="450" data-show-faces="true"></div>^
      #out = '<iframe src="http://www.facebook.com/plugins/like.php?href=' + url + '&layout=standard&show_faces=true&width=272&action=like&colorscheme=light&height=80" scrolling="no" frameborder="0" style="border:none; overflow:hidden; width:272px; height:80px;" allowTransparency="true"></iframe>'
      out
    end

    # <a title="Click to share this post on Twitter" 
    #    href="http://twitter.com/home?status=Currently reading &lt;?php the_permalink(); ?&gt;" target="_blank" class="twitter">Share on Twitter</a>
    #
    def social_icon_twitter(opts = {})
      url = "http://twitter.com/home?status=#{opts[:title]}+#{opts[:link]}"
      out = link_to(image_tag("#{opts[:icon_path]}/twitter.png", :alt => t('social_icons.twitter')), url, :title => t('social_icons.twitter'), :target => "_blank")
      out
    end

    def twitter_tweet_button(opts)
      default_opts = {:title => "", :desc => "", :link => ""}
      opts = default_opts.merge(opts)
      out = %^<a href="https://twitter.com/share" class="twitter-share-button" data-url="#{opts[:link]}" data-via="kozgun">Tweet</a>
<script>!function(d,s,id){var js,fjs=d.getElementsByTagName(s)[0];if(!d.getElementById(id)){js=d.createElement(s);js.id=id;js.src="//platform.twitter.com/widgets.js";fjs.parentNode.insertBefore(js,fjs);}}(document,"script","twitter-wjs");</script>^
      
    end

    # <a name="fb_share" type="button_count" share_url="http://google.com" href="http://www.facebook.com/sharer.php">Share</a><script src="http://static.ak.fbcdn.net/connect.php/js/FB.Share" type="text/javascript"></script>
    #
    # Facebook sayfa ile ilgili bilgiyi sayfaya bağlanıp da çekiyor.
    # O yüzden title bilgisini göndermeye gerek yok.
    #
    # NOT: facebook encode edilmiş permalinkleri sevmiyor!
    def social_icon_facebook(opts = {})
      default_opts = {:title => "", :desc => "", :link => ""}
      opts = default_opts.merge(opts)
      link = "http://www.facebook.com/sharer.php?u=" + 
        CGI.unescape(opts[:link]) + 
        "&t=#{opts[:title]}"
      out = "<a onclick=\"window.open('#{link}'" + 
        ",'sharer','toolbar=0,status=0,width=626,height=436');return false;\"" + 
        '" href="' + link + '">' + 
        image_tag("#{opts[:icon_path]}/facebook.png", 
                  :alt => t("social_icons.facebook"), 
                  :title => t("social_icons.facebook")) +
        '</a>'
      out
    end

    # <a title="Digg this post" href="http://digg.com/submit?phase=2&amp;url=http%3A%2F%2Fwww.weddingbee.com%2F2009%2F03%2F11%2Fadd-share-icons-for-social-media%2F" rel="nofollow" target="_blank"><img alt="Digg this post" src="http://www-static.weddingbee.com/images/digg.gif" style="border: medium none ;"></a>
    def social_icon_digg(opts)
      icon_label = t("social_icons.digg")
      default_opts = {:title => "", :desc => "", :link => ""}
      opts = default_opts.merge(opts)
      out = '<a title="' + 
        icon_label + 
        '" href="http://digg.com/submit?phase=2&url=' +
        opts[:link] +
        '&title=' + 
        opts[:title] +
        '" rel="nofollow" target="_blank">' +
        image_tag("#{opts[:icon_path]}/digg.png", :alt => icon_label, :title => icon_label) +
        '</a>'
    end

     # <a href="http://delicious.com/save?url=<?php urlencode(the_permalink()); ?>&amp;title=<?php urlencode(the_title()); ?>" onclick="window.open('http://delicious.com/save?v=5&amp;noui&amp;jump=close&amp;url=<?php urlencode(the_permalink()); ?>&amp;title=<?php urlencode(the_title()); ?>', 'delicious', 'toolbar=no,width=550,height=550'); return false;" title="Bookmark this post on del.icio.us"> </a>
    def social_icon_delicious(opts)
      icon_label = t("social_icons.delicious")
      default_opts = {:title => "", :desc => "", :link => ""}
      opts = default_opts.merge(opts)
      out = '<a href="http://delicious.com/save?url=' +
        opts[:link] + 
        '&title=' + 
        opts[:title] +
        '" onclick="' + 
        "window.open('http://delicious.com/save?v=5&amp;noui&amp;jump=close&amp;url=" +
        opts[:link] + 
        '&amp;title=' + 
        opts[:title] +
        "', 'delicious', 'toolbar=no,width=550,height=550'); return false;\" title=\"" +
        "Bookmark this post on del.icio.us" + '"> ' +
        image_tag("#{opts[:icon_path]}/delicious.png", :alt => icon_label, :title => icon_label) +
        '</a>'
    end


    # <a href="http://reddit.com/submit?url=<?php the_permalink(); ?>" rel="nofollow" title="Submit to Reddit" target="_blank"> </a>
    def social_icon_reddit(opts)
      icon_label = t("social_icons.reddit")
      default_opts = {:title => "", :desc => "", :link => ""}
      opts = default_opts.merge(opts)
      out = '<a href="http://reddit.com/submit?url=' +
        opts[:link] + 
        '&title=' +
        opts[:title] + 
        '" rel="nofollow" title="' + 
        opts[:title] + 
        '" target="_blank">' + 
        image_tag("#{opts[:icon_path]}/reddit.png", :alt => icon_label, :title => icon_label) +
        '</a>'
    end

    def google_plus_button(opts)
      default_opts = {lang: 'TR', :title => "", :desc => "", :link => ""}
      opts = default_opts.merge(opts)
 # "href" attribute'ü gönderilmezse mevcut sayfayı +1'ler
    %{<!-- Place this tag where you want the +1 button to render -->
<g:plusone size="medium" href="#{opts[:link]}"></g:plusone>

<!-- Place this render call where appropriate -->
<script type="text/javascript">
    window.___gcfg = {lang: '#{opts[:lang]}'};
  (function() {
    var po = document.createElement('script'); po.type = 'text/javascript'; po.async = true;
    po.src = 'https://apis.google.com/js/plusone.js';
    var s = document.getElementsByTagName('script')[0]; s.parentNode.insertBefore(po, s);
  })();
</script>}

    end


  end
end
