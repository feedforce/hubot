# Description:
#   PullRequestの雛形を表示する
#
# Dependencies:
#   None
#
# Configuration:
#   None
#
# Commands:
#   hubot pr-template

prTemplateText = '''
```
簡単なPRだったり、PRへのPRだったりする場合などは、必ずしもこのフォーマットに従う必要はない。

### TODO (任意)

* [ ] todo1
* [ ] todo2
* [ ] todo3

### 動作確認方法

どのような振る舞いであるべきかを書く。
レビュアーにとって確認方法が難しければ、分かるように書く。
重点的に見て欲しかったり、自信がない箇所があれば書く。

### 希望レビュアー
```
                 '''

module.exports = (robot) ->
  robot.respond /pr-template/i, (msg) ->
    msg.send prTemplateText
