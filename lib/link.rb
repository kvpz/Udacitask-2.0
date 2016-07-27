class LinkItem
  include Listable
  attr_reader :description, :site_name

  def initialize(url, options={})
    @description = url
    @site_name = options[:site_name]
  end

  def format_name
    @site_name ? @site_name : "N/A"
  end

  def details
    format_description(@description) + "site name: ".colorize(:magenta) + format_name
  end
end
