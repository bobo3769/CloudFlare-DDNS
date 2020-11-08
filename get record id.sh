#!/bin/bash
# GET Record ID on CloudFlare
#v1.0 by bobo3769

#============================================#
#                  ╔═╗╔═╗╔╦╗                 #
#                  ╚═╗║╣  ║                  #
#                  ╚═╝╚═╝ ╩                  #
#============================================#
#設定的部分

##驗證資料##
{
#你用來註冊CloudFlare的Email
EMAIL="yourmail@mail.com"

#ZONE ID
#在網域Overview內的API區塊可以找到 Zone ID
ZONE_ID="yourZONEID"

#API KEY
#點選API區塊下方的"Get your API token"
#在"API Keys"區塊中點選"View"輸入密碼後即可取得
###請保護好他###
GLOBAL_API_KEY="yourAPIKEY"
}



#============================================#
#   ╔╦╗╔═╗╔╗╔/╔╦╗  ╔╦╗╔═╗╦ ╦╔═╗╦ ╦  ╔╦╗╔═╗   #
#    ║║║ ║║║║  ║    ║ ║ ║║ ║║  ╠═╣  ║║║║╣    #
#   ═╩╝╚═╝╝╚╝  ╩    ╩ ╚═╝╚═╝╚═╝╩ ╩  ╩ ╩╚═╝   #
#============================================#
#DO NOT CHANGE anything after this line if you dont know what you do
#在這行之後別碰我呀 除非你清楚你正在做什麼

curl -X GET https://api.cloudflare.com/client/v4/zones/$ZONE_ID/dns_records \
-H x-auth-email:$EMAIL \
-H x-auth-key:$GLOBAL_API_KEY \
-H content-type: application/json

echo ""
echo ""
echo "看看上面的結果來找你要的Record ID吧！"
echo "可以複製到文件編輯器裡面查找。"
echo "腳本於10min後關閉，可強制離開..."
sleep 10m