# vk-music

Скрипты для формирования m3u плейлиста из плейлиста Вконтакте.

Использование:

1. Запускаем `vk_access_token.sh`, открывается браузер и из адресной строки копируем access_token
2. `export VK_TOKEN=${access_token}`, можно прописать в .bashrc и больше никогда не выполнять 1 и 2 пункты
3. `./vk2playlist` > my.m3u или `./vk2playlist getRecommendations > myRecommendations.m3u` 
