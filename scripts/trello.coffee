# Description:
#   slack to trello
#
# Commands:
#   hubot trello add <listName> <taskName>

trello = require('node-trello')

HUBOT_TRELLO_API_KEY    = process.env.HUBOT_TRELLO_API_KEY
HUBOT_TRELLO_API_TOKEN  = process.env.HUBOT_TRELLO_API_TOKEN
HUBOT_TRELLO_BOARD_ID   = process.env.HUBOT_TRELLO_BOARD_ID

t = new trello(
  HUBOT_TRELLO_API_KEY
  HUBOT_TRELLO_API_TOKEN
)

getBoards = (msg, args) ->
  url = "/1/boards"

  t.get url, (err, data) =>
    console.log data

getList = (msg, args) ->
  url = "/1/boards/#{args['boardId']}/lists"

  t.get url, (err, Lists) =>
    for list in Lists
      if list.name.toLowerCase() is args['listName']
        args['listId'] = list.id
        addCard msg, args

addCard = (msg, args) ->
  url = "/1/lists/#{args['listId']}/cards"

  t.post url, {
    name: args['taskName']
  }, (err, data) =>
    msg.reply data.shortUrl

module.exports = (robot) ->
  robot.respond /trello\s+add\s+(.*)\s+(.*)?$/i, (msg) ->
    getList msg, {
      boardId: HUBOT_TRELLO_BOARD_ID
      listName: msg.match[1]
      taskName: msg.match[2]
    }
