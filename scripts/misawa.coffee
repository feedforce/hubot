# Description:
#   地獄のミサワの「女に惚れさす名言集」
#
# Commands:
#   hubot misawa - 地獄のミサワの「女に惚れさす名言集」 ランダム
#   hubot misawa <query> - 地獄のミサワの「女に惚れさす名言集」 完全一致検索

util = require 'util'
module.exports = (robot) ->
  robot.respond /misawa(?:\s+)?(.+?)?(?:\s*)$/i, (msg) ->
    msg.http('http://horesase-boys.herokuapp.com/meigens.json')
      .get() (err, res, body) ->
        if err
          msg.send util.inspect err
        else
          data = JSON.parse(body)
          query = msg.match[1]
          if !!query && !(query.match /^\s+$/)
            founds = data.filter (meigen, idx) ->
              if meigen.body
                body = meigen.body.replace '\n', ''
                (body.indexOf query) > -1
              else
                false
            if founds.length
              msg.send founds[Math.floor(Math.random() * founds.length)].image
            else
              msg.send 'http://jigokuno.img.jugem.jp/20110526_2122394.gif'
              msg.send "Meigen Not Found: #{query}"
          else
            msg.send data[Math.floor(Math.random() * data.length)].image
