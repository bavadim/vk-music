#!/bin/bash

save_folder=$1; shift;

token=$VK_TOKEN;

getMusicList() {
  local token="$1"; shift;
  local xml=`curl -s "https://api.vk.com/method/audio.get.xml?access_token=$token" | sed "s/<?xml version=\"1.0\" encoding=\"utf-8\"?>/ /g"` 2>&1
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

getMusicList $token;
