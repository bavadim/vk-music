#!/bin/bash

app_id='3483409'
app_domain='http://oauth.vk.com/blank.html'


xdg-open https://oauth.vk.com/authorize\?client_id\=${app_id}\&scope=offline,audio\&redirect_uri=${app_domain}\&display=page\&response_type=token

echo -n "Enter access_token from browser address string: "
read access_token
echo "access_token: ${access_token}"
