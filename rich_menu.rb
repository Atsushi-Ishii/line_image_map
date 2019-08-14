require 'pry-byebug'
require 'uri'
require 'line-bot-api'
require './template/twenty_link_map'


class RichMenu

  include ::Template::TwentyLinkMap

  def initialize
    @client ||= Line::Bot::Client.new do |config|
      config.channel_secret = "bf5b46d85495d8282841e055540a0246"
      config.channel_token = "/MRJjewRHBIvy2ycY6Jogyshr1EX1ft5Xc7kz7aMpWn409saookP+KRzD8HuLwj6EV81dGLUYpMEz+nPTrwJpj5zi6+OMD8416G0i/gFBYNDJNVaqYfSc10tDSD8+/YEM6hfkO6nJNdvOMASR+vXWgdB04t89/1O/w1cDnyilFU="
    end
  end

  def upload(image_path, template_name)
    # リッチメニューを２０個に分ける
    template_json = twenty_link_map_json

    res = @client.create_rich_menu(template_json).body
    richMenuId = JSON.parse(res)["richMenuId"]
    puts "richMenuId => #{richMenuId}"

    @client.set_default_rich_menu(rich_menu_id)
  end

  def set_default(line_id)

  end

  def reply(request)
    @request = request
    body = @request.body.read
    events = @client.parse_events_from(body)
    events.each do |event|
      case event["type"]
      when "message"
        puts "メッセージイベントが送信されました"
      when "postback"
        postback_event(event)
      when "follow"
        puts "#{event["source"]["userId"]}にフォローされました"
      when "unfollow"
        puts "#{event["source"]["userId"]}にブロックされました"
      end
    end
  end

  def postback_event(event)
    query = URI.encode(event["postback"]["data"])
    action = URI.decode_www_form( data_str ).to_h["action"]

    # リッチメニューテンプレートの変更
    case action
    when ""
    end
  end
end

# RichMenu.new.upload("", "aaaa")
