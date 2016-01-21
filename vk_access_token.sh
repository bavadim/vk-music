#!/bin/bash

app_id='3483409'
app_domain='http://oauth.vk.com/blank.html'
url=https://oauth.vk.com/authorize\?client_id\=${app_id}\&scope=offline,audio\&redirect_uri=${app_domain}\&display=page\&response_type=token


if [[ "$OSTYPE" == "darwin"* ]]; then open ${url}; else xdg-open ${url}; fi;  
echo -n "Enter access_token from browser address string: "
read access_token
echo "export VK_TOKEN=${access_token}" >> ~/.profile
