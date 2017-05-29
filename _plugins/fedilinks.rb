class FedilinksMentionTag < Liquid::Tag
  def initialize(tag_name, text, tokens)
    super
    puts "Fedilink #{text.inspect}"
    @text = text
  end

  def render(context)
    puts "Fedilink render #{@text.inspect}"
    text = Liquid::Template.parse(@text).render(context)
    puts "Fedilink render #{text.inspect}"
    user, server = text.strip.split('@')
    puts "Fedilink user #{user.inspect}"
    puts "Fedilink server #{server.inspect}"
    "http://#{server.strip}/@#{user.strip}"
  end
end

class FedilinksFollowTag < Liquid::Tag
  def initialize(tag_name, text, tokens)
    super
    puts "Fedilink #{text.inspect}"
    @text = text
  end

  def render(context)
    puts "Fedilink render #{@text.inspect}"
    text = Liquid::Template.parse(@text).render(context)
    puts "Fedilink render #{text.inspect}"
    user, server = text.strip.split('@')
    puts "Fedilink user #{user.inspect}"
    puts "Fedilink server #{server.inspect}"
    "http://#{server.strip}/users/#{user.strip}/remote_follow"
  end
end

Liquid::Template.register_tag('mention', FedilinksMentionTag)
Liquid::Template.register_tag('follow', FedilinksFollowTag)

