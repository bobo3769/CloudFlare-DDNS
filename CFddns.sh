#!/bin/bash
#v2.1 by bobo3769


echo "         ____  ____  _   _______"
echo "        / __ \/ __ \/ | / / ___/"
echo "       / / / / / / /  |/ /\__ \ "
echo "      / /_/ / /_/ / /|  /___/ / "
echo "     /_____/_____/_/ |_//____/  "
echo "                   on CloudFlare"
echo "                                "

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

##紀錄設定##
{
#你的域名是什麼呢？例如:"yourdomain.net"
domain="yourdomain.net"

#主機名稱要用什麼呢？例如:"test"表示 "test.yourdomain.net"
#使用"@"作為根...阿就是"yourdomain.net"的意思
hostname="test"

#Record ID
#必須先手動建立一條紀錄
#然後使用那個"get record id.sh"的腳本取得
Record_ID="thatID"
}

##更多設定##
{
#Time To Live
#紀錄快取存活時間
#頻繁變更IP時TTL越小越好
#最短為120秒,設為1是Auto
TTL=1

#要不要給CloudFlare代理網頁服務
#選擇"true"或"false"
#設為true時DNS解析會將此網址指向CF的網頁伺服器
proxied=false
}

##選項設定##
{
#也可以不改啦

#多久要檢查一次呢？
#建議設置2min以上
againtime=10m
}

#============================================#
#   ╔╦╗╔═╗╔╗╔/╔╦╗  ╔╦╗╔═╗╦ ╦╔═╗╦ ╦  ╔╦╗╔═╗   #
#    ║║║ ║║║║  ║    ║ ║ ║║ ║║  ╠═╣  ║║║║╣    #
#   ═╩╝╚═╝╝╚╝  ╩    ╩ ╚═╝╚═╝╚═╝╩ ╩  ╩ ╩╚═╝   #
#============================================#
#DO NOT CHANGE anything after this line if you dont know what you do
#在這行之後別碰我呀 除非你清楚你正在做什麼
{
#DEBUG MODE
DEBUG=false
}

{
MYIP=Unknown

# loop
while [ 1 = 1 ]
     do
	 LASTIP=`echo $MYIP`
     #getip
     MYIP=`curl -s "https://api.ipify.org"`

     #say
	         echo "    ________________________________________  "
	         echo "  / \                                       \ "
	         echo " |   |            DDNS on CloudFlare        | "
	         echo "  \_ |  Domain:   $hostname.$domain"
	         echo "     |                                      | "
	         echo "     |  My ip is  $MYIP "
	         echo "     |                                      | "
	         echo "     |  Last time $LASTIP "
	         echo "     |                                      | "
     {
	 if [ "$DEBUG" = "false" ]
	     then
	         echo "     |                                      | "
	 	 else
	         echo "DEBUG MODE = $DEBUG"
	         echo "Set to "false" to hide the following information"
	         echo "--data"
	         echo '{"type":"A","name":"'$hostname.$domain'","content":"'$MYIP'","ttl":"'$TTL'","proxied":'$proxied'}'
	 fi
     }
	 echo
     #put
	 {
     if [ "$MYIP" = "$LASTIP" ]
         then
	         echo "     |                                      | "
	         echo "     |  Nothing Change.                     | "
	         echo "     |                                      | "
			 
         else
			 {
			 if [ "$DEBUG" = "false" ]
			     then
			     curl -X PUT "https://api.cloudflare.com/client/v4/zones/$ZONE_ID/dns_records/$Record_ID" \
                  -H "X-Auth-Email: $EMAIL" \
                  -H "X-Auth-Key: $GLOBAL_API_KEY" \
                  -H "Content-Type: application/json" \
                  --data '{"type":"A","name":"'$hostname.$domain'","content":"'$MYIP'","ttl":"'$TTL'","proxied":'$proxied'}'   > /dev/null
	         echo "     |                                      | "
	         echo "     |   IP record change!                  | "
	         echo "     |                                      | "
				 
			     else
	         curl -X PUT "https://api.cloudflare.com/client/v4/zones/$ZONE_ID/dns_records/$Record_ID" \
                  -H "X-Auth-Email: $EMAIL" \
                  -H "X-Auth-Key: $GLOBAL_API_KEY" \
                  -H "Content-Type: application/json" \
                  --data '{"type":"A","name":"'$hostname.$domain'","content":"'$MYIP'","ttl":"'$TTL'","proxied":'$proxied'}'
			     
			 fi
			 }
	 fi
	 }
	 #time
	         echo "     |   waitting for "$againtime""
	         echo "     |                                      | "
			 y=`date +%Y`
			 m=`date +%m`
			 d=`date +%d`
			 hr=`date +%H`
			 min=`date +%M`
			 sec=`date +%S`
	         echo "     |              $y/$m/$d  $hr:$min:$sec"
	         echo "     |   ___________________________________|___ "
	         echo "     |  /                                      / "
	         echo "     \_/______________________________________/ "
	         echo $feedback
     sleep $againtime
done
}
