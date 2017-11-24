# Description:
#   Notification of the study meeting.

cronJob = require('cron').CronJob
module.exports = (robot) ->
  tz = 'Asia/Saigon'
  listUsers = {
    "2271814": "Hoa",
    "2189871": "Trung",
    "2283905": "Tùng",
    "2284642": "Duy",
    "2006399": "Ngọc",
    "2406328": "Nhàn",
    "2452050": "Dũng",
    "2502915": "Yến",
    "704223": "A Thắng",
    "862029": "Diệu",
    "2626205": "Nam",
    "2726824": "A Hào"
  }
  toAll = ""
  for id, name of listUsers
    toAll += "[To:#{id}] {name}\n"
  rooms = process.env.HUBOT_CHATWORK_ROOMS.split ","
  envelope = room: rooms[0]
  #Reminder: Daily meeting
  dailyMtg = () ->
    robot.send envelope, toAll + "Daily Meeting!\n Mọi người đứng dậy đi nào!"
  
  #for golang
  dailyUpdateTicket = () ->
    robot.send envelope, toAll + "Mọi người update ticket trước 9h sáng nhé!"

  playKemxoi = () ->
    robot.send envelope, toAll + "Ai kem xôi không!"

  new cronJob('30 14 08 * * 1-5', (->
    do dailyMtg
  ), null, false, tz).start()

  new cronJob('30 45 08 * * 1-5', (->
    do dailyUpdateTicket
  ), null, false, tz).start()

  new cronJob('30 55 14 * * 1-5', (->
    do playKemxoi
  ), null, false, tz).start()