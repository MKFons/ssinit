# Block some websites that need to waste money to buy the Nutrition Express
iptables -A OUTPUT -m string --string "t66y.com" --algo bm --to 65535 -j DROP
iptables -A OUTPUT -m string --string "pornhub.com" --algo bm --to 65535 -j DROP
iptables -A OUTPUT -m string --string "91porn.com" --algo bm --to 65535 -j DROP
iptables -A OUTPUT -m string --string "freeporn.co" --algo bm --to 65535 -j DROP
