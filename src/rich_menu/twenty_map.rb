module RichMenu
  class TwentyMap
    # リッチメニューを２０個に分ける
    def upload(image_path)
      # リッチメニューのテンプレートをアップロードする
      res = CLIENT.create_rich_menu(template_json).body

      unless res.status == "200"
        puts res.body
      end

      richMenuId = JSON.parse(res)["richMenuId"]
      puts "richMenuId＝＞#{richMenuId}"

      # リッチメニューに画像を適用する
      res = CLIENT.create_rich_menu_image(richMenuId, open(image_path))

      unless res.status == "200"
        puts res.body
      end
    end

    def template_json
      content = {}
      content["size"] = {}
      content["size"]["width"] = 2500
      content["size"]["height"] = 1686

      content["selected"] = true
      content["name"] = "リッチメニュー２０分割"
      content["chatBarText"] = "リッチメニュー２０分割"
      content["areas"] = []


      links = [
        "https://tabelog.com/tokyo/A1304/A130401/13004332/",
        "https://tabelog.com/tokyo/A1304/A130401/13004267/",
        "https://tabelog.com/tokyo/A1304/A130401/13006685/",
        "https://tabelog.com/tokyo/A1304/A130401/13000747/",
        "https://tabelog.com/tokyo/A1304/A130401/13087540/",
        "https://tabelog.com/tokyo/A1304/A130401/13177053/",
        "https://tabelog.com/tokyo/A1304/A130401/13043578/",
        "https://tabelog.com/tokyo/A1304/A130401/13012089/",
        "https://tabelog.com/tokyo/A1304/A130401/13012094/",
        "https://tabelog.com/tokyo/A1304/A130401/13026041/",
        "https://tabelog.com/tokyo/A1304/A130401/13151040/",
        "https://tabelog.com/tokyo/A1304/A130401/13052913/",
        "https://tabelog.com/tokyo/A1304/A130401/13190469/",
        "https://tabelog.com/tokyo/A1304/A130401/13161342/",
        "https://tabelog.com/tokyo/A1304/A130401/13049584/",
        "https://tabelog.com/tokyo/A1304/A130401/13017390/",
        "https://tabelog.com/tokyo/A1304/A130401/13012061/",
        "https://tabelog.com/tokyo/A1304/A130401/13109242/",
        "https://tabelog.com/tokyo/A1304/A130401/13017381/",
        "https://tabelog.com/tokyo/A1304/A130401/13089080/",
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
        content_areas['action']['type'] = 'uri'
        content_areas['action']['label'] = "ランキング#{index}位"
        content_areas['action']['uri'] = link
        content["areas"].push( content_areas )
      end

      return content
    end
  end
end
