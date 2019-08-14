require 'sinatra'
require 'pry-byebug'
require 'line-bot-api'
require 'uri'

Dir[File.expand_path('rich_menu/**/*.rb', __dir__)].each do |f|
  require f
end

CLIENT = Line::Bot::Client.new do |config|
  config.channel_secret = "bf5b46d85495d8282841e055540a0246"
  config.channel_token = "/MRJjewRHBIvy2ycY6Jogyshr1EX1ft5Xc7kz7aMpWn409saookP+KRzD8HuLwj6EV81dGLUYpMEz+nPTrwJpj5zi6+OMD8416G0i/gFBYNDJNVaqYfSc10tDSD8+/YEM6hfkO6nJNdvOMASR+vXWgdB04t89/1O/w1cDnyilFU="
end

LINEID = "U26f125d4cf4b98ce60c2407dc8fd9d71"

module RichMenu

  def self.upload_menu(capchar, image_path)
    case capchar
    # bundle exec ruby src/rich_menu.rb upload_menu twenty_map /Users/ishiiatsushi/Documents/リッチメニュー/twenty_map.jpg
    when "twenty_map"
      TwentyMap.new.upload(image_path)
    when "swich_tap_left"
      SwichTap.new.upload(image_path, "template_left")
    when "swich_tap_right"
      SwichTap.new.upload(image_path, "template_right")
    end
  end

  def self.set_menu(capchar, rich_menu_id)
    case capchar
    when "twenty_map"
      res = CLIENT.set_default_rich_menu(rich_menu_id)
    when "swich_tap_left"
      # 左のリッチメニューを指定
      res = CLIENT.set_default_rich_menu(rich_menu_id)
    when "swich_tap_right"
      # 右のリッチメニューを指定
      res = CLIENT.set_default_rich_menu(rich_menu_id)
    end
  end
end

# 実行
case ARGV[0]
when "upload_menu"
  RichMenu.upload_menu(ARGV[1], ARGV[2])
when "set_menu"
  RichMenu.set_menu(ARGV[1], ARGV[2])
end


post '/webhook' do
  # 動作させるモデルによって変更させる

  body = request.body.read
  events = CLIENT.parse_events_from(body)
  events.each do |event|
    case event["type"]
    when "message"
      puts "メッセージイベントが送信されました"
    when "postback"
      data = URI.encode(event["postback"]["data"])
      action = URI.decode_www_form( data ).to_h["action"]
      from = URI.decode_www_form( data ).to_h["from"]

      case from
      when "swich_map"
       RichMenu::SwichTap.new.swich_menu(action)
      end
    when "follow"
      puts "#{event["source"]["userId"]}にフォローされました"
    when "unfollow"
      puts "#{event["source"]["userId"]}にブロックされました"
    end
  end
end
#
