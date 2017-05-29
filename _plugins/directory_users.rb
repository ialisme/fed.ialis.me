module DirectoryUsers
  class Description < Liquid::Tag
    def initialize(tag_name, handle, tokens)
      super
      @handle = handle
    end

    def render(context)
      handle = Liquid::Template.parse(@handle).render(context)
      handle = handle.strip
      users = JSON.parse(File.read("./_data/directory_users.json"))
      user = users[handle.strip]
      unless user
        puts "WARNING: Directory user not found for #{handle.inspect}"
        user = {}
      end

      user["note"]
    end

  end

  class Name < Liquid::Tag
    def initialize(tag_name, handle, tokens)
      super
      @handle = handle
    end

    def render(context)
      handle = Liquid::Template.parse(@handle).render(context)
      handle = handle.strip
      users = JSON.parse(File.read("./_data/directory_users.json"))
      user = users[handle.strip]
      unless user
        puts "WARNING: Directory user not found for #{handle.inspect}"
        user = {}
      end

      user["display_name"]
    end

  end

  class ProfileLink < Liquid::Tag
    def initialize(tag_name, handle, tokens)
      super
      @handle = handle
    end

    def render(context)
      handle = Liquid::Template.parse(@handle).render(context)
      handle = handle.strip
      users = JSON.parse(File.read("./_data/directory_users.json"))
      user = users[handle.strip]
      unless user
        puts "WARNING: Directory user not found for #{handle.inspect}"
        user = {}
      end

      nickname, server = handle.strip.split('@')
      alternative_link = "http://#{server.strip}/@#{nickname.strip}"

      user["profile"] || alternative_link
    end

  end

  class RemoteAvatar < Liquid::Tag
    def initialize(tag_name, handle, tokens)
      super
      @handle = handle
    end

    def render(context)
      handle = Liquid::Template.parse(@handle).render(context)
      handle = handle.strip
      users = JSON.parse(File.read("./_data/directory_users.json"))
      puts "Handle: #{handle.strip.inspect}"
      user = users[handle.strip]
      unless user
        puts "WARNING: Directory user not found for #{handle.inspect}"
        user = {}
      end

      puts user.inspect
      user["avatar_url"] || "/assets/images/missing_avatar.png"
    end
  end

end

Liquid::Template.register_tag('directory_user_description', DirectoryUsers::Description)
Liquid::Template.register_tag('directory_user_name', DirectoryUsers::Name)
Liquid::Template.register_tag('directory_user_avatar', DirectoryUsers::RemoteAvatar)
Liquid::Template.register_tag('directory_user_profile', DirectoryUsers::ProfileLink)


