module RichMenu
  class SwichTap
    def upload(image_path, template)
      # リッチメニューのテンプレートをアップロードする
      case template
      when "template_left"
        template_json = template_left_json
      when "template_right"
        template_json = template_right_json
      end

      res = CLIENT.create_rich_menu(template_json).body

      richMenuId = JSON.parse(res)["richMenuId"]
      puts "richMenuId＝＞#{richMenuId}"

      # リッチメニューに画像を適用する
      res = CLIENT.create_rich_menu_image(richMenuId, open(image_path))

    end

    def swich_menu(action)
      case action
      when "to_left"
        rich_menu_id = "richmenu-8c8051c50f67fcb5924e4207c21371e0"
      when "to_right"
        rich_menu_id = "richmenu-634d0ef4d6e9fd34ccf3ac3e2230a035"
      end
      CLIENT.link_user_rich_menu(LINEID, rich_menu_id)
    end

    def template_left_json
      content = {}
      content["size"] = {}
      content["size"]["width"] = 2500
      content["size"]["height"] = 1686

      content["selected"] = true
      content["name"] = "タブで２つに分ける(左)"
      content["chatBarText"] = "タブで２つに分ける(左)"
      content["areas"] = []


      links = [
        "from=swich_map&action=to_right", # 1
        "from=swich_map&action=to_right", # 2
        "from=swich_map&action=to_left", # 3
        "from=swich_map&action=to_left", # 4
        "https://tabelog.com/tokyo/A1304/A130401/13004332/", # 5
        "https://tabelog.com/tokyo/A1304/A130401/13004267/", # 6
        "https://tabelog.com/tokyo/A1304/A130401/13006685/", # 7
        "https://tabelog.com/tokyo/A1304/A130401/13000747/", # 8
        "https://tabelog.com/tokyo/A1304/A130401/13004332/", # 9
        "https://tabelog.com/tokyo/A1304/A130401/13004267/", # 10
        "https://tabelog.com/tokyo/A1304/A130401/13006685/", # 11
        "https://tabelog.com/tokyo/A1304/A130401/13000747/", # 12
        "https://tabelog.com/tokyo/A1304/A130401/13087540/", # 13
        "https://tabelog.com/tokyo/A1304/A130401/13177053/", # 14
        "https://tabelog.com/tokyo/A1304/A130401/13043578/", # 15
        "https://tabelog.com/tokyo/A1304/A130401/13012089/", # 16
        "https://tabelog.com/tokyo/A1304/A130401/13087540/", # 17
        "https://tabelog.com/tokyo/A1304/A130401/13177053/", # 18
        "https://tabelog.com/tokyo/A1304/A130401/13043578/", # 19
        "https://tabelog.com/tokyo/A1304/A130401/13012089/", # 20
      ]

      # [x,y.width,heght]
      positions = [
        [0,0,625,337],[625,0,625,337],[1250,0,625,337],[1875,0,625,337],
        [0,337,625,337],[625,337,625,337],[1250,337,625,337],[1875,337,625,337],
        [0,674,625,337],[625,674,625,337],[1250,674,625,337],[1875,674,625,337],
        [0,1011,625,337],[625,1011,625,337],[1250,1011,625,337],[1875,1011,625,337],
        [0,1348,625,337],[625,1348,625,337],[1250,1348,625,337],[1875,1348,625,337],
      ]

      links.each.with_index(0) do |link, index|
        content_areas = {}
        content_areas['bounds'] = {}
        content_areas['bounds']["x"] = positions[index][0]
        content_areas['bounds']["y"] = positions[index][1]
        content_areas['bounds']["width"] = positions[index][2]
        content_areas['bounds']["height"] = positions[index][3]
        content_areas['action'] = {}

        if link.match("http")
          content_areas['action']['type'] = 'uri'
          content_areas['action']['label'] = ""
          content_areas['action']['uri'] = link
        else
          content_areas['action']['type'] = 'postback'
          content_areas['action']['data'] = link
          content_areas['action']['displayText'] = "タブ変更"
        end
        content["areas"].push( content_areas )
      end

      return content
    end

    def template_right_json
      content = {}
      content["size"] = {}
      content["size"]["width"] = 2500
      content["size"]["height"] = 1686

      content["selected"] = true
      content["name"] = "タブで２つに分ける(右)"
      content["chatBarText"] = "タブで２つに分ける(右)"
      content["areas"] = []


      links = [
        "from=swich_map&action=to_right", # 1
        "from=swich_map&action=to_right", # 2
        "from=swich_map&action=to_left", # 3
        "from=swich_map&action=to_left", # 4
        "https://tabelog.com/tokyo/A1304/A130401/13026041/", #5
        "https://tabelog.com/tokyo/A1304/A130401/13151040/", #6
        "https://tabelog.com/tokyo/A1304/A130401/13052913/", #7
        "https://tabelog.com/tokyo/A1304/A130401/13190469/", #8
        "https://tabelog.com/tokyo/A1304/A130401/13026041/", #9
        "https://tabelog.com/tokyo/A1304/A130401/13151040/", #10
        "https://tabelog.com/tokyo/A1304/A130401/13052913/", #11
        "https://tabelog.com/tokyo/A1304/A130401/13190469/", #12
        "https://tabelog.com/tokyo/A1304/A130401/13161342/", #13
        "https://tabelog.com/tokyo/A1304/A130401/13049584/", #14
        "https://tabelog.com/tokyo/A1304/A130401/13017390/", #15
        "https://tabelog.com/tokyo/A1304/A130401/13012061/", #16
        "https://tabelog.com/tokyo/A1304/A130401/13161342/", #17
        "https://tabelog.com/tokyo/A1304/A130401/13049584/", #18
        "https://tabelog.com/tokyo/A1304/A130401/13017390/", #19
        "https://tabelog.com/tokyo/A1304/A130401/13012061/", #20
      ]

      # [x,y.width,heght]
      positions = [
        [0,0,625,337],[625,0,625,337],[1250,0,625,337],[1875,0,625,337],
        [0,337,625,337],[625,337,625,337],[1250,337,625,337],[1875,337,625,337],
        [0,674,625,337],[625,674,625,337],[1250,674,625,337],[1875,674,625,337],
        [0,1011,625,337],[625,1011,625,337],[1250,1011,625,337],[1875,1011,625,337],
        [0,1348,625,337],[625,1348,625,337],[1250,1348,625,337],[1875,1348,625,337],
      ]

      links.each.with_index(0) do |link, index|
        content_areas = {}
        content_areas['bounds'] = {}
        content_areas['bounds']["x"] = positions[index][0]
        content_areas['bounds']["y"] = positions[index][1]
        content_areas['bounds']["width"] = positions[index][2]
        content_areas['bounds']["height"] = positions[index][3]
        content_areas['action'] = {}
        if link.match("http")
          content_areas['action']['type'] = 'uri'
          content_areas['action']['label'] = ""
          content_areas['action']['uri'] = link
        else
          content_areas['action']['type'] = 'postback'
          content_areas['action']['data'] = link
          content_areas['action']['displayText'] = "タブ変更"
        end
        content["areas"].push( content_areas )
      end

      return content
    end
  end
end
