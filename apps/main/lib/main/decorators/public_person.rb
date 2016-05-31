require "berg/decorator"

module Main
  module Decorators
    class PublicPerson < Berg::Decorator
      def job_title_text
        job_title.value
      end

      def avatar_url(size="original")
        attache_url_for(avatar["path"], size.to_s) if avatar
      end

      def attache_url_for(file_path, geometry)
        prefix, basename = File.split(file_path)
        [Berg::Container["config"].attache_downloads_base_url, "view", prefix, CGI.escape(geometry), CGI.escape(basename)].join('/')
      end

      def twitter_username
        twitter.value
      end

      def website_url
        website.value
      end
    end
  end
end