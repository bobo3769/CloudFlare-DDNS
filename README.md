# CloudFlare-DDNS
DDNS on CloudFlare

**依賴bash**
 

 下載後更改驗證資料
 ```
 EMAIL="yourmail@mail.com""
 ZONE_ID="yourZONEID"
 GLOBAL_API_KEY="yourAPIKEY"
 ```
 
 以及記錄設定
 ```
 domain="yourdomain.net"
 hostname="test"
 Record_ID="thatID"
 ```
改成自己的資料即可使用

不知道Record_ID時找出"get record id.sh"
先將驗證資料填入後執行
然後在一排排的文字中找到你想要的那條紀錄就對了
 
 
>如果你的網域沒有託管給CloudFlare
>~出口在那邊 謝謝~
