#!/bin/bash

base_url='https://api.vk.com/method';
token=${VK_TOKEN};

getMusicList() {
  local method_part="$1"; shift;
  local token="$1"; shift;
  local url="${base_url}/audio.${method_part}&access_token=${token}&count=6000"
  local xml=`curl -s ${url} | sed "s/<?xml version=\"1.0\" encoding=\"utf-8\"?>/ /g"` 2>&1
  local xslt_xml="<?xml version=\"1.0\" encoding=\"utf-8\"?>
        <?xml-stylesheet type=\"text/xml\" href=\"#stylesheet\"?>
        <!DOCTYPE doc [
        <!ATTLIST xsl:stylesheet
        id      ID      #REQUIRED>
        ]>
        <doc>
                <xsl:stylesheet id=\"stylesheet\" version=\"1.0\" xmlns:xsl=\"http://www.w3.org/1999/XSL/Transform\">
                  <xsl:output method=\"text\" />

                  <xsl:template match=\"/\">
                    <xsl:for-each select=\"doc/response/audio\"> 
                      <xsl:text>#EXTINF:</xsl:text><xsl:value-of select=\"duration\"/>,<xsl:value-of select=\"artist\"/> - <xsl:value-of select=\"title\"/>
                      <xsl:text>&#10;</xsl:text>
                      <xsl:value-of select=\"url\"/> 
                      <xsl:text>&#10;</xsl:text>
                    </xsl:for-each>
                  </xsl:template>
                </xsl:stylesheet>

                $xml

        </doc>"

  echo "#EXTM3U";
  echo $xslt_xml | xsltproc -
}

error() {
  echo "Usage: vk2m3u [COMMAND] [ARGUMENT]";
  echo "Available commands: get, getRecommendations, search";
  exit 1;
}

method=$1; shift;
arg=$1; shift;

case "$method" in
"get")
  if [[ -z  $arg  ]]; then method_part="${method}.xml?"; else method_part="${method}.xml?owner_id=${arg}"; fi;
  ;;
"getRecommendations")
  if [[ -z  $arg  ]]; then method_part="${method}.xml?"; else method_part="${method}.xml?user_id=${arg}"; fi;
  ;;
"search")
  if [[ -z  $arg  ]]; then error; else  method_part="${method}.xml?q=${arg}"; fi;
  method_part="${method}.xml?q=${arg}"
  ;;
"")
  method_part="get.xml?"
  ;;
*)
  error;
  ;;
esac

getMusicList ${method_part} ${token};
