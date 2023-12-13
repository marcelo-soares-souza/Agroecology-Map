# frozen_string_literal: true

module ApplicationHelper
  def form_for_midia(condition, &block)
    form_for [@type, @midia], html: { multipart: true }, &block
  end

  def form_for_blog(condition, &block)
    form_for [@local, @blog], html: { multipart: true }, &block if condition
  end

  def title(*parts)
    content_for(:title) { (parts << t(:site_name)).join(" | ") } unless parts.empty?
  end
  def parse_video_url(url)
    @url = url

    youtube_formats = [
        %r(https?://youtu\.be/(.+)),
        %r(https?://www\.youtube\.com/watch\?v=(.*?)(&|#|$)),
        %r(https?://www\.youtube\.com/embed/(.*?)(\?|$)),
        %r(https?://www\.youtube\.com/v/(.*?)(#|\?|$)),
        %r(https?://www\.youtube\.com/user/.*?#\w/\w/\w/\w/(.+)\b)
      ]

    vimeo_formats = [%r(https?://vimeo.com/(\d+)), %r(https?://(www\.)?vimeo.com/(\d+))]

    @url.strip!

    if @url.include? "youtu"
      youtube_formats.find { |format| @url =~ format } and $1
      @results = { provider: "youtube", id: $1 }
      @results
    elsif @url.include? "vimeo"
      vimeo_formats.find { |format| @url =~ format } and $1
      @results = { provider: "vimeo", id: $1 }
      @results
    else
      nil # There should probably be some error message here
    end
  end

  def youtube_embed(youtube_url)
    if youtube_url[/youtu\.be\/([^?]*)/]
      youtube_id = $1
    else
      youtube_url[/^.*((v\/)|(embed\/)|(watch\?))\??v?=?([^&?]*).*/]
      youtube_id = $5
    end
    %Q{<iframe title="YouTube video player" width="640" height="390" src="https://www.youtube.com/embed/#{ youtube_id }" frameborder="0" allowfullscreen></iframe>}
  end
end
