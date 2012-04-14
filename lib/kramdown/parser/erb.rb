class Kramdown::Parser::Erb < Kramdown::Parser::Kramdown
  def initialize(source, options)
    super
    @span_parsers.unshift(:erb_tags)
  end

  ERB_TAGS_START = /<%.*?%>/

  def parse_erb_tags
    @src.pos += @src.matched_size
    begin
      @tree.children << Element.new(:raw, options[:renderer].render(:inline => " #{@src.matched.strip}"))
    rescue Exception => e
      Rails.logger.error "[Kramdown::Parser::Erb#parse_erb_tags] TemplateError: #{e.message}.\n#{e.backtrace.join("\n")}"
      @tree.children << Element.new(:raw, "TemplateError: #{e.message} on #{@src.matched.strip}") if options[:debug]
    end
  end
  define_parser(:erb_tags, ERB_TAGS_START, '<%')
end