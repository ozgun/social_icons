module SocialIcons

  module ViewHelpers

    # default options that can be overridden on the global level
    @@social_icons_options = {
      :icon_set     => 'default'
    }
    mattr_reader :social_icons_options


    # NOT: Methodunun ismi social_icons olursa partial ismi ile çakışıyor!
    def print_social_icons(opts = {})
      link = "http://" + request.env["HTTP_HOST"] + request.request_uri
      default_opts = {:size => 48, :link => link, :title => "", :icon_set => "default"}
      opts = default_opts.merge(opts)
      opts[:icon_path] = "social_icons/#{opts[:icon_set]}/#{opts[:size]}"
      out = ""
      out << "<div class=\"social_icons_container\">"
      out << "<div class=\"facebook_like_button\">#{facebook_like_button(opts)}</div>"
      out << "<div class=\"social_icons\">"
      out << "<span class=\"social_icon_twitter\">#{social_icon_twitter(opts)}</span>"
      out << "<span class=\"social_icon_facebook\">#{social_icon_facebook(opts)}</span>"
      out << "<span class=\"social_icon_delicious\">#{social_icon_delicious(opts)}</span>"
      out << "<span class=\"social_icon_digg\">#{social_icon_digg(opts)}</span>"
      out << "<span class=\"social_icon_reddit\">#{social_icon_reddit(opts)}</span>"
      out << "</div>"
      out << "</div>"
      out
    end

    def facebook_like_button(opts = {})
      url = opts[:link]
      out = '<iframe src="http://www.facebook.com/plugins/like.php?href=' + url + '&layout=standard&show_faces=true&width=272&action=like&colorscheme=light&height=80" scrolling="no" frameborder="0" style="border:none; overflow:hidden; width:272px; height:80px;" allowTransparency="true"></iframe>'
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

  end

end
