#!/usr/bin/env ruby
require 'open-uri'
require 'yaml'
require 'json'
require 'rubygems'
require 'bundler/setup'
require 'nokogiri'

XMLNS       = 'http://www.w3.org/2005/Atom'
MEDIA_XMLNS = 'http://purl.org/syndication/atommedia'
AS_XMLNS    = 'http://activitystrea.ms/spec/1.0/'
THR_XMLNS   = 'http://purl.org/syndication/thread/1.0'
POCO_XMLNS  = 'http://portablecontacts.net/spec/1.0'
DFRN_XMLNS  = 'http://purl.org/macgirvin/dfrn/1.0'
OS_XMLNS    = 'http://ostatus.org/schema/1.0'
MTDN_XMLNS = 'http://mastodon.social/schema/1.0'

def link_href_from_xml(xml, type)
  xml.at_xpath('./xmlns:link[@rel="' + type + '"]', xmlns: XMLNS)['href']
end

def link_has_href?(xml, type)
  !(xml.at_xpath('./xmlns:link[@rel="' + type + '"]', xmlns: XMLNS).nil? || xml.at_xpath('./xmlns:link[@rel="' + type + '"]', xmlns: XMLNS)['href'].empty?)
end

directory = YAML::load_file("./_data/directory.yml")
directory_users = {}
directory.each {|handle, details|
  begin
    puts "Fetching user: #{handle}"
    data = {"handle" => handle}
    user, server = handle.split("@")
    webfinger_url = "http://#{server}/.well-known/webfinger?resource=#{handle}"
    webfinger = open(webfinger_url)
    finger = JSON.parse(webfinger.read)
    data["profile"] = finger["links"].select {|link| link["rel"] == "http://webfinger.net/rel/profile-page" }.first["href"]
    data["feed"] = finger["links"].select {|link| link["rel"] == "http://schemas.google.com/g/2010#updates-from" }.first["href"]

    feed = open(data["feed"]).read
    xml = Nokogiri::XML(feed)
    xml.encoding = 'utf-8'
    xml = xml.at_xpath('/xmlns:feed', xmlns: XMLNS) || xml.at_xpath('/xmlns:entry', xmlns: XMLNS)
    author_xml = xml.at_xpath('./xmlns:author', xmlns: XMLNS) || xml.at_xpath('./dfrn:owner', dfrn: DFRN_XMLNS)
    unless author_xml.nil?
      data["display_name"] = author_xml.at_xpath('./poco:displayName', poco: POCO_XMLNS)&.content || ''
      data["note"]         = author_xml.at_xpath('./xmlns:summary', xmlns: XMLNS)&.content || author_xml.at_xpath('./poco:note', poco: POCO_XMLNS)&.content || ''
      data["avatar_remote_url"] = link_href_from_xml(author_xml, 'avatar') if link_has_href?(author_xml, 'avatar')
      data["header_remote_url"] = link_href_from_xml(author_xml, 'header') if link_has_href?(author_xml, 'header')
    end

    if data["avatar_remote_url"]
      image = open(data["avatar_remote_url"]).read
      File.open("./assets/images/directory_avatars/#{handle}.png", "w") {|file| file.write(image) }
      data["avatar_url"] = "/assets/images/directory_avatars/#{handle}.png"
    end

    directory_users[handle] = data
  rescue Exception => e
    puts "ERROR while processing #{handle}"
    puts e.message
    puts e.backtrace.inspect
  end
}

File.open("./_data/directory_users.json", "w") {|file|
  file.write(directory_users.to_json)
}

puts "Updated directory users at ./_data/directory_users.json"


