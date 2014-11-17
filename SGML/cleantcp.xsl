<?xml version="1.0" encoding="UTF-8"?>
<XSL:stylesheet xmlns:tei="http://www.tei-c.org/ns/1.0"
                xmlns:xs="http://www.w3.org/2001/XMLSchema"
                xmlns:XSL="http://www.w3.org/1999/XSL/Transform"
                exclude-result-prefixes="tei xs"
                version="2.0">
   <XSL:template match="*">
      <XSL:copy>
         <XSL:apply-templates select="@*|*|processing-instruction()|comment()|text()"/>
      </XSL:copy>
   </XSL:template>
   <XSL:template match="ETS">
      <XSL:copy>
         <XSL:variable name="hfile" select="concat('./',//IDG/@ID,'.hdr')"/>
         <XSL:if test="doc-available(resolve-uri($hfile,base-uri(/*)))">
            <XSL:message> load header <XSL:value-of select="resolve-uri($hfile,base-uri(/*))"/>
            </XSL:message>
            <XSL:copy-of select="doc(resolve-uri($hfile,base-uri(/*)))/*"/>
         </XSL:if>
         <XSL:apply-templates select="*|processing-instruction()|comment()|text()"/>
      </XSL:copy>
   </XSL:template>
   <XSL:template match="GAP/@EXTENT">
      <XSL:attribute name="EXTENT" select="normalize-space(.)"/>
   </XSL:template>
   <XSL:template match="TEXT[not(@LANG)]">
      <XSL:copy>
         <XSL:attribute name="LANG">unk</XSL:attribute>
         <XSL:apply-templates select="@*|*|processing-instruction()|comment()|text()"/>
      </XSL:copy>
   </XSL:template>
   <XSL:template match="LETTER[not(@LANG)]">
      <XSL:copy>
         <XSL:attribute name="LANG">unk</XSL:attribute>
         <XSL:apply-templates select="@*|*|processing-instruction()|comment()|text()"/>
      </XSL:copy>
   </XSL:template>
   <XSL:template match="LICENSE">
      <Q>
         <TEXT>
            <XSL:apply-templates select="@*"/>
            <BODY>
               <DIV1 TYPE="license">
                  <XSL:apply-templates select="*|processing-instruction()|comment()|text()"/>
               </DIV1>
            </BODY>
         </TEXT>
      </Q>
   </XSL:template>
   <XSL:template match="FLOATEXT">
      <Q>
         <TEXT>
            <XSL:apply-templates select="@*"/>
            <BODY>
               <DIV1>
                  <XSL:apply-templates select="@TYPE"/>
                  <XSL:apply-templates select="@N"/>
                  <XSL:apply-templates select="*|processing-instruction()|comment()|text()"/>
               </DIV1>
            </BODY>
         </TEXT>
      </Q>
   </XSL:template>
   <XSL:template match="comment()|processing-instruction()">
      <XSL:copy-of select="."/>
   </XSL:template>
   <XSL:template match="@*">
      <XSL:attribute name="{name()}">
         <XSL:sequence select="tei:entities(.,false())"/>
      </XSL:attribute>
   </XSL:template>
   <XSL:template match="text()">
      <XSL:sequence select="tei:entities(.,true())"/>
   </XSL:template>
   <XSL:function name="tei:entities">
      <XSL:param name="words"/>
      <XSL:param name="usemarkup"/>
      <XSL:analyze-string select="$words" regex="&amp;([A-z0-9\-]+);">
         <XSL:matching-substring>
            <XSL:choose>
               <XSL:when test="regex-group(1)='ballot'">☐</XSL:when>
               <XSL:when test="regex-group(1)='music'">⚻</XSL:when>
               <XSL:when test="regex-group(1)='spcacute'">´</XSL:when>
               <XSL:when test="regex-group(1)='spcbreve'">˘</XSL:when>
               <XSL:when test="regex-group(1)='spccaron'">ˇ</XSL:when>
               <XSL:when test="regex-group(1)='spccedil'">¸</XSL:when>
               <XSL:when test="regex-group(1)='spccirc'">^</XSL:when>
               <XSL:when test="regex-group(1)='spcdblac'">˝</XSL:when>
               <XSL:when test="regex-group(1)='spcdot'">˙</XSL:when>
               <XSL:when test="regex-group(1)='spcgrave'">`</XSL:when>
               <XSL:when test="regex-group(1)='spcmacr'">¯</XSL:when>
               <XSL:when test="regex-group(1)='spcogon'">˛</XSL:when>
               <XSL:when test="regex-group(1)='spcrcomma'">῾</XSL:when>
               <XSL:when test="regex-group(1)='spcring'">˚</XSL:when>
               <XSL:when test="regex-group(1)='spctilde'">˜</XSL:when>
               <XSL:when test="regex-group(1)='spcuml'">¨</XSL:when>
               <XSL:when test="regex-group(1)='AElig'">Æ</XSL:when>
               <XSL:when test="regex-group(1)='Aacugr'">Ά</XSL:when>
               <XSL:when test="regex-group(1)='Aacute'">Á</XSL:when>
               <XSL:when test="regex-group(1)='Aaigr'"></XSL:when>
               <XSL:when test="regex-group(1)='Abreve'">Ă</XSL:when>
               <XSL:when test="regex-group(1)='Acirc'">Â</XSL:when>
               <XSL:when test="regex-group(1)='Acirgr'"></XSL:when>
               <XSL:when test="regex-group(1)='Acy'">А</XSL:when>
               <XSL:when test="regex-group(1)='Agr'">Α</XSL:when>
               <XSL:when test="regex-group(1)='Agragr'">Ὰ</XSL:when>
               <XSL:when test="regex-group(1)='Agrave'">À</XSL:when>
               <XSL:when test="regex-group(1)='Aiotgr'">ᾼ</XSL:when>
               <XSL:when test="regex-group(1)='Amacr'">Ā</XSL:when>
               <XSL:when test="regex-group(1)='Aogon'">Ą</XSL:when>
               <XSL:when test="regex-group(1)='Aquar'">♒</XSL:when>
               <XSL:when test="regex-group(1)='Aragr'">Ἅ</XSL:when>
               <XSL:when test="regex-group(1)='Araigr'">ᾍ</XSL:when>
               <XSL:when test="regex-group(1)='Arcgr'">Ἇ</XSL:when>
               <XSL:when test="regex-group(1)='Arcigr'">ᾏ</XSL:when>
               <XSL:when test="regex-group(1)='Arggr'">Ἃ</XSL:when>
               <XSL:when test="regex-group(1)='Argigr'">ᾋ</XSL:when>
               <XSL:when test="regex-group(1)='Aries'">♈</XSL:when>
               <XSL:when test="regex-group(1)='Arigr'">ᾉ</XSL:when>
               <XSL:when test="regex-group(1)='Aring'">Å</XSL:when>
               <XSL:when test="regex-group(1)='Arougr'">Ἁ</XSL:when>
               <XSL:when test="regex-group(1)='Asagr'">Ἄ</XSL:when>
               <XSL:when test="regex-group(1)='Asaigr'">ᾌ</XSL:when>
               <XSL:when test="regex-group(1)='Ascgr'">Ἆ</XSL:when>
               <XSL:when test="regex-group(1)='Ascigr'">ᾎ</XSL:when>
               <XSL:when test="regex-group(1)='Asggr'">Ἂ</XSL:when>
               <XSL:when test="regex-group(1)='Asgigr'">ᾊ</XSL:when>
               <XSL:when test="regex-group(1)='Asigr'">ᾈ</XSL:when>
               <XSL:when test="regex-group(1)='Asmogr'">Ἀ</XSL:when>
               <XSL:when test="regex-group(1)='Atilde'">Ã</XSL:when>
               <XSL:when test="regex-group(1)='Auml'">Ä</XSL:when>
               <XSL:when test="regex-group(1)='Barline'">𝄁</XSL:when>
               <XSL:when test="regex-group(1)='Bcy'">Б</XSL:when>
               <XSL:when test="regex-group(1)='Bgr'">Β</XSL:when>
               <XSL:when test="regex-group(1)='CHcy'">Ч</XSL:when>
               <XSL:when test="regex-group(1)='Cacute'">Ć</XSL:when>
               <XSL:when test="regex-group(1)='Cancer'">♋</XSL:when>
               <XSL:when test="regex-group(1)='Capri'">♑</XSL:when>
               <XSL:when test="regex-group(1)='Ccaron'">Č</XSL:when>
               <XSL:when test="regex-group(1)='Ccedil'">Ç</XSL:when>
               <XSL:when test="regex-group(1)='Ccirc'">Ĉ</XSL:when>
               <XSL:when test="regex-group(1)='Cdot'">Ċ</XSL:when>
               <XSL:when test="regex-group(1)='DIGgr'">Ϝ</XSL:when>
               <XSL:when test="regex-group(1)='Dagger'">‡</XSL:when>
               <XSL:when test="regex-group(1)='Dcaron'">Ď</XSL:when>
               <XSL:when test="regex-group(1)='Dcy'">Д</XSL:when>
               <XSL:when test="regex-group(1)='Ddotb'">Ḍ</XSL:when>
               <XSL:when test="regex-group(1)='Dgr'">Δ</XSL:when>
               <XSL:when test="regex-group(1)='DotDot'">⃜</XSL:when>
               <XSL:when test="regex-group(1)='Dstrok'">Đ</XSL:when>
               <XSL:when test="regex-group(1)='EEacugr'">Ή</XSL:when>
               <XSL:when test="regex-group(1)='EEcirgr'"></XSL:when>
               <XSL:when test="regex-group(1)='EEgr'">Η</XSL:when>
               <XSL:when test="regex-group(1)='EEgragr'">Ὴ</XSL:when>
               <XSL:when test="regex-group(1)='EEiotgr'">ῌ</XSL:when>
               <XSL:when test="regex-group(1)='EEragr'">Ἥ</XSL:when>
               <XSL:when test="regex-group(1)='EEraigr'">ᾝ</XSL:when>
               <XSL:when test="regex-group(1)='EErcgr'">Ἧ</XSL:when>
               <XSL:when test="regex-group(1)='EErcigr'">ᾟ</XSL:when>
               <XSL:when test="regex-group(1)='EErggr'">Ἣ</XSL:when>
               <XSL:when test="regex-group(1)='EErgigr'">ᾛ</XSL:when>
               <XSL:when test="regex-group(1)='EErigr'">ᾙ</XSL:when>
               <XSL:when test="regex-group(1)='EErougr'">Ἡ</XSL:when>
               <XSL:when test="regex-group(1)='EEsagr'">Ἤ</XSL:when>
               <XSL:when test="regex-group(1)='EEsaigr'">ᾜ</XSL:when>
               <XSL:when test="regex-group(1)='EEscgr'">Ἦ</XSL:when>
               <XSL:when test="regex-group(1)='EEscigr'">ᾞ</XSL:when>
               <XSL:when test="regex-group(1)='EEsggr'">Ἢ</XSL:when>
               <XSL:when test="regex-group(1)='EEsgigr'">ᾚ</XSL:when>
               <XSL:when test="regex-group(1)='EEsigr'">ᾘ</XSL:when>
               <XSL:when test="regex-group(1)='EEsmogr'">Ἠ</XSL:when>
               <XSL:when test="regex-group(1)='ENG'">Ŋ</XSL:when>
               <XSL:when test="regex-group(1)='EOLhyphen'">∣</XSL:when>
               <XSL:when test="regex-group(1)='EOLunhyphen'">¦</XSL:when>
               <XSL:when test="regex-group(1)='ETH'">Ð</XSL:when>
               <XSL:when test="regex-group(1)='ETHIOPIC-BA'">በ</XSL:when>
               <XSL:when test="regex-group(1)='ETHIOPIC-BAA'">ባ</XSL:when>
               <XSL:when test="regex-group(1)='ETHIOPIC-BE'">ብ</XSL:when>
               <XSL:when test="regex-group(1)='ETHIOPIC-BEE'">ቤ</XSL:when>
               <XSL:when test="regex-group(1)='ETHIOPIC-BI'">ቢ</XSL:when>
               <XSL:when test="regex-group(1)='ETHIOPIC-BO'">ቦ</XSL:when>
               <XSL:when test="regex-group(1)='ETHIOPIC-BU'">ቡ</XSL:when>
               <XSL:when test="regex-group(1)='ETHIOPIC-BWA'">ቧ</XSL:when>
               <XSL:when test="regex-group(1)='ETHIOPIC-CA'">ቸ</XSL:when>
               <XSL:when test="regex-group(1)='ETHIOPIC-CAA'">ቻ</XSL:when>
               <XSL:when test="regex-group(1)='ETHIOPIC-CE'">ች</XSL:when>
               <XSL:when test="regex-group(1)='ETHIOPIC-CEE'">ቼ</XSL:when>
               <XSL:when test="regex-group(1)='ETHIOPIC-CHA'">ጨ</XSL:when>
               <XSL:when test="regex-group(1)='ETHIOPIC-CHAA'">ጫ</XSL:when>
               <XSL:when test="regex-group(1)='ETHIOPIC-CHE'">ጭ</XSL:when>
               <XSL:when test="regex-group(1)='ETHIOPIC-CHEE'">ጬ</XSL:when>
               <XSL:when test="regex-group(1)='ETHIOPIC-CHI'">ጪ</XSL:when>
               <XSL:when test="regex-group(1)='ETHIOPIC-CHO'">ጮ</XSL:when>
               <XSL:when test="regex-group(1)='ETHIOPIC-CHU'">ጩ</XSL:when>
               <XSL:when test="regex-group(1)='ETHIOPIC-CHWA'">ጯ</XSL:when>
               <XSL:when test="regex-group(1)='ETHIOPIC-CI'">ቺ</XSL:when>
               <XSL:when test="regex-group(1)='ETHIOPIC-CO'">ቾ</XSL:when>
               <XSL:when test="regex-group(1)='ETHIOPIC-COLON'">፥</XSL:when>
               <XSL:when test="regex-group(1)='ETHIOPIC-COMMA'">፣</XSL:when>
               <XSL:when test="regex-group(1)='ETHIOPIC-CU'">ቹ</XSL:when>
               <XSL:when test="regex-group(1)='ETHIOPIC-CWA'">ቿ</XSL:when>
               <XSL:when test="regex-group(1)='ETHIOPIC-DA'">ደ</XSL:when>
               <XSL:when test="regex-group(1)='ETHIOPIC-DAA'">ዳ</XSL:when>
               <XSL:when test="regex-group(1)='ETHIOPIC-DDA'">ዸ</XSL:when>
               <XSL:when test="regex-group(1)='ETHIOPIC-DDAA'">ዻ</XSL:when>
               <XSL:when test="regex-group(1)='ETHIOPIC-DDE'">ዽ</XSL:when>
               <XSL:when test="regex-group(1)='ETHIOPIC-DDEE'">ዼ</XSL:when>
               <XSL:when test="regex-group(1)='ETHIOPIC-DDI'">ዺ</XSL:when>
               <XSL:when test="regex-group(1)='ETHIOPIC-DDO'">ዾ</XSL:when>
               <XSL:when test="regex-group(1)='ETHIOPIC-DDU'">ዹ</XSL:when>
               <XSL:when test="regex-group(1)='ETHIOPIC-DDWA'">ዿ</XSL:when>
               <XSL:when test="regex-group(1)='ETHIOPIC-DE'">ድ</XSL:when>
               <XSL:when test="regex-group(1)='ETHIOPIC-DEE'">ዴ</XSL:when>
               <XSL:when test="regex-group(1)='ETHIOPIC-DI'">ዲ</XSL:when>
               <XSL:when test="regex-group(1)='ETHIOPIC-DIGIT-EIGHT'">፰</XSL:when>
               <XSL:when test="regex-group(1)='ETHIOPIC-DIGIT-FIVE'">፭</XSL:when>
               <XSL:when test="regex-group(1)='ETHIOPIC-DIGIT-FOUR'">፬</XSL:when>
               <XSL:when test="regex-group(1)='ETHIOPIC-DIGIT-NINE'">፱</XSL:when>
               <XSL:when test="regex-group(1)='ETHIOPIC-DIGIT-ONE'">፩</XSL:when>
               <XSL:when test="regex-group(1)='ETHIOPIC-DIGIT-SEVEN'">፯</XSL:when>
               <XSL:when test="regex-group(1)='ETHIOPIC-DIGIT-SIX'">፮</XSL:when>
               <XSL:when test="regex-group(1)='ETHIOPIC-DIGIT-THREE'">፫</XSL:when>
               <XSL:when test="regex-group(1)='ETHIOPIC-DIGIT-TWO'">፪</XSL:when>
               <XSL:when test="regex-group(1)='ETHIOPIC-DO'">ዶ</XSL:when>
               <XSL:when test="regex-group(1)='ETHIOPIC-DU'">ዱ</XSL:when>
               <XSL:when test="regex-group(1)='ETHIOPIC-DWA'">ዷ</XSL:when>
               <XSL:when test="regex-group(1)='ETHIOPIC-FA'">ፈ</XSL:when>
               <XSL:when test="regex-group(1)='ETHIOPIC-FAA'">ፋ</XSL:when>
               <XSL:when test="regex-group(1)='ETHIOPIC-FE'">ፍ</XSL:when>
               <XSL:when test="regex-group(1)='ETHIOPIC-FEE'">ፌ</XSL:when>
               <XSL:when test="regex-group(1)='ETHIOPIC-FI'">ፊ</XSL:when>
               <XSL:when test="regex-group(1)='ETHIOPIC-FO'">ፎ</XSL:when>
               <XSL:when test="regex-group(1)='ETHIOPIC-FU'">ፉ</XSL:when>
               <XSL:when test="regex-group(1)='ETHIOPIC-FWA'">ፏ</XSL:when>
               <XSL:when test="regex-group(1)='ETHIOPIC-FYA'">ፚ</XSL:when>
               <XSL:when test="regex-group(1)='ETHIOPIC-GA'">ገ</XSL:when>
               <XSL:when test="regex-group(1)='ETHIOPIC-GAA'">ጋ</XSL:when>
               <XSL:when test="regex-group(1)='ETHIOPIC-GE'">ግ</XSL:when>
               <XSL:when test="regex-group(1)='ETHIOPIC-GEE'">ጌ</XSL:when>
               <XSL:when test="regex-group(1)='ETHIOPIC-GEM-MRK'">፟</XSL:when>
               <XSL:when test="regex-group(1)='ETHIOPIC-GGA'">ጘ</XSL:when>
               <XSL:when test="regex-group(1)='ETHIOPIC-GGAA'">ጛ</XSL:when>
               <XSL:when test="regex-group(1)='ETHIOPIC-GGE'">ጝ</XSL:when>
               <XSL:when test="regex-group(1)='ETHIOPIC-GGEE'">ጜ</XSL:when>
               <XSL:when test="regex-group(1)='ETHIOPIC-GGI'">ጚ</XSL:when>
               <XSL:when test="regex-group(1)='ETHIOPIC-GGO'">ጞ</XSL:when>
               <XSL:when test="regex-group(1)='ETHIOPIC-GGU'">ጙ</XSL:when>
               <XSL:when test="regex-group(1)='ETHIOPIC-GGWAA'">ጟ</XSL:when>
               <XSL:when test="regex-group(1)='ETHIOPIC-GI'">ጊ</XSL:when>
               <XSL:when test="regex-group(1)='ETHIOPIC-GLOTL-A'">አ</XSL:when>
               <XSL:when test="regex-group(1)='ETHIOPIC-GLOTL-AA'">ኣ</XSL:when>
               <XSL:when test="regex-group(1)='ETHIOPIC-GLOTL-E'">እ</XSL:when>
               <XSL:when test="regex-group(1)='ETHIOPIC-GLOTL-EE'">ኤ</XSL:when>
               <XSL:when test="regex-group(1)='ETHIOPIC-GLOTL-I'">ኢ</XSL:when>
               <XSL:when test="regex-group(1)='ETHIOPIC-GLOTL-O'">ኦ</XSL:when>
               <XSL:when test="regex-group(1)='ETHIOPIC-GLOTL-U'">ኡ</XSL:when>
               <XSL:when test="regex-group(1)='ETHIOPIC-GLOTL-WA'">ኧ</XSL:when>
               <XSL:when test="regex-group(1)='ETHIOPIC-GO'">ጎ</XSL:when>
               <XSL:when test="regex-group(1)='ETHIOPIC-GOA'">ጏ</XSL:when>
               <XSL:when test="regex-group(1)='ETHIOPIC-GU'">ጉ</XSL:when>
               <XSL:when test="regex-group(1)='ETHIOPIC-GWA'">ጐ</XSL:when>
               <XSL:when test="regex-group(1)='ETHIOPIC-GWAA'">ጓ</XSL:when>
               <XSL:when test="regex-group(1)='ETHIOPIC-GWE'">ጕ</XSL:when>
               <XSL:when test="regex-group(1)='ETHIOPIC-GWEE'">ጔ</XSL:when>
               <XSL:when test="regex-group(1)='ETHIOPIC-GWI'">ጒ</XSL:when>
               <XSL:when test="regex-group(1)='ETHIOPIC-HA'">ሀ</XSL:when>
               <XSL:when test="regex-group(1)='ETHIOPIC-HAA'">ሃ</XSL:when>
               <XSL:when test="regex-group(1)='ETHIOPIC-HE'">ህ</XSL:when>
               <XSL:when test="regex-group(1)='ETHIOPIC-HEE'">ሄ</XSL:when>
               <XSL:when test="regex-group(1)='ETHIOPIC-HHA'">ሐ</XSL:when>
               <XSL:when test="regex-group(1)='ETHIOPIC-HHAA'">ሓ</XSL:when>
               <XSL:when test="regex-group(1)='ETHIOPIC-HHE'">ሕ</XSL:when>
               <XSL:when test="regex-group(1)='ETHIOPIC-HHEE'">ሔ</XSL:when>
               <XSL:when test="regex-group(1)='ETHIOPIC-HHI'">ሒ</XSL:when>
               <XSL:when test="regex-group(1)='ETHIOPIC-HHO'">ሖ</XSL:when>
               <XSL:when test="regex-group(1)='ETHIOPIC-HHU'">ሑ</XSL:when>
               <XSL:when test="regex-group(1)='ETHIOPIC-HHWA'">ሗ</XSL:when>
               <XSL:when test="regex-group(1)='ETHIOPIC-HI'">ሂ</XSL:when>
               <XSL:when test="regex-group(1)='ETHIOPIC-HO'">ሆ</XSL:when>
               <XSL:when test="regex-group(1)='ETHIOPIC-HOA'">ሇ</XSL:when>
               <XSL:when test="regex-group(1)='ETHIOPIC-HU'">ሁ</XSL:when>
               <XSL:when test="regex-group(1)='ETHIOPIC-JA'">ጀ</XSL:when>
               <XSL:when test="regex-group(1)='ETHIOPIC-JAA'">ጃ</XSL:when>
               <XSL:when test="regex-group(1)='ETHIOPIC-JE'">ጅ</XSL:when>
               <XSL:when test="regex-group(1)='ETHIOPIC-JEE'">ጄ</XSL:when>
               <XSL:when test="regex-group(1)='ETHIOPIC-JI'">ጂ</XSL:when>
               <XSL:when test="regex-group(1)='ETHIOPIC-JO'">ጆ</XSL:when>
               <XSL:when test="regex-group(1)='ETHIOPIC-JU'">ጁ</XSL:when>
               <XSL:when test="regex-group(1)='ETHIOPIC-JWA'">ጇ</XSL:when>
               <XSL:when test="regex-group(1)='ETHIOPIC-KA'">ከ</XSL:when>
               <XSL:when test="regex-group(1)='ETHIOPIC-KAA'">ካ</XSL:when>
               <XSL:when test="regex-group(1)='ETHIOPIC-KE'">ክ</XSL:when>
               <XSL:when test="regex-group(1)='ETHIOPIC-KEE'">ኬ</XSL:when>
               <XSL:when test="regex-group(1)='ETHIOPIC-KI'">ኪ</XSL:when>
               <XSL:when test="regex-group(1)='ETHIOPIC-KO'">ኮ</XSL:when>
               <XSL:when test="regex-group(1)='ETHIOPIC-KOA'">ኯ</XSL:when>
               <XSL:when test="regex-group(1)='ETHIOPIC-KU'">ኩ</XSL:when>
               <XSL:when test="regex-group(1)='ETHIOPIC-KWA'">ኰ</XSL:when>
               <XSL:when test="regex-group(1)='ETHIOPIC-KWAA'">ኳ</XSL:when>
               <XSL:when test="regex-group(1)='ETHIOPIC-KWE'">ኵ</XSL:when>
               <XSL:when test="regex-group(1)='ETHIOPIC-KWEE'">ኴ</XSL:when>
               <XSL:when test="regex-group(1)='ETHIOPIC-KWI'">ኲ</XSL:when>
               <XSL:when test="regex-group(1)='ETHIOPIC-KXA'">ኸ</XSL:when>
               <XSL:when test="regex-group(1)='ETHIOPIC-KXAA'">ኻ</XSL:when>
               <XSL:when test="regex-group(1)='ETHIOPIC-KXE'">ኽ</XSL:when>
               <XSL:when test="regex-group(1)='ETHIOPIC-KXEE'">ኼ</XSL:when>
               <XSL:when test="regex-group(1)='ETHIOPIC-KXI'">ኺ</XSL:when>
               <XSL:when test="regex-group(1)='ETHIOPIC-KXO'">ኾ</XSL:when>
               <XSL:when test="regex-group(1)='ETHIOPIC-KXU'">ኹ</XSL:when>
               <XSL:when test="regex-group(1)='ETHIOPIC-KXWA'">ዀ</XSL:when>
               <XSL:when test="regex-group(1)='ETHIOPIC-KXWAA'">ዃ</XSL:when>
               <XSL:when test="regex-group(1)='ETHIOPIC-KXWE'">ዅ</XSL:when>
               <XSL:when test="regex-group(1)='ETHIOPIC-KXWEE'">ዄ</XSL:when>
               <XSL:when test="regex-group(1)='ETHIOPIC-KXWI'">ዂ</XSL:when>
               <XSL:when test="regex-group(1)='ETHIOPIC-LA'">ለ</XSL:when>
               <XSL:when test="regex-group(1)='ETHIOPIC-LAA'">ላ</XSL:when>
               <XSL:when test="regex-group(1)='ETHIOPIC-LE'">ል</XSL:when>
               <XSL:when test="regex-group(1)='ETHIOPIC-LEE'">ሌ</XSL:when>
               <XSL:when test="regex-group(1)='ETHIOPIC-LI'">ሊ</XSL:when>
               <XSL:when test="regex-group(1)='ETHIOPIC-LO'">ሎ</XSL:when>
               <XSL:when test="regex-group(1)='ETHIOPIC-LU'">ሉ</XSL:when>
               <XSL:when test="regex-group(1)='ETHIOPIC-LWA'">ሏ</XSL:when>
               <XSL:when test="regex-group(1)='ETHIOPIC-MA'">መ</XSL:when>
               <XSL:when test="regex-group(1)='ETHIOPIC-MAA'">ማ</XSL:when>
               <XSL:when test="regex-group(1)='ETHIOPIC-ME'">ም</XSL:when>
               <XSL:when test="regex-group(1)='ETHIOPIC-MEE'">ሜ</XSL:when>
               <XSL:when test="regex-group(1)='ETHIOPIC-MI'">ሚ</XSL:when>
               <XSL:when test="regex-group(1)='ETHIOPIC-MO'">ሞ</XSL:when>
               <XSL:when test="regex-group(1)='ETHIOPIC-MU'">ሙ</XSL:when>
               <XSL:when test="regex-group(1)='ETHIOPIC-MWA'">ሟ</XSL:when>
               <XSL:when test="regex-group(1)='ETHIOPIC-MYA'">ፙ</XSL:when>
               <XSL:when test="regex-group(1)='ETHIOPIC-NA'">ነ</XSL:when>
               <XSL:when test="regex-group(1)='ETHIOPIC-NAA'">ና</XSL:when>
               <XSL:when test="regex-group(1)='ETHIOPIC-NE'">ን</XSL:when>
               <XSL:when test="regex-group(1)='ETHIOPIC-NEE'">ኔ</XSL:when>
               <XSL:when test="regex-group(1)='ETHIOPIC-NI'">ኒ</XSL:when>
               <XSL:when test="regex-group(1)='ETHIOPIC-NO'">ኖ</XSL:when>
               <XSL:when test="regex-group(1)='ETHIOPIC-NU'">ኑ</XSL:when>
               <XSL:when test="regex-group(1)='ETHIOPIC-NUM-EIGHTY'">፹</XSL:when>
               <XSL:when test="regex-group(1)='ETHIOPIC-NUM-FIFTY'">፶</XSL:when>
               <XSL:when test="regex-group(1)='ETHIOPIC-NUM-FORTY'">፵</XSL:when>
               <XSL:when test="regex-group(1)='ETHIOPIC-NUM-HUNDRED'">፻</XSL:when>
               <XSL:when test="regex-group(1)='ETHIOPIC-NUM-NINETY'">፺</XSL:when>
               <XSL:when test="regex-group(1)='ETHIOPIC-NUM-SEVENTY'">፸</XSL:when>
               <XSL:when test="regex-group(1)='ETHIOPIC-NUM-SIXTY'">፷</XSL:when>
               <XSL:when test="regex-group(1)='ETHIOPIC-NUM-TEN'">፲</XSL:when>
               <XSL:when test="regex-group(1)='ETHIOPIC-NUM-TEN-THOUSAND'">፼</XSL:when>
               <XSL:when test="regex-group(1)='ETHIOPIC-NUM-THIRTY'">፴</XSL:when>
               <XSL:when test="regex-group(1)='ETHIOPIC-NUM-TWENTY'">፳</XSL:when>
               <XSL:when test="regex-group(1)='ETHIOPIC-NWA'">ኗ</XSL:when>
               <XSL:when test="regex-group(1)='ETHIOPIC-NYA'">ኘ</XSL:when>
               <XSL:when test="regex-group(1)='ETHIOPIC-NYAA'">ኛ</XSL:when>
               <XSL:when test="regex-group(1)='ETHIOPIC-NYE'">ኝ</XSL:when>
               <XSL:when test="regex-group(1)='ETHIOPIC-NYEE'">ኜ</XSL:when>
               <XSL:when test="regex-group(1)='ETHIOPIC-NYI'">ኚ</XSL:when>
               <XSL:when test="regex-group(1)='ETHIOPIC-NYO'">ኞ</XSL:when>
               <XSL:when test="regex-group(1)='ETHIOPIC-NYU'">ኙ</XSL:when>
               <XSL:when test="regex-group(1)='ETHIOPIC-NYWA'">ኟ</XSL:when>
               <XSL:when test="regex-group(1)='ETHIOPIC-PA'">ፐ</XSL:when>
               <XSL:when test="regex-group(1)='ETHIOPIC-PAA'">ፓ</XSL:when>
               <XSL:when test="regex-group(1)='ETHIOPIC-PARAGRAPH'">፨</XSL:when>
               <XSL:when test="regex-group(1)='ETHIOPIC-PE'">ፕ</XSL:when>
               <XSL:when test="regex-group(1)='ETHIOPIC-PEE'">ፔ</XSL:when>
               <XSL:when test="regex-group(1)='ETHIOPIC-PHA'">ጰ</XSL:when>
               <XSL:when test="regex-group(1)='ETHIOPIC-PHAA'">ጳ</XSL:when>
               <XSL:when test="regex-group(1)='ETHIOPIC-PHARGL-A'">ዐ</XSL:when>
               <XSL:when test="regex-group(1)='ETHIOPIC-PHARGL-AA'">ዓ</XSL:when>
               <XSL:when test="regex-group(1)='ETHIOPIC-PHARGL-E'">ዕ</XSL:when>
               <XSL:when test="regex-group(1)='ETHIOPIC-PHARGL-EE'">ዔ</XSL:when>
               <XSL:when test="regex-group(1)='ETHIOPIC-PHARGL-I'">ዒ</XSL:when>
               <XSL:when test="regex-group(1)='ETHIOPIC-PHARGL-O'">ዖ</XSL:when>
               <XSL:when test="regex-group(1)='ETHIOPIC-PHARGL-U'">ዑ</XSL:when>
               <XSL:when test="regex-group(1)='ETHIOPIC-PHE'">ጵ</XSL:when>
               <XSL:when test="regex-group(1)='ETHIOPIC-PHEE'">ጴ</XSL:when>
               <XSL:when test="regex-group(1)='ETHIOPIC-PHI'">ጲ</XSL:when>
               <XSL:when test="regex-group(1)='ETHIOPIC-PHO'">ጶ</XSL:when>
               <XSL:when test="regex-group(1)='ETHIOPIC-PHU'">ጱ</XSL:when>
               <XSL:when test="regex-group(1)='ETHIOPIC-PHWA'">ጷ</XSL:when>
               <XSL:when test="regex-group(1)='ETHIOPIC-PI'">ፒ</XSL:when>
               <XSL:when test="regex-group(1)='ETHIOPIC-PO'">ፖ</XSL:when>
               <XSL:when test="regex-group(1)='ETHIOPIC-PREF-COLON'">፦</XSL:when>
               <XSL:when test="regex-group(1)='ETHIOPIC-PU'">ፑ</XSL:when>
               <XSL:when test="regex-group(1)='ETHIOPIC-PWA'">ፗ</XSL:when>
               <XSL:when test="regex-group(1)='ETHIOPIC-QA'">ቀ</XSL:when>
               <XSL:when test="regex-group(1)='ETHIOPIC-QAA'">ቃ</XSL:when>
               <XSL:when test="regex-group(1)='ETHIOPIC-QE'">ቅ</XSL:when>
               <XSL:when test="regex-group(1)='ETHIOPIC-QEE'">ቄ</XSL:when>
               <XSL:when test="regex-group(1)='ETHIOPIC-QHA'">ቐ</XSL:when>
               <XSL:when test="regex-group(1)='ETHIOPIC-QHAA'">ቓ</XSL:when>
               <XSL:when test="regex-group(1)='ETHIOPIC-QHE'">ቕ</XSL:when>
               <XSL:when test="regex-group(1)='ETHIOPIC-QHEE'">ቔ</XSL:when>
               <XSL:when test="regex-group(1)='ETHIOPIC-QHI'">ቒ</XSL:when>
               <XSL:when test="regex-group(1)='ETHIOPIC-QHO'">ቖ</XSL:when>
               <XSL:when test="regex-group(1)='ETHIOPIC-QHU'">ቑ</XSL:when>
               <XSL:when test="regex-group(1)='ETHIOPIC-QHWA'">ቘ</XSL:when>
               <XSL:when test="regex-group(1)='ETHIOPIC-QHWAA'">ቛ</XSL:when>
               <XSL:when test="regex-group(1)='ETHIOPIC-QHWE'">ቝ</XSL:when>
               <XSL:when test="regex-group(1)='ETHIOPIC-QHWEE'">ቜ</XSL:when>
               <XSL:when test="regex-group(1)='ETHIOPIC-QHWI'">ቚ</XSL:when>
               <XSL:when test="regex-group(1)='ETHIOPIC-QI'">ቂ</XSL:when>
               <XSL:when test="regex-group(1)='ETHIOPIC-QO'">ቆ</XSL:when>
               <XSL:when test="regex-group(1)='ETHIOPIC-QOA'">ቇ</XSL:when>
               <XSL:when test="regex-group(1)='ETHIOPIC-QU'">ቁ</XSL:when>
               <XSL:when test="regex-group(1)='ETHIOPIC-QUESTION-MRK'">፧</XSL:when>
               <XSL:when test="regex-group(1)='ETHIOPIC-QWA'">ቈ</XSL:when>
               <XSL:when test="regex-group(1)='ETHIOPIC-QWAA'">ቋ</XSL:when>
               <XSL:when test="regex-group(1)='ETHIOPIC-QWE'">ቍ</XSL:when>
               <XSL:when test="regex-group(1)='ETHIOPIC-QWEE'">ቌ</XSL:when>
               <XSL:when test="regex-group(1)='ETHIOPIC-QWI'">ቊ</XSL:when>
               <XSL:when test="regex-group(1)='ETHIOPIC-RA'">ረ</XSL:when>
               <XSL:when test="regex-group(1)='ETHIOPIC-RAA'">ራ</XSL:when>
               <XSL:when test="regex-group(1)='ETHIOPIC-RE'">ር</XSL:when>
               <XSL:when test="regex-group(1)='ETHIOPIC-REE'">ሬ</XSL:when>
               <XSL:when test="regex-group(1)='ETHIOPIC-RI'">ሪ</XSL:when>
               <XSL:when test="regex-group(1)='ETHIOPIC-RO'">ሮ</XSL:when>
               <XSL:when test="regex-group(1)='ETHIOPIC-RU'">ሩ</XSL:when>
               <XSL:when test="regex-group(1)='ETHIOPIC-RWA'">ሯ</XSL:when>
               <XSL:when test="regex-group(1)='ETHIOPIC-RYA'">ፘ</XSL:when>
               <XSL:when test="regex-group(1)='ETHIOPIC-SA'">ሰ</XSL:when>
               <XSL:when test="regex-group(1)='ETHIOPIC-SAA'">ሳ</XSL:when>
               <XSL:when test="regex-group(1)='ETHIOPIC-SE'">ስ</XSL:when>
               <XSL:when test="regex-group(1)='ETHIOPIC-SECTION-MRK'">፠</XSL:when>
               <XSL:when test="regex-group(1)='ETHIOPIC-SEE'">ሴ</XSL:when>
               <XSL:when test="regex-group(1)='ETHIOPIC-SEMICOLON'">፤</XSL:when>
               <XSL:when test="regex-group(1)='ETHIOPIC-SHA'">ሸ</XSL:when>
               <XSL:when test="regex-group(1)='ETHIOPIC-SHAA'">ሻ</XSL:when>
               <XSL:when test="regex-group(1)='ETHIOPIC-SHE'">ሽ</XSL:when>
               <XSL:when test="regex-group(1)='ETHIOPIC-SHEE'">ሼ</XSL:when>
               <XSL:when test="regex-group(1)='ETHIOPIC-SHI'">ሺ</XSL:when>
               <XSL:when test="regex-group(1)='ETHIOPIC-SHO'">ሾ</XSL:when>
               <XSL:when test="regex-group(1)='ETHIOPIC-SHU'">ሹ</XSL:when>
               <XSL:when test="regex-group(1)='ETHIOPIC-SHWA'">ሿ</XSL:when>
               <XSL:when test="regex-group(1)='ETHIOPIC-SI'">ሲ</XSL:when>
               <XSL:when test="regex-group(1)='ETHIOPIC-SO'">ሶ</XSL:when>
               <XSL:when test="regex-group(1)='ETHIOPIC-STOP'">።</XSL:when>
               <XSL:when test="regex-group(1)='ETHIOPIC-SU'">ሱ</XSL:when>
               <XSL:when test="regex-group(1)='ETHIOPIC-SWA'">ሷ</XSL:when>
               <XSL:when test="regex-group(1)='ETHIOPIC-SZA'">ሠ</XSL:when>
               <XSL:when test="regex-group(1)='ETHIOPIC-SZAA'">ሣ</XSL:when>
               <XSL:when test="regex-group(1)='ETHIOPIC-SZE'">ሥ</XSL:when>
               <XSL:when test="regex-group(1)='ETHIOPIC-SZEE'">ሤ</XSL:when>
               <XSL:when test="regex-group(1)='ETHIOPIC-SZI'">ሢ</XSL:when>
               <XSL:when test="regex-group(1)='ETHIOPIC-SZO'">ሦ</XSL:when>
               <XSL:when test="regex-group(1)='ETHIOPIC-SZU'">ሡ</XSL:when>
               <XSL:when test="regex-group(1)='ETHIOPIC-SZWA'">ሧ</XSL:when>
               <XSL:when test="regex-group(1)='ETHIOPIC-TA'">ተ</XSL:when>
               <XSL:when test="regex-group(1)='ETHIOPIC-TAA'">ታ</XSL:when>
               <XSL:when test="regex-group(1)='ETHIOPIC-TE'">ት</XSL:when>
               <XSL:when test="regex-group(1)='ETHIOPIC-TEE'">ቴ</XSL:when>
               <XSL:when test="regex-group(1)='ETHIOPIC-THA'">ጠ</XSL:when>
               <XSL:when test="regex-group(1)='ETHIOPIC-THAA'">ጣ</XSL:when>
               <XSL:when test="regex-group(1)='ETHIOPIC-THE'">ጥ</XSL:when>
               <XSL:when test="regex-group(1)='ETHIOPIC-THEE'">ጤ</XSL:when>
               <XSL:when test="regex-group(1)='ETHIOPIC-THI'">ጢ</XSL:when>
               <XSL:when test="regex-group(1)='ETHIOPIC-THO'">ጦ</XSL:when>
               <XSL:when test="regex-group(1)='ETHIOPIC-THU'">ጡ</XSL:when>
               <XSL:when test="regex-group(1)='ETHIOPIC-THWA'">ጧ</XSL:when>
               <XSL:when test="regex-group(1)='ETHIOPIC-TI'">ቲ</XSL:when>
               <XSL:when test="regex-group(1)='ETHIOPIC-TO'">ቶ</XSL:when>
               <XSL:when test="regex-group(1)='ETHIOPIC-TSA'">ጸ</XSL:when>
               <XSL:when test="regex-group(1)='ETHIOPIC-TSAA'">ጻ</XSL:when>
               <XSL:when test="regex-group(1)='ETHIOPIC-TSE'">ጽ</XSL:when>
               <XSL:when test="regex-group(1)='ETHIOPIC-TSEE'">ጼ</XSL:when>
               <XSL:when test="regex-group(1)='ETHIOPIC-TSI'">ጺ</XSL:when>
               <XSL:when test="regex-group(1)='ETHIOPIC-TSO'">ጾ</XSL:when>
               <XSL:when test="regex-group(1)='ETHIOPIC-TSU'">ጹ</XSL:when>
               <XSL:when test="regex-group(1)='ETHIOPIC-TSWA'">ጿ</XSL:when>
               <XSL:when test="regex-group(1)='ETHIOPIC-TU'">ቱ</XSL:when>
               <XSL:when test="regex-group(1)='ETHIOPIC-TWA'">ቷ</XSL:when>
               <XSL:when test="regex-group(1)='ETHIOPIC-TZA'">ፀ</XSL:when>
               <XSL:when test="regex-group(1)='ETHIOPIC-TZAA'">ፃ</XSL:when>
               <XSL:when test="regex-group(1)='ETHIOPIC-TZE'">ፅ</XSL:when>
               <XSL:when test="regex-group(1)='ETHIOPIC-TZEE'">ፄ</XSL:when>
               <XSL:when test="regex-group(1)='ETHIOPIC-TZI'">ፂ</XSL:when>
               <XSL:when test="regex-group(1)='ETHIOPIC-TZO'">ፆ</XSL:when>
               <XSL:when test="regex-group(1)='ETHIOPIC-TZOA'">ፇ</XSL:when>
               <XSL:when test="regex-group(1)='ETHIOPIC-TZU'">ፁ</XSL:when>
               <XSL:when test="regex-group(1)='ETHIOPIC-VA'">ቨ</XSL:when>
               <XSL:when test="regex-group(1)='ETHIOPIC-VAA'">ቫ</XSL:when>
               <XSL:when test="regex-group(1)='ETHIOPIC-VE'">ቭ</XSL:when>
               <XSL:when test="regex-group(1)='ETHIOPIC-VEE'">ቬ</XSL:when>
               <XSL:when test="regex-group(1)='ETHIOPIC-VI'">ቪ</XSL:when>
               <XSL:when test="regex-group(1)='ETHIOPIC-VO'">ቮ</XSL:when>
               <XSL:when test="regex-group(1)='ETHIOPIC-VU'">ቩ</XSL:when>
               <XSL:when test="regex-group(1)='ETHIOPIC-VWA'">ቯ</XSL:when>
               <XSL:when test="regex-group(1)='ETHIOPIC-WA'">ወ</XSL:when>
               <XSL:when test="regex-group(1)='ETHIOPIC-WAA'">ዋ</XSL:when>
               <XSL:when test="regex-group(1)='ETHIOPIC-WE'">ው</XSL:when>
               <XSL:when test="regex-group(1)='ETHIOPIC-WEE'">ዌ</XSL:when>
               <XSL:when test="regex-group(1)='ETHIOPIC-WI'">ዊ</XSL:when>
               <XSL:when test="regex-group(1)='ETHIOPIC-WO'">ዎ</XSL:when>
               <XSL:when test="regex-group(1)='ETHIOPIC-WOA'">ዏ</XSL:when>
               <XSL:when test="regex-group(1)='ETHIOPIC-WORDSPACE'">፡</XSL:when>
               <XSL:when test="regex-group(1)='ETHIOPIC-WU'">ዉ</XSL:when>
               <XSL:when test="regex-group(1)='ETHIOPIC-XA'">ኀ</XSL:when>
               <XSL:when test="regex-group(1)='ETHIOPIC-XAA'">ኃ</XSL:when>
               <XSL:when test="regex-group(1)='ETHIOPIC-XE'">ኅ</XSL:when>
               <XSL:when test="regex-group(1)='ETHIOPIC-XEE'">ኄ</XSL:when>
               <XSL:when test="regex-group(1)='ETHIOPIC-XI'">ኂ</XSL:when>
               <XSL:when test="regex-group(1)='ETHIOPIC-XO'">ኆ</XSL:when>
               <XSL:when test="regex-group(1)='ETHIOPIC-XOA'">ኇ</XSL:when>
               <XSL:when test="regex-group(1)='ETHIOPIC-XU'">ኁ</XSL:when>
               <XSL:when test="regex-group(1)='ETHIOPIC-XWA'">ኈ</XSL:when>
               <XSL:when test="regex-group(1)='ETHIOPIC-XWAA'">ኋ</XSL:when>
               <XSL:when test="regex-group(1)='ETHIOPIC-XWE'">ኍ</XSL:when>
               <XSL:when test="regex-group(1)='ETHIOPIC-XWEE'">ኌ</XSL:when>
               <XSL:when test="regex-group(1)='ETHIOPIC-XWI'">ኊ</XSL:when>
               <XSL:when test="regex-group(1)='ETHIOPIC-YA'">የ</XSL:when>
               <XSL:when test="regex-group(1)='ETHIOPIC-YAA'">ያ</XSL:when>
               <XSL:when test="regex-group(1)='ETHIOPIC-YE'">ይ</XSL:when>
               <XSL:when test="regex-group(1)='ETHIOPIC-YEE'">ዬ</XSL:when>
               <XSL:when test="regex-group(1)='ETHIOPIC-YI'">ዪ</XSL:when>
               <XSL:when test="regex-group(1)='ETHIOPIC-YO'">ዮ</XSL:when>
               <XSL:when test="regex-group(1)='ETHIOPIC-YOA'">ዯ</XSL:when>
               <XSL:when test="regex-group(1)='ETHIOPIC-YU'">ዩ</XSL:when>
               <XSL:when test="regex-group(1)='ETHIOPIC-ZA'">ዘ</XSL:when>
               <XSL:when test="regex-group(1)='ETHIOPIC-ZAA'">ዛ</XSL:when>
               <XSL:when test="regex-group(1)='ETHIOPIC-ZE'">ዝ</XSL:when>
               <XSL:when test="regex-group(1)='ETHIOPIC-ZEE'">ዜ</XSL:when>
               <XSL:when test="regex-group(1)='ETHIOPIC-ZHA'">ዠ</XSL:when>
               <XSL:when test="regex-group(1)='ETHIOPIC-ZHAA'">ዣ</XSL:when>
               <XSL:when test="regex-group(1)='ETHIOPIC-ZHE'">ዥ</XSL:when>
               <XSL:when test="regex-group(1)='ETHIOPIC-ZHEE'">ዤ</XSL:when>
               <XSL:when test="regex-group(1)='ETHIOPIC-ZHI'">ዢ</XSL:when>
               <XSL:when test="regex-group(1)='ETHIOPIC-ZHO'">ዦ</XSL:when>
               <XSL:when test="regex-group(1)='ETHIOPIC-ZHU'">ዡ</XSL:when>
               <XSL:when test="regex-group(1)='ETHIOPIC-ZHWA'">ዧ</XSL:when>
               <XSL:when test="regex-group(1)='ETHIOPIC-ZI'">ዚ</XSL:when>
               <XSL:when test="regex-group(1)='ETHIOPIC-ZO'">ዞ</XSL:when>
               <XSL:when test="regex-group(1)='ETHIOPIC-ZU'">ዙ</XSL:when>
               <XSL:when test="regex-group(1)='ETHIOPIC-ZWA'">ዟ</XSL:when>
               <XSL:when test="regex-group(1)='Eacugr'">Έ</XSL:when>
               <XSL:when test="regex-group(1)='Eacute'">É</XSL:when>
               <XSL:when test="regex-group(1)='Earth'">♁</XSL:when>
               <XSL:when test="regex-group(1)='Ecaron'">Ě</XSL:when>
               <XSL:when test="regex-group(1)='Ecirc'">Ê</XSL:when>
               <XSL:when test="regex-group(1)='Ecy'">Э</XSL:when>
               <XSL:when test="regex-group(1)='Edot'">Ė</XSL:when>
               <XSL:when test="regex-group(1)='Egr'">Ε</XSL:when>
               <XSL:when test="regex-group(1)='Egragr'">Ὲ</XSL:when>
               <XSL:when test="regex-group(1)='Egrave'">È</XSL:when>
               <XSL:when test="regex-group(1)='Emacr'">Ē</XSL:when>
               <XSL:when test="regex-group(1)='Eogon'">Ę</XSL:when>
               <XSL:when test="regex-group(1)='Eragr'">Ἕ</XSL:when>
               <XSL:when test="regex-group(1)='Erggr'">Ἓ</XSL:when>
               <XSL:when test="regex-group(1)='Erougr'">Ἑ</XSL:when>
               <XSL:when test="regex-group(1)='Esagr'">Ἔ</XSL:when>
               <XSL:when test="regex-group(1)='Esggr'">Ἒ</XSL:when>
               <XSL:when test="regex-group(1)='Esmogr'">Ἐ</XSL:when>
               <XSL:when test="regex-group(1)='Euml'">Ë</XSL:when>
               <XSL:when test="regex-group(1)='Fcy'">Ф</XSL:when>
               <XSL:when test="regex-group(1)='Gbreve'">Ğ</XSL:when>
               <XSL:when test="regex-group(1)='Gcedil'">Ģ</XSL:when>
               <XSL:when test="regex-group(1)='Gcirc'">Ĝ</XSL:when>
               <XSL:when test="regex-group(1)='Gcy'">Г</XSL:when>
               <XSL:when test="regex-group(1)='Gdot'">Ġ</XSL:when>
               <XSL:when test="regex-group(1)='Gemini'">♊</XSL:when>
               <XSL:when test="regex-group(1)='Ggr'">Γ</XSL:when>
               <XSL:when test="regex-group(1)='Ghacek'">Ǧ</XSL:when>
               <XSL:when test="regex-group(1)='HARDcy'">Ъ</XSL:when>
               <XSL:when test="regex-group(1)='Hcirc'">Ĥ</XSL:when>
               <XSL:when test="regex-group(1)='Hstrok'">Ħ</XSL:when>
               <XSL:when test="regex-group(1)='IEcy'">Е</XSL:when>
               <XSL:when test="regex-group(1)='IJlig'">Ĳ</XSL:when>
               <XSL:when test="regex-group(1)='IOcy'">Ё</XSL:when>
               <XSL:when test="regex-group(1)='Iacugr'">Ί</XSL:when>
               <XSL:when test="regex-group(1)='Iacute'">Í</XSL:when>
               <XSL:when test="regex-group(1)='Ibreve'">Ĭ</XSL:when>
               <XSL:when test="regex-group(1)='Icirc'">Î</XSL:when>
               <XSL:when test="regex-group(1)='Icy'">И</XSL:when>
               <XSL:when test="regex-group(1)='Idot'">İ</XSL:when>
               <XSL:when test="regex-group(1)='Igr'">Ι</XSL:when>
               <XSL:when test="regex-group(1)='Igragr'">Ὶ</XSL:when>
               <XSL:when test="regex-group(1)='Igrave'">Ì</XSL:when>
               <XSL:when test="regex-group(1)='Imacr'">Ī</XSL:when>
               <XSL:when test="regex-group(1)='Iogon'">Į</XSL:when>
               <XSL:when test="regex-group(1)='Iragr'">Ἵ</XSL:when>
               <XSL:when test="regex-group(1)='Ircgr'">Ἷ</XSL:when>
               <XSL:when test="regex-group(1)='Irggr'">Ἳ</XSL:when>
               <XSL:when test="regex-group(1)='Irougr'">Ἱ</XSL:when>
               <XSL:when test="regex-group(1)='Isagr'">Ἴ</XSL:when>
               <XSL:when test="regex-group(1)='Iscgr'">Ἶ</XSL:when>
               <XSL:when test="regex-group(1)='Isggr'">Ἲ</XSL:when>
               <XSL:when test="regex-group(1)='Ismogr'">Ἰ</XSL:when>
               <XSL:when test="regex-group(1)='Itilde'">Ĩ</XSL:when>
               <XSL:when test="regex-group(1)='Iuml'">Ï</XSL:when>
               <XSL:when test="regex-group(1)='Jcirc'">Ĵ</XSL:when>
               <XSL:when test="regex-group(1)='Jcy'">Й</XSL:when>
               <XSL:when test="regex-group(1)='Jupit'">♃</XSL:when>
               <XSL:when test="regex-group(1)='KHcy'">Х</XSL:when>
               <XSL:when test="regex-group(1)='KHgr'">Χ</XSL:when>
               <XSL:when test="regex-group(1)='KOgr'">Ϟ</XSL:when>
               <XSL:when test="regex-group(1)='Kcedil'">Ķ</XSL:when>
               <XSL:when test="regex-group(1)='Kcy'">К</XSL:when>
               <XSL:when test="regex-group(1)='Kgr'">Κ</XSL:when>
               <XSL:when test="regex-group(1)='LL'">Ỻ</XSL:when>
               <XSL:when test="regex-group(1)='Lacute'">Ĺ</XSL:when>
               <XSL:when test="regex-group(1)='Lbar'">Ɫ</XSL:when>
               <XSL:when test="regex-group(1)='Lcaron'">Ľ</XSL:when>
               <XSL:when test="regex-group(1)='Lcedil'">Ļ</XSL:when>
               <XSL:when test="regex-group(1)='Lcy'">Л</XSL:when>
               <XSL:when test="regex-group(1)='Ldotb'">Ḷ</XSL:when>
               <XSL:when test="regex-group(1)='Leo'">♌</XSL:when>
               <XSL:when test="regex-group(1)='Lgr'">Λ</XSL:when>
               <XSL:when test="regex-group(1)='Libra'">♎</XSL:when>
               <XSL:when test="regex-group(1)='Lmidot'">Ŀ</XSL:when>
               <XSL:when test="regex-group(1)='Lstrok'">Ł</XSL:when>
               <XSL:when test="regex-group(1)='Mars'">♂</XSL:when>
               <XSL:when test="regex-group(1)='Mcy'">М</XSL:when>
               <XSL:when test="regex-group(1)='Merc'">☿</XSL:when>
               <XSL:when test="regex-group(1)='Mgr'">Μ</XSL:when>
               <XSL:when test="regex-group(1)='Moonfirst'">☽</XSL:when>
               <XSL:when test="regex-group(1)='Moonlast'">☾</XSL:when>
               <XSL:when test="regex-group(1)='Nacute'">Ń</XSL:when>
               <XSL:when test="regex-group(1)='Ncaron'">Ň</XSL:when>
               <XSL:when test="regex-group(1)='Ncedil'">Ņ</XSL:when>
               <XSL:when test="regex-group(1)='Ncy'">Н</XSL:when>
               <XSL:when test="regex-group(1)='Ngr'">Ν</XSL:when>
               <XSL:when test="regex-group(1)='Ntilde'">Ñ</XSL:when>
               <XSL:when test="regex-group(1)='OElig'">Œ</XSL:when>
               <XSL:when test="regex-group(1)='OHacugr'">Ώ</XSL:when>
               <XSL:when test="regex-group(1)='OHcirgr'"></XSL:when>
               <XSL:when test="regex-group(1)='OHgr'">Ω</XSL:when>
               <XSL:when test="regex-group(1)='OHgragr'">Ὼ</XSL:when>
               <XSL:when test="regex-group(1)='OHigr'">ῼ</XSL:when>
               <XSL:when test="regex-group(1)='OHragr'">Ὥ</XSL:when>
               <XSL:when test="regex-group(1)='OHraigr'">ᾭ</XSL:when>
               <XSL:when test="regex-group(1)='OHrcgr'">Ὧ</XSL:when>
               <XSL:when test="regex-group(1)='OHrcigr'">ᾯ</XSL:when>
               <XSL:when test="regex-group(1)='OHrggr'">Ὣ</XSL:when>
               <XSL:when test="regex-group(1)='OHrgigr'">ᾫ</XSL:when>
               <XSL:when test="regex-group(1)='OHrigr'">ᾩ</XSL:when>
               <XSL:when test="regex-group(1)='OHrougr'">Ὡ</XSL:when>
               <XSL:when test="regex-group(1)='OHsagr'">Ὤ</XSL:when>
               <XSL:when test="regex-group(1)='OHsaigr'">ᾬ</XSL:when>
               <XSL:when test="regex-group(1)='OHscgr'">Ὦ</XSL:when>
               <XSL:when test="regex-group(1)='OHscigr'">ᾮ</XSL:when>
               <XSL:when test="regex-group(1)='OHsggr'">Ὢ</XSL:when>
               <XSL:when test="regex-group(1)='OHsgigr'">ᾪ</XSL:when>
               <XSL:when test="regex-group(1)='OHsigr'">ᾨ</XSL:when>
               <XSL:when test="regex-group(1)='OHsmogr'">Ὠ</XSL:when>
               <XSL:when test="regex-group(1)='Oacugr'">Ό</XSL:when>
               <XSL:when test="regex-group(1)='Oacute'">Ó</XSL:when>
               <XSL:when test="regex-group(1)='Ocirc'">Ô</XSL:when>
               <XSL:when test="regex-group(1)='Ocy'">О</XSL:when>
               <XSL:when test="regex-group(1)='Odblac'">Ő</XSL:when>
               <XSL:when test="regex-group(1)='Ogr'">Ο</XSL:when>
               <XSL:when test="regex-group(1)='Ogragr'">Ὸ</XSL:when>
               <XSL:when test="regex-group(1)='Ograve'">Ò</XSL:when>
               <XSL:when test="regex-group(1)='Omacr'">Ō</XSL:when>
               <XSL:when test="regex-group(1)='Oragr'">Ὅ</XSL:when>
               <XSL:when test="regex-group(1)='Orggr'">Ὃ</XSL:when>
               <XSL:when test="regex-group(1)='Orougr'">Ὁ</XSL:when>
               <XSL:when test="regex-group(1)='Osagr'">Ὄ</XSL:when>
               <XSL:when test="regex-group(1)='Osggr'">Ὂ</XSL:when>
               <XSL:when test="regex-group(1)='Oslash'">Ø</XSL:when>
               <XSL:when test="regex-group(1)='Osmogr'">Ὀ</XSL:when>
               <XSL:when test="regex-group(1)='Otilde'">Õ</XSL:when>
               <XSL:when test="regex-group(1)='Ouml'">Ö</XSL:when>
               <XSL:when test="regex-group(1)='PHgr'">Φ</XSL:when>
               <XSL:when test="regex-group(1)='PSgr'">Ψ</XSL:when>
               <XSL:when test="regex-group(1)='Pcy'">П</XSL:when>
               <XSL:when test="regex-group(1)='Pgr'">Π</XSL:when>
               <XSL:when test="regex-group(1)='Pisces'">♓</XSL:when>
               <XSL:when test="regex-group(1)='Prime'">″</XSL:when>
               <XSL:when test="regex-group(1)='Qbar'">Ꝗ</XSL:when>
               <XSL:when test="regex-group(1)='R'">Ꝛ</XSL:when>
               <XSL:when test="regex-group(1)='Racute'">Ŕ</XSL:when>
               <XSL:when test="regex-group(1)='Rcaron'">Ř</XSL:when>
               <XSL:when test="regex-group(1)='Rcedil'">Ŗ</XSL:when>
               <XSL:when test="regex-group(1)='Rcy'">Р</XSL:when>
               <XSL:when test="regex-group(1)='Rgr'">Ρ</XSL:when>
               <XSL:when test="regex-group(1)='Rrougr'">Ῥ</XSL:when>
               <XSL:when test="regex-group(1)='SAMgr'">Ϡ</XSL:when>
               <XSL:when test="regex-group(1)='SHCHcy'">Щ</XSL:when>
               <XSL:when test="regex-group(1)='SHcy'">Ш</XSL:when>
               <XSL:when test="regex-group(1)='SOFTcy'">Ь</XSL:when>
               <XSL:when test="regex-group(1)='STgr'">Ϛ</XSL:when>
               <XSL:when test="regex-group(1)='Sacute'">Ś</XSL:when>
               <XSL:when test="regex-group(1)='Sagitt'">♐</XSL:when>
               <XSL:when test="regex-group(1)='Saturn'">♄</XSL:when>
               <XSL:when test="regex-group(1)='Scaron'">Š</XSL:when>
               <XSL:when test="regex-group(1)='Scedil'">Ş</XSL:when>
               <XSL:when test="regex-group(1)='Scirc'">Ŝ</XSL:when>
               <XSL:when test="regex-group(1)='Scorp'">♏</XSL:when>
               <XSL:when test="regex-group(1)='Scy'">С</XSL:when>
               <XSL:when test="regex-group(1)='Sgr'">Σ</XSL:when>
               <XSL:when test="regex-group(1)='Slungr'">Ϲ</XSL:when>
               <XSL:when test="regex-group(1)='Sun'">☉</XSL:when>
               <XSL:when test="regex-group(1)='THAT'">Ꝧ</XSL:when>
               <XSL:when test="regex-group(1)='THORN'">Þ</XSL:when>
               <XSL:when test="regex-group(1)='THgr'">Θ</XSL:when>
               <XSL:when test="regex-group(1)='TScy'">Ц</XSL:when>
               <XSL:when test="regex-group(1)='Taurus'">♉</XSL:when>
               <XSL:when test="regex-group(1)='Tcaron'">Ť</XSL:when>
               <XSL:when test="regex-group(1)='Tcedil'">Ţ</XSL:when>
               <XSL:when test="regex-group(1)='Tcy'">Т</XSL:when>
               <XSL:when test="regex-group(1)='Tgr'">Τ</XSL:when>
               <XSL:when test="regex-group(1)='Tstrok'">Ŧ</XSL:when>
               <XSL:when test="regex-group(1)='Uacugr'">Ύ</XSL:when>
               <XSL:when test="regex-group(1)='Uacute'">Ú</XSL:when>
               <XSL:when test="regex-group(1)='Ubreve'">Ŭ</XSL:when>
               <XSL:when test="regex-group(1)='Ucirc'">Û</XSL:when>
               <XSL:when test="regex-group(1)='Ucirgr'"></XSL:when>
               <XSL:when test="regex-group(1)='Ucy'">У</XSL:when>
               <XSL:when test="regex-group(1)='Udblac'">Ű</XSL:when>
               <XSL:when test="regex-group(1)='Udotb'">Ụ</XSL:when>
               <XSL:when test="regex-group(1)='Ugr'">Υ</XSL:when>
               <XSL:when test="regex-group(1)='Ugragr'">Ὺ</XSL:when>
               <XSL:when test="regex-group(1)='Ugrave'">Ù</XSL:when>
               <XSL:when test="regex-group(1)='Umacr'">Ū</XSL:when>
               <XSL:when test="regex-group(1)='Uogon'">Ų</XSL:when>
               <XSL:when test="regex-group(1)='Uragr'">Ὕ</XSL:when>
               <XSL:when test="regex-group(1)='Urcgr'">Ὗ</XSL:when>
               <XSL:when test="regex-group(1)='Urggr'">Ὓ</XSL:when>
               <XSL:when test="regex-group(1)='Uring'">Ů</XSL:when>
               <XSL:when test="regex-group(1)='Urougr'">Ὑ</XSL:when>
               <XSL:when test="regex-group(1)='Utilde'">Ũ</XSL:when>
               <XSL:when test="regex-group(1)='Uuml'">Ü</XSL:when>
               <XSL:when test="regex-group(1)='Vcy'">В</XSL:when>
               <XSL:when test="regex-group(1)='Venus'">♀</XSL:when>
               <XSL:when test="regex-group(1)='Verbar'">‖</XSL:when>
               <XSL:when test="regex-group(1)='Virgo'">♍</XSL:when>
               <XSL:when test="regex-group(1)='Vstroke'">Ꝟ</XSL:when>
               <XSL:when test="regex-group(1)='W'">Ỽ</XSL:when>
               <XSL:when test="regex-group(1)='WYN'">Ƿ</XSL:when>
               <XSL:when test="regex-group(1)='Wcirc'">Ŵ</XSL:when>
               <XSL:when test="regex-group(1)='Xbar'">𐆖</XSL:when>
               <XSL:when test="regex-group(1)='Xgr'">Ξ</XSL:when>
               <XSL:when test="regex-group(1)='Y'">Ỿ</XSL:when>
               <XSL:when test="regex-group(1)='YAcy'">Я</XSL:when>
               <XSL:when test="regex-group(1)='YOGH'">Ȝ</XSL:when>
               <XSL:when test="regex-group(1)='YUcy'">Ю</XSL:when>
               <XSL:when test="regex-group(1)='Yacute'">Ý</XSL:when>
               <XSL:when test="regex-group(1)='Ycirc'">Ŷ</XSL:when>
               <XSL:when test="regex-group(1)='Ycy'">Ы</XSL:when>
               <XSL:when test="regex-group(1)='Yhook'">Ƴ</XSL:when>
               <XSL:when test="regex-group(1)='Yuml'">Ÿ</XSL:when>
               <XSL:when test="regex-group(1)='ZHcy'">Ж</XSL:when>
               <XSL:when test="regex-group(1)='Zacute'">Ź</XSL:when>
               <XSL:when test="regex-group(1)='Zcaron'">Ž</XSL:when>
               <XSL:when test="regex-group(1)='Zcy'">З</XSL:when>
               <XSL:when test="regex-group(1)='Zdot'">Ż</XSL:when>
               <XSL:when test="regex-group(1)='Zgr'">Ζ</XSL:when>
               <XSL:when test="regex-group(1)='aacugr'">ά</XSL:when>
               <XSL:when test="regex-group(1)='aacute'">á</XSL:when>
               <XSL:when test="regex-group(1)='aaigr'">ᾴ</XSL:when>
               <XSL:when test="regex-group(1)='abCON'">Ꝯ</XSL:when>
               <XSL:when test="regex-group(1)='abPER'">Ꝑ</XSL:when>
               <XSL:when test="regex-group(1)='abPRO'">Ꝓ</XSL:when>
               <XSL:when test="regex-group(1)='abQUOD'">Ꝙ</XSL:when>
               <XSL:when test="regex-group(1)='abRUM'">ꝶ</XSL:when>
               <XSL:when test="regex-group(1)='abcon'">ꝯ</XSL:when>
               <XSL:when test="regex-group(1)='abis'">ꝭ</XSL:when>
               <XSL:when test="regex-group(1)='abper'">ꝑ</XSL:when>
               <XSL:when test="regex-group(1)='abpr'">⅌</XSL:when>
               <XSL:when test="regex-group(1)='abprecipi'">🝟</XSL:when>
               <XSL:when test="regex-group(1)='abpro'">ꝓ</XSL:when>
               <XSL:when test="regex-group(1)='abquod'">ꝙ</XSL:when>
               <XSL:when test="regex-group(1)='abreve'">ă</XSL:when>
               <XSL:when test="regex-group(1)='absubli'">🝞</XSL:when>
               <XSL:when test="regex-group(1)='abus'">ꝰ</XSL:when>
               <XSL:when test="regex-group(1)='acigr'">ᾷ</XSL:when>
               <XSL:when test="regex-group(1)='acirc'">â</XSL:when>
               <XSL:when test="regex-group(1)='acirgr'">ᾶ</XSL:when>
               <XSL:when test="regex-group(1)='acy'">а</XSL:when>
               <XSL:when test="regex-group(1)='aelig'">æ</XSL:when>
               <XSL:when test="regex-group(1)='afortis'">🜅</XSL:when>
               <XSL:when test="regex-group(1)='agigr'">ᾲ</XSL:when>
               <XSL:when test="regex-group(1)='agr'">α</XSL:when>
               <XSL:when test="regex-group(1)='agragr'">ὰ</XSL:when>
               <XSL:when test="regex-group(1)='agrave'">à</XSL:when>
               <XSL:when test="regex-group(1)='ahacek'">ǎ</XSL:when>
               <XSL:when test="regex-group(1)='aiotgr'">ᾳ</XSL:when>
               <XSL:when test="regex-group(1)='air'">🜁</XSL:when>
               <XSL:when test="regex-group(1)='alef'">א</XSL:when>
               <XSL:when test="regex-group(1)='alembic'">🝪</XSL:when>
               <XSL:when test="regex-group(1)='aleph'">ℵ</XSL:when>
               <XSL:when test="regex-group(1)='amacr'">ā</XSL:when>
               <XSL:when test="regex-group(1)='anchor'">⚓</XSL:when>
               <XSL:when test="regex-group(1)='and'">∧</XSL:when>
               <XSL:when test="regex-group(1)='ang'">∠</XSL:when>
               <XSL:when test="regex-group(1)='ang90'">∟</XSL:when>
               <XSL:when test="regex-group(1)='angsph'">∢</XSL:when>
               <XSL:when test="regex-group(1)='angst'">Å</XSL:when>
               <XSL:when test="regex-group(1)='aogon'">ą</XSL:when>
               <XSL:when test="regex-group(1)='ap'">≈</XSL:when>
               <XSL:when test="regex-group(1)='arab-qaf'">ٯ</XSL:when>
               <XSL:when test="regex-group(1)='aragr'">ἅ</XSL:when>
               <XSL:when test="regex-group(1)='araigr'">ᾅ</XSL:when>
               <XSL:when test="regex-group(1)='arc'"></XSL:when>
               <XSL:when test="regex-group(1)='arcgr'">ἇ</XSL:when>
               <XSL:when test="regex-group(1)='arcigr'">ᾇ</XSL:when>
               <XSL:when test="regex-group(1)='aregis'">🜆</XSL:when>
               <XSL:when test="regex-group(1)='arggr'">ἃ</XSL:when>
               <XSL:when test="regex-group(1)='argigr'">ᾃ</XSL:when>
               <XSL:when test="regex-group(1)='arigr'">ᾁ</XSL:when>
               <XSL:when test="regex-group(1)='aring'">å</XSL:when>
               <XSL:when test="regex-group(1)='arougr'">ἁ</XSL:when>
               <XSL:when test="regex-group(1)='arsenic'">🜺</XSL:when>
               <XSL:when test="regex-group(1)='asagr'">ἄ</XSL:when>
               <XSL:when test="regex-group(1)='asaigr'">ᾄ</XSL:when>
               <XSL:when test="regex-group(1)='ascgr'">ἆ</XSL:when>
               <XSL:when test="regex-group(1)='ascigr'">ᾆ</XSL:when>
               <XSL:when test="regex-group(1)='asggr'">ἂ</XSL:when>
               <XSL:when test="regex-group(1)='asgigr'">ᾂ</XSL:when>
               <XSL:when test="regex-group(1)='ashes'">🝗</XSL:when>
               <XSL:when test="regex-group(1)='asigr'">ᾀ</XSL:when>
               <XSL:when test="regex-group(1)='asmogr'">ἀ</XSL:when>
               <XSL:when test="regex-group(1)='ast'">*</XSL:when>
               <XSL:when test="regex-group(1)='atilde'">ã</XSL:when>
               <XSL:when test="regex-group(1)='auml'">ä</XSL:when>
               <XSL:when test="regex-group(1)='ayin'">ע</XSL:when>
               <XSL:when test="regex-group(1)='barline'">𝄀</XSL:when>
               <XSL:when test="regex-group(1)='bcy'">б</XSL:when>
               <XSL:when test="regex-group(1)='becaus'">∵</XSL:when>
               <XSL:when test="regex-group(1)='bernou'">ℬ</XSL:when>
               <XSL:when test="regex-group(1)='bet'">ב</XSL:when>
               <XSL:when test="regex-group(1)='bgr'">β</XSL:when>
               <XSL:when test="regex-group(1)='biglsquo'">❛</XSL:when>
               <XSL:when test="regex-group(1)='blank'">␣</XSL:when>
               <XSL:when test="regex-group(1)='blk12'">▒</XSL:when>
               <XSL:when test="regex-group(1)='blk14'">░</XSL:when>
               <XSL:when test="regex-group(1)='blk34'">▓</XSL:when>
               <XSL:when test="regex-group(1)='block'">█</XSL:when>
               <XSL:when test="regex-group(1)='bsol'">\</XSL:when>
               <XSL:when test="regex-group(1)='bstrok'">ƀ</XSL:when>
               <XSL:when test="regex-group(1)='bull'">•</XSL:when>
               <XSL:when test="regex-group(1)='cacute'">ć</XSL:when>
               <XSL:when test="regex-group(1)='cap'">∩</XSL:when>
               <XSL:when test="regex-group(1)='caret'">⁁</XSL:when>
               <XSL:when test="regex-group(1)='ccaron'">č</XSL:when>
               <XSL:when test="regex-group(1)='ccedil'">ç</XSL:when>
               <XSL:when test="regex-group(1)='ccirc'">ĉ</XSL:when>
               <XSL:when test="regex-group(1)='cclef'">𝄡</XSL:when>
               <XSL:when test="regex-group(1)='cdot'">ċ</XSL:when>
               <XSL:when test="regex-group(1)='cent'">¢</XSL:when>
               <XSL:when test="regex-group(1)='chcy'">ч</XSL:when>
               <XSL:when test="regex-group(1)='check'">✓</XSL:when>
               <XSL:when test="regex-group(1)='chirho'">☧</XSL:when>
               <XSL:when test="regex-group(1)='cinnabar1'">🜓</XSL:when>
               <XSL:when test="regex-group(1)='cinnabar3'">🜭</XSL:when>
               <XSL:when test="regex-group(1)='cir'">○</XSL:when>
               <XSL:when test="regex-group(1)='circle'">◯</XSL:when>
               <XSL:when test="regex-group(1)='circled-0'">⓪</XSL:when>
               <XSL:when test="regex-group(1)='circled-1'">①</XSL:when>
               <XSL:when test="regex-group(1)='circled-10'">⑩</XSL:when>
               <XSL:when test="regex-group(1)='circled-11'">⑪</XSL:when>
               <XSL:when test="regex-group(1)='circled-12'">⑫</XSL:when>
               <XSL:when test="regex-group(1)='circled-2'">②</XSL:when>
               <XSL:when test="regex-group(1)='circled-3'">③</XSL:when>
               <XSL:when test="regex-group(1)='circled-4'">④</XSL:when>
               <XSL:when test="regex-group(1)='circled-5'">⑤</XSL:when>
               <XSL:when test="regex-group(1)='circled-6'">⑥</XSL:when>
               <XSL:when test="regex-group(1)='circled-7'">⑦</XSL:when>
               <XSL:when test="regex-group(1)='circled-8'">⑧</XSL:when>
               <XSL:when test="regex-group(1)='circled-9'">⑨</XSL:when>
               <XSL:when test="regex-group(1)='circledplus'">⊕</XSL:when>
               <XSL:when test="regex-group(1)='circledtimes'">⊗</XSL:when>
               <XSL:when test="regex-group(1)='closeup'">⁐</XSL:when>
               <XSL:when test="regex-group(1)='clubs'">♣</XSL:when>
               <XSL:when test="regex-group(1)='cmacr'"></XSL:when>
               <XSL:when test="regex-group(1)='cmbSTROKEover'">̶</XSL:when>
               <XSL:when test="regex-group(1)='cmbVIRGULEover'"≯</XSL:when>
               <XSL:when test="regex-group(1)='cmbVLINEover'">⃒</XSL:when>
               <XSL:when test="regex-group(1)='cmba2a'">ᷞ</XSL:when>
               <XSL:when test="regex-group(1)='cmbaa'">ͣ</XSL:when>
               <XSL:when test="regex-group(1)='cmbacute'">́</XSL:when>
               <XSL:when test="regex-group(1)='cmbbreve'">̆</XSL:when>
               <XSL:when test="regex-group(1)='cmbbslashover'">⃥</XSL:when>
               <XSL:when test="regex-group(1)='cmbcaron'">̌</XSL:when>
               <XSL:when test="regex-group(1)='cmbcedil'">̧</XSL:when>
               <XSL:when test="regex-group(1)='cmbcirc'">̂</XSL:when>
               <XSL:when test="regex-group(1)='cmbcommaa'">̓</XSL:when>
               <XSL:when test="regex-group(1)='cmbdblac'">̋</XSL:when>
               <XSL:when test="regex-group(1)='cmbdblvlineover'">⃦</XSL:when>
               <XSL:when test="regex-group(1)='cmbdot'">̇</XSL:when>
               <XSL:when test="regex-group(1)='cmbdotb'">̣</XSL:when>
               <XSL:when test="regex-group(1)='cmbenclcirover'">⃝</XSL:when>
               <XSL:when test="regex-group(1)='cmbenclsquover'">⃞</XSL:when>
               <XSL:when test="regex-group(1)='cmbencltriover'">⃤</XSL:when>
               <XSL:when test="regex-group(1)='cmbgrave'">̀</XSL:when>
               <XSL:when test="regex-group(1)='cmbia'">ͥ</XSL:when>
               <XSL:when test="regex-group(1)='cmbibreve'">̑</XSL:when>
               <XSL:when test="regex-group(1)='cmblowvertline'">̩</XSL:when>
               <XSL:when test="regex-group(1)='cmbmacr'">̄</XSL:when>
               <XSL:when test="regex-group(1)='cmbogon'">̨</XSL:when>
               <XSL:when test="regex-group(1)='cmbogona'">᷎</XSL:when>
               <XSL:when test="regex-group(1)='cmbperispo'">͂</XSL:when>
               <XSL:when test="regex-group(1)='cmbrcomma'">̔</XSL:when>
               <XSL:when test="regex-group(1)='cmbring'">̊</XSL:when>
               <XSL:when test="regex-group(1)='cmbstrokeover'">̵</XSL:when>
               <XSL:when test="regex-group(1)='cmbtilde'">̃</XSL:when>
               <XSL:when test="regex-group(1)='cmbtildeover'">̴</XSL:when>
               <XSL:when test="regex-group(1)='cmbuml'">̈</XSL:when>
               <XSL:when test="regex-group(1)='cmbvirguleover'">̷</XSL:when>
               <XSL:when test="regex-group(1)='cmbvlineover'">⃓</XSL:when>
               <XSL:when test="regex-group(1)='cmbx'">̽</XSL:when>
               <XSL:when test="regex-group(1)='colon'">:</XSL:when>
               <XSL:when test="regex-group(1)='comma'">,</XSL:when>
               <XSL:when test="regex-group(1)='commat'">@</XSL:when>
               <XSL:when test="regex-group(1)='commonTime-adagio'">𝄴</XSL:when>
               <XSL:when test="regex-group(1)='compfn'">∘</XSL:when>
               <XSL:when test="regex-group(1)='cong'">≅</XSL:when>
               <XSL:when test="regex-group(1)='conint'">∮</XSL:when>
               <XSL:when test="regex-group(1)='conjunction'">☌</XSL:when>
               <XSL:when test="regex-group(1)='copy'">©</XSL:when>
               <XSL:when test="regex-group(1)='copysr'">℗</XSL:when>
               <XSL:when test="regex-group(1)='cup'">∪</XSL:when>
               <XSL:when test="regex-group(1)='curren'">¤</XSL:when>
               <XSL:when test="regex-group(1)='dagger'">†</XSL:when>
               <XSL:when test="regex-group(1)='dalet'">ד</XSL:when>
               <XSL:when test="regex-group(1)='darga'">֧</XSL:when>
               <XSL:when test="regex-group(1)='darr'">↓</XSL:when>
               <XSL:when test="regex-group(1)='dash'">‐</XSL:when>
               <XSL:when test="regex-group(1)='dcaron'">ď</XSL:when>
               <XSL:when test="regex-group(1)='dcy'">д</XSL:when>
               <XSL:when test="regex-group(1)='ddiple'">⸖</XSL:when>
               <XSL:when test="regex-group(1)='ddotb'">ḍ</XSL:when>
               <XSL:when test="regex-group(1)='deg'">°</XSL:when>
               <XSL:when test="regex-group(1)='delta'">ẟ</XSL:when>
               <XSL:when test="regex-group(1)='dgr'">δ</XSL:when>
               <XSL:when test="regex-group(1)='diamond'">◆</XSL:when>
               <XSL:when test="regex-group(1)='diams'">♦</XSL:when>
               <XSL:when test="regex-group(1)='die1'">⚀</XSL:when>
               <XSL:when test="regex-group(1)='die2'">⚁</XSL:when>
               <XSL:when test="regex-group(1)='die3'">⚂</XSL:when>
               <XSL:when test="regex-group(1)='die4'">⚃</XSL:when>
               <XSL:when test="regex-group(1)='die5'">⚄</XSL:when>
               <XSL:when test="regex-group(1)='die6'">⚅</XSL:when>
               <XSL:when test="regex-group(1)='diggr'">ϝ</XSL:when>
               <XSL:when test="regex-group(1)='dindx'">☟</XSL:when>
               <XSL:when test="regex-group(1)='divide'">÷</XSL:when>
               <XSL:when test="regex-group(1)='dlcrop'">⌍</XSL:when>
               <XSL:when test="regex-group(1)='dollar'">$</XSL:when>
               <XSL:when test="regex-group(1)='drcrop'">⌌</XSL:when>
               <XSL:when test="regex-group(1)='dstrok'">đ</XSL:when>
               <XSL:when test="regex-group(1)='dtri'">▿</XSL:when>
               <XSL:when test="regex-group(1)='dtridot'">⸪</XSL:when>
               <XSL:when test="regex-group(1)='dtrif'">▾</XSL:when>
               <XSL:when test="regex-group(1)='eacugr'">έ</XSL:when>
               <XSL:when test="regex-group(1)='eacute'">é</XSL:when>
               <XSL:when test="regex-group(1)='earth'">🜃</XSL:when>
               <XSL:when test="regex-group(1)='ebreve'">ĕ</XSL:when>
               <XSL:when test="regex-group(1)='ecaron'">ě</XSL:when>
               <XSL:when test="regex-group(1)='ecirc'">ê</XSL:when>
               <XSL:when test="regex-group(1)='ecy'">э</XSL:when>
               <XSL:when test="regex-group(1)='edot'">ė</XSL:when>
               <XSL:when test="regex-group(1)='eeacugr'">ή</XSL:when>
               <XSL:when test="regex-group(1)='eeaigr'">ῄ</XSL:when>
               <XSL:when test="regex-group(1)='eecigr'">ῇ</XSL:when>
               <XSL:when test="regex-group(1)='eecirgr'">ῆ</XSL:when>
               <XSL:when test="regex-group(1)='eegigr'">ῂ</XSL:when>
               <XSL:when test="regex-group(1)='eegr'">η</XSL:when>
               <XSL:when test="regex-group(1)='eegragr'">ὴ</XSL:when>
               <XSL:when test="regex-group(1)='eeiotgr'">ῃ</XSL:when>
               <XSL:when test="regex-group(1)='eeragr'">ἥ</XSL:when>
               <XSL:when test="regex-group(1)='eeraigr'">ᾕ</XSL:when>
               <XSL:when test="regex-group(1)='eercgr'">ἧ</XSL:when>
               <XSL:when test="regex-group(1)='eercigr'">ᾗ</XSL:when>
               <XSL:when test="regex-group(1)='eerggr'">ἣ</XSL:when>
               <XSL:when test="regex-group(1)='eergigr'">ᾓ</XSL:when>
               <XSL:when test="regex-group(1)='eerigr'">ᾑ</XSL:when>
               <XSL:when test="regex-group(1)='eerougr'">ἡ</XSL:when>
               <XSL:when test="regex-group(1)='eesagr'">ἤ</XSL:when>
               <XSL:when test="regex-group(1)='eesaigr'">ᾔ</XSL:when>
               <XSL:when test="regex-group(1)='eescgr'">ἦ</XSL:when>
               <XSL:when test="regex-group(1)='eescigr'">ᾖ</XSL:when>
               <XSL:when test="regex-group(1)='eesggr'">ἢ</XSL:when>
               <XSL:when test="regex-group(1)='eesgigr'">ᾒ</XSL:when>
               <XSL:when test="regex-group(1)='eesigr'">ᾐ</XSL:when>
               <XSL:when test="regex-group(1)='eesmogr'">ἠ</XSL:when>
               <XSL:when test="regex-group(1)='egr'">ε</XSL:when>
               <XSL:when test="regex-group(1)='egragr'">ὲ</XSL:when>
               <XSL:when test="regex-group(1)='egrave'">è</XSL:when>
               <XSL:when test="regex-group(1)='emacr'">ē</XSL:when>
               <XSL:when test="regex-group(1)='emsp'"> </XSL:when>
               <XSL:when test="regex-group(1)='emsp13'"> </XSL:when>
               <XSL:when test="regex-group(1)='emsp14'"> </XSL:when>
               <XSL:when test="regex-group(1)='eng'">ŋ</XSL:when>
               <XSL:when test="regex-group(1)='ensp'"> </XSL:when>
               <XSL:when test="regex-group(1)='eogon'">ę</XSL:when>
               <XSL:when test="regex-group(1)='equals'">=</XSL:when>
               <XSL:when test="regex-group(1)='equiv'">≡</XSL:when>
               <XSL:when test="regex-group(1)='eragr'">ἕ</XSL:when>
               <XSL:when test="regex-group(1)='erggr'">ἓ</XSL:when>
               <XSL:when test="regex-group(1)='erougr'">ἑ</XSL:when>
               <XSL:when test="regex-group(1)='esagr'">ἔ</XSL:when>
               <XSL:when test="regex-group(1)='esggr'">ἒ</XSL:when>
               <XSL:when test="regex-group(1)='esmogr'">ἐ</XSL:when>
               <XSL:when test="regex-group(1)='eth'">ð</XSL:when>
               <XSL:when test="regex-group(1)='etnahta'">֑</XSL:when>
               <XSL:when test="regex-group(1)='euml'">ë</XSL:when>
               <XSL:when test="regex-group(1)='excl'">!</XSL:when>
               <XSL:when test="regex-group(1)='exist'">∃</XSL:when>
               <XSL:when test="regex-group(1)='fclef'">𝄢</XSL:when>
               <XSL:when test="regex-group(1)='fcy'">ф</XSL:when>
               <XSL:when test="regex-group(1)='fermata'">𝄐</XSL:when>
               <XSL:when test="regex-group(1)='fermatab'">𝄑</XSL:when>
               <XSL:when test="regex-group(1)='ffilig'">ﬃ</XSL:when>
               <XSL:when test="regex-group(1)='fflig'">ﬀ</XSL:when>
               <XSL:when test="regex-group(1)='ffllig'">ﬄ</XSL:when>
               <XSL:when test="regex-group(1)='filig'">ﬁ</XSL:when>
               <XSL:when test="regex-group(1)='finalkaf'">ך</XSL:when>
               <XSL:when test="regex-group(1)='finalmem'">ם</XSL:when>
               <XSL:when test="regex-group(1)='finalnun'">ן</XSL:when>
               <XSL:when test="regex-group(1)='finalpe'">ף</XSL:when>
               <XSL:when test="regex-group(1)='finaltsadi'">ץ</XSL:when>
               <XSL:when test="regex-group(1)='fire'">🜂</XSL:when>
               <XSL:when test="regex-group(1)='fivedot'">⁙</XSL:when>
               <XSL:when test="regex-group(1)='flat'">♭</XSL:when>
               <XSL:when test="regex-group(1)='fleurdelys'">⚜</XSL:when>
               <XSL:when test="regex-group(1)='fllig'">ﬂ</XSL:when>
               <XSL:when test="regex-group(1)='flower'">❀</XSL:when>
               <XSL:when test="regex-group(1)='flowerf'">✿</XSL:when>
               <XSL:when test="regex-group(1)='fnof'">ƒ</XSL:when>
               <XSL:when test="regex-group(1)='forall'">∀</XSL:when>
               <XSL:when test="regex-group(1)='frac12'">½</XSL:when>
               <XSL:when test="regex-group(1)='frac13'">⅓</XSL:when>
               <XSL:when test="regex-group(1)='frac14'">¼</XSL:when>
               <XSL:when test="regex-group(1)='frac15'">⅕</XSL:when>
               <XSL:when test="regex-group(1)='frac16'">⅙</XSL:when>
               <XSL:when test="regex-group(1)='frac18'">⅛</XSL:when>
               <XSL:when test="regex-group(1)='frac23'">⅔</XSL:when>
               <XSL:when test="regex-group(1)='frac25'">⅖</XSL:when>
               <XSL:when test="regex-group(1)='frac34'">¾</XSL:when>
               <XSL:when test="regex-group(1)='frac35'">⅗</XSL:when>
               <XSL:when test="regex-group(1)='frac38'">⅜</XSL:when>
               <XSL:when test="regex-group(1)='frac45'">⅘</XSL:when>
               <XSL:when test="regex-group(1)='frac56'">⅚</XSL:when>
               <XSL:when test="regex-group(1)='frac58'">⅝</XSL:when>
               <XSL:when test="regex-group(1)='frac78'">⅞</XSL:when>
               <XSL:when test="regex-group(1)='gacute'">ǵ</XSL:when>
               <XSL:when test="regex-group(1)='gbreve'">ğ</XSL:when>
               <XSL:when test="regex-group(1)='gcirc'">ĝ</XSL:when>
               <XSL:when test="regex-group(1)='gclef'">𝄞</XSL:when>
               <XSL:when test="regex-group(1)='gcy'">г</XSL:when>
               <XSL:when test="regex-group(1)='gdot'">ġ</XSL:when>
               <XSL:when test="regex-group(1)='ge'">≥</XSL:when>
               <XSL:when test="regex-group(1)='geoprop'">∺</XSL:when>
               <XSL:when test="regex-group(1)='geresh'">֜</XSL:when>
               <XSL:when test="regex-group(1)='ggr'">γ</XSL:when>
               <XSL:when test="regex-group(1)='ghacek'">ǧ</XSL:when>
               <XSL:when test="regex-group(1)='gimel'">ג</XSL:when>
               <XSL:when test="regex-group(1)='hairsp'"> </XSL:when>
               <XSL:when test="regex-group(1)='hamilt'">ℋ</XSL:when>
               <XSL:when test="regex-group(1)='hardcy'">ъ</XSL:when>
               <XSL:when test="regex-group(1)='hcirc'">ĥ</XSL:when>
               <XSL:when test="regex-group(1)='hcolon'">׃</XSL:when>
               <XSL:when test="regex-group(1)='he'">ה</XSL:when>
               <XSL:when test="regex-group(1)='hearts'">♥</XSL:when>
               <XSL:when test="regex-group(1)='hellip'">…</XSL:when>
               <XSL:when test="regex-group(1)='het'">ח</XSL:when>
               <XSL:when test="regex-group(1)='horbar'">―</XSL:when>
               <XSL:when test="regex-group(1)='hstrok'">ħ</XSL:when>
               <XSL:when test="regex-group(1)='hybull'">⁃</XSL:when>
               <XSL:when test="regex-group(1)='hyphen'">-</XSL:when>
               <XSL:when test="regex-group(1)='iacugr'">ί</XSL:when>
               <XSL:when test="regex-group(1)='iacute'">í</XSL:when>
               <XSL:when test="regex-group(1)='iadgr'">ΐ</XSL:when>
               <XSL:when test="regex-group(1)='ibreve'">ĭ</XSL:when>
               <XSL:when test="regex-group(1)='icdgr'">ῗ</XSL:when>
               <XSL:when test="regex-group(1)='icirc'">î</XSL:when>
               <XSL:when test="regex-group(1)='icirgr'">ῖ</XSL:when>
               <XSL:when test="regex-group(1)='icy'">и</XSL:when>
               <XSL:when test="regex-group(1)='iecy'">е</XSL:when>
               <XSL:when test="regex-group(1)='iexcl'">¡</XSL:when>
               <XSL:when test="regex-group(1)='iff'">⇔</XSL:when>
               <XSL:when test="regex-group(1)='igdgr'">ῒ</XSL:when>
               <XSL:when test="regex-group(1)='igr'">ι</XSL:when>
               <XSL:when test="regex-group(1)='igragr'">ὶ</XSL:when>
               <XSL:when test="regex-group(1)='igrave'">ì</XSL:when>
               <XSL:when test="regex-group(1)='ijlig'">ĳ</XSL:when>
               <XSL:when test="regex-group(1)='imacr'">ī</XSL:when>
               <XSL:when test="regex-group(1)='incare'">℅</XSL:when>
               <XSL:when test="regex-group(1)='infin'">∞</XSL:when>
               <XSL:when test="regex-group(1)='inodot'">ı</XSL:when>
               <XSL:when test="regex-group(1)='insul-D'">Ꝺ</XSL:when>
               <XSL:when test="regex-group(1)='insul-F'">Ꝼ</XSL:when>
               <XSL:when test="regex-group(1)='insul-G'">Ᵹ</XSL:when>
               <XSL:when test="regex-group(1)='insul-R'">Ꞃ</XSL:when>
               <XSL:when test="regex-group(1)='insul-S'">Ꞅ</XSL:when>
               <XSL:when test="regex-group(1)='insul-T'">Ꞇ</XSL:when>
               <XSL:when test="regex-group(1)='insul-d'">ꝺ</XSL:when>
               <XSL:when test="regex-group(1)='insul-f'">ꝼ</XSL:when>
               <XSL:when test="regex-group(1)='insul-g'">ᵹ</XSL:when>
               <XSL:when test="regex-group(1)='insul-r'">ꞃ</XSL:when>
               <XSL:when test="regex-group(1)='insul-s'">ꞅ</XSL:when>
               <XSL:when test="regex-group(1)='insul-t'">ꞇ</XSL:when>
               <XSL:when test="regex-group(1)='int'">∫</XSL:when>
               <XSL:when test="regex-group(1)='iocy'">ё</XSL:when>
               <XSL:when test="regex-group(1)='iogon'">į</XSL:when>
               <XSL:when test="regex-group(1)='iquest'">¿</XSL:when>
               <XSL:when test="regex-group(1)='iragr'">ἵ</XSL:when>
               <XSL:when test="regex-group(1)='ircgr'">ἷ</XSL:when>
               <XSL:when test="regex-group(1)='irggr'">ἳ</XSL:when>
               <XSL:when test="regex-group(1)='irougr'">ἱ</XSL:when>
               <XSL:when test="regex-group(1)='isagr'">ἴ</XSL:when>
               <XSL:when test="regex-group(1)='iscgr'">ἶ</XSL:when>
               <XSL:when test="regex-group(1)='isggr'">ἲ</XSL:when>
               <XSL:when test="regex-group(1)='isin'">∊</XSL:when>
               <XSL:when test="regex-group(1)='ismogr'">ἰ</XSL:when>
               <XSL:when test="regex-group(1)='itilde'">ĩ</XSL:when>
               <XSL:when test="regex-group(1)='iuml'">ï</XSL:when>
               <XSL:when test="regex-group(1)='jcirc'">ĵ</XSL:when>
               <XSL:when test="regex-group(1)='jcy'">й</XSL:when>
               <XSL:when test="regex-group(1)='kaf'">כ</XSL:when>
               <XSL:when test="regex-group(1)='kcedil'">ķ</XSL:when>
               <XSL:when test="regex-group(1)='kcy'">к</XSL:when>
               <XSL:when test="regex-group(1)='keraia'">ʹ</XSL:when>
               <XSL:when test="regex-group(1)='kgr'">κ</XSL:when>
               <XSL:when test="regex-group(1)='kgreen'">ĸ</XSL:when>
               <XSL:when test="regex-group(1)='khcy'">х</XSL:when>
               <XSL:when test="regex-group(1)='khgr'">χ</XSL:when>
               <XSL:when test="regex-group(1)='kogr'">ϟ</XSL:when>
               <XSL:when test="regex-group(1)='lArr'">⇐</XSL:when>
               <XSL:when test="regex-group(1)='lacute'">ĺ</XSL:when>
               <XSL:when test="regex-group(1)='lagran'">ℒ</XSL:when>
               <XSL:when test="regex-group(1)='lamed'">ל</XSL:when>
               <XSL:when test="regex-group(1)='lang'">〈</XSL:when>
               <XSL:when test="regex-group(1)='langle'">⦣</XSL:when>
               <XSL:when test="regex-group(1)='laquo'">«</XSL:when>
               <XSL:when test="regex-group(1)='larr'">←</XSL:when>
               <XSL:when test="regex-group(1)='latcross'">✝</XSL:when>
               <XSL:when test="regex-group(1)='lazyS'">∽</XSL:when>
               <XSL:when test="regex-group(1)='lbar'">ɫ</XSL:when>
               <XSL:when test="regex-group(1)='lbrace'">{</XSL:when>
               <XSL:when test="regex-group(1)='lcaron'">ľ</XSL:when>
               <XSL:when test="regex-group(1)='lcedil'">ļ</XSL:when>
               <XSL:when test="regex-group(1)='lcy'">л</XSL:when>
               <XSL:when test="regex-group(1)='ldotb'">ḷ</XSL:when>
               <XSL:when test="regex-group(1)='ldquo'">“</XSL:when>
               <XSL:when test="regex-group(1)='ldquor'">„</XSL:when>
               <XSL:when test="regex-group(1)='le'">≤</XSL:when>
               <XSL:when test="regex-group(1)='lgr'">λ</XSL:when>
               <XSL:when test="regex-group(1)='lhblk'">▄</XSL:when>
               <XSL:when test="regex-group(1)='lindx'">☜</XSL:when>
               <XSL:when test="regex-group(1)='lkeraia'">͵</XSL:when>
               <XSL:when test="regex-group(1)='ll'">ỻ</XSL:when>
               <XSL:when test="regex-group(1)='lmidot'">ŀ</XSL:when>
               <XSL:when test="regex-group(1)='lowast'">∗</XSL:when>
               <XSL:when test="regex-group(1)='lowbar'">_</XSL:when>
               <XSL:when test="regex-group(1)='loz'">◊</XSL:when>
               <XSL:when test="regex-group(1)='lozf'">✦</XSL:when>
               <XSL:when test="regex-group(1)='lpar'">(</XSL:when>
               <XSL:when test="regex-group(1)='lpara'">⁋</XSL:when>
               <XSL:when test="regex-group(1)='lrepeat'">𝄆</XSL:when>
               <XSL:when test="regex-group(1)='lsemicol'">⁏</XSL:when>
               <XSL:when test="regex-group(1)='lsqb'">[</XSL:when>
               <XSL:when test="regex-group(1)='lsquo'">‘</XSL:when>
               <XSL:when test="regex-group(1)='lsquor'">‚</XSL:when>
               <XSL:when test="regex-group(1)='lstrok'">ł</XSL:when>
               <XSL:when test="regex-group(1)='ltri'">◃</XSL:when>
               <XSL:when test="regex-group(1)='ltrif'">◂</XSL:when>
               <XSL:when test="regex-group(1)='mahapakh'">֤</XSL:when>
               <XSL:when test="regex-group(1)='malt'">✠</XSL:when>
               <XSL:when test="regex-group(1)='marker'">▮</XSL:when>
               <XSL:when test="regex-group(1)='mcy'">м</XSL:when>
               <XSL:when test="regex-group(1)='mdash'">—</XSL:when>
               <XSL:when test="regex-group(1)='mem'">מ</XSL:when>
               <XSL:when test="regex-group(1)='merkha'">֥</XSL:when>
               <XSL:when test="regex-group(1)='mgr'">μ</XSL:when>
               <XSL:when test="regex-group(1)='micro'">µ</XSL:when>
               <XSL:when test="regex-group(1)='middot'">·</XSL:when>
               <XSL:when test="regex-group(1)='minus'">−</XSL:when>
               <XSL:when test="regex-group(1)='mnplus'">∓</XSL:when>
               <XSL:when test="regex-group(1)='munah'">֣</XSL:when>
               <XSL:when test="regex-group(1)='musicBrace'">𝄔</XSL:when>
               <XSL:when test="regex-group(1)='musicBracket'">𝄕</XSL:when>
               <XSL:when test="regex-group(1)='nabla'">∇</XSL:when>
               <XSL:when test="regex-group(1)='nacute'">ń</XSL:when>
               <XSL:when test="regex-group(1)='napos'">ŉ</XSL:when>
               <XSL:when test="regex-group(1)='natur'">♮</XSL:when>
               <XSL:when test="regex-group(1)='nbsp'"> </XSL:when>
               <XSL:when test="regex-group(1)='ncaron'">ň</XSL:when>
               <XSL:when test="regex-group(1)='ncedil'">ņ</XSL:when>
               <XSL:when test="regex-group(1)='ncy'">н</XSL:when>
               <XSL:when test="regex-group(1)='ndash'">–</XSL:when>
               <XSL:when test="regex-group(1)='ne'">≠</XSL:when>
               <XSL:when test="regex-group(1)='ngr'">ν</XSL:when>
               <XSL:when test="regex-group(1)='ni'">∍</XSL:when>
               <XSL:when test="regex-group(1)='night'">🝯</XSL:when>
               <XSL:when test="regex-group(1)='nitre'">🜕</XSL:when>
               <XSL:when test="regex-group(1)='nldr'">‥</XSL:when>
               <XSL:when test="regex-group(1)='northnode'">☊</XSL:when>
               <XSL:when test="regex-group(1)='not'">¬</XSL:when>
               <XSL:when test="regex-group(1)='noteEighth'">𝅘𝅥𝅮</XSL:when>
               <XSL:when test="regex-group(1)='noteHalf'">𝅗𝅥</XSL:when>
               <XSL:when test="regex-group(1)='noteQuarter'">𝅘𝅥</XSL:when>
               <XSL:when test="regex-group(1)='noteWhole'">𝅝</XSL:when>
               <XSL:when test="regex-group(1)='notebreve'">𝆸</XSL:when>
               <XSL:when test="regex-group(1)='notecrotchet'">𝆺𝅥</XSL:when>
               <XSL:when test="regex-group(1)='notelarge'">𝆶</XSL:when>
               <XSL:when test="regex-group(1)='notelong'">𝆷</XSL:when>
               <XSL:when test="regex-group(1)='noteminim'">𝆹𝅥</XSL:when>
               <XSL:when test="regex-group(1)='notequaver'">𝆺𝅥𝅮</XSL:when>
               <XSL:when test="regex-group(1)='notesemibreve'">𝆹</XSL:when>
               <XSL:when test="regex-group(1)='notesemiquaver'">𝆺𝅥𝅯</XSL:when>
               <XSL:when test="regex-group(1)='notin'">∉</XSL:when>
               <XSL:when test="regex-group(1)='ntilde'">ñ</XSL:when>
               <XSL:when test="regex-group(1)='num'">#</XSL:when>
               <XSL:when test="regex-group(1)='numero'">№</XSL:when>
               <XSL:when test="regex-group(1)='numsp'"> </XSL:when>
               <XSL:when test="regex-group(1)='nun'">נ</XSL:when>
               <XSL:when test="regex-group(1)='oacugr'">ό</XSL:when>
               <XSL:when test="regex-group(1)='oacute'">ó</XSL:when>
               <XSL:when test="regex-group(1)='obelus'">⸓</XSL:when>
               <XSL:when test="regex-group(1)='obreve'">ŏ</XSL:when>
               <XSL:when test="regex-group(1)='ocirc'">ô</XSL:when>
               <XSL:when test="regex-group(1)='ocy'">о</XSL:when>
               <XSL:when test="regex-group(1)='odblac'">ő</XSL:when>
               <XSL:when test="regex-group(1)='oelig'">œ</XSL:when>
               <XSL:when test="regex-group(1)='ogr'">ο</XSL:when>
               <XSL:when test="regex-group(1)='ogragr'">ὸ</XSL:when>
               <XSL:when test="regex-group(1)='ograve'">ò</XSL:when>
               <XSL:when test="regex-group(1)='ohacek'">ǒ</XSL:when>
               <XSL:when test="regex-group(1)='ohacugr'">ώ</XSL:when>
               <XSL:when test="regex-group(1)='ohaigr'">ῴ</XSL:when>
               <XSL:when test="regex-group(1)='ohcigr'">ῷ</XSL:when>
               <XSL:when test="regex-group(1)='ohcirgr'">ῶ</XSL:when>
               <XSL:when test="regex-group(1)='ohgigr'">ῲ</XSL:when>
               <XSL:when test="regex-group(1)='ohgr'">ω</XSL:when>
               <XSL:when test="regex-group(1)='ohgragr'">ὼ</XSL:when>
               <XSL:when test="regex-group(1)='ohigr'">ῳ</XSL:when>
               <XSL:when test="regex-group(1)='ohkact'"></XSL:when>
               <XSL:when test="regex-group(1)='ohm'">Ω</XSL:when>
               <XSL:when test="regex-group(1)='ohragr'">ὥ</XSL:when>
               <XSL:when test="regex-group(1)='ohraigr'">ᾥ</XSL:when>
               <XSL:when test="regex-group(1)='ohrcgr'">ὧ</XSL:when>
               <XSL:when test="regex-group(1)='ohrcigr'">ᾧ</XSL:when>
               <XSL:when test="regex-group(1)='ohrggr'">ὣ</XSL:when>
               <XSL:when test="regex-group(1)='ohrgigr'">ᾣ</XSL:when>
               <XSL:when test="regex-group(1)='ohrigr'">ᾡ</XSL:when>
               <XSL:when test="regex-group(1)='ohrougr'">ὡ</XSL:when>
               <XSL:when test="regex-group(1)='ohsagr'">ὤ</XSL:when>
               <XSL:when test="regex-group(1)='ohsaigr'">ᾤ</XSL:when>
               <XSL:when test="regex-group(1)='ohscgr'">ὦ</XSL:when>
               <XSL:when test="regex-group(1)='ohscigr'">ᾦ</XSL:when>
               <XSL:when test="regex-group(1)='ohsggr'">ὢ</XSL:when>
               <XSL:when test="regex-group(1)='ohsgigr'">ᾢ</XSL:when>
               <XSL:when test="regex-group(1)='ohsigr'">ᾠ</XSL:when>
               <XSL:when test="regex-group(1)='ohsmogr'">ὠ</XSL:when>
               <XSL:when test="regex-group(1)='oil'">🝆</XSL:when>
               <XSL:when test="regex-group(1)='omacr'">ō</XSL:when>
               <XSL:when test="regex-group(1)='opposition'">☍</XSL:when>
               <XSL:when test="regex-group(1)='or'">∨</XSL:when>
               <XSL:when test="regex-group(1)='oragr'">ὅ</XSL:when>
               <XSL:when test="regex-group(1)='order'">ℴ</XSL:when>
               <XSL:when test="regex-group(1)='ordf'">ª</XSL:when>
               <XSL:when test="regex-group(1)='ordm'">º</XSL:when>
               <XSL:when test="regex-group(1)='orggr'">ὃ</XSL:when>
               <XSL:when test="regex-group(1)='orougr'">ὁ</XSL:when>
               <XSL:when test="regex-group(1)='orpiment'">🜽</XSL:when>
               <XSL:when test="regex-group(1)='osagr'">ὄ</XSL:when>
               <XSL:when test="regex-group(1)='osggr'">ὂ</XSL:when>
               <XSL:when test="regex-group(1)='oslash'">ø</XSL:when>
               <XSL:when test="regex-group(1)='osmogr'">ὀ</XSL:when>
               <XSL:when test="regex-group(1)='otilde'">õ</XSL:when>
               <XSL:when test="regex-group(1)='ouml'">ö</XSL:when>
               <XSL:when test="regex-group(1)='ounce'">℥</XSL:when>
               <XSL:when test="regex-group(1)='par'">∥</XSL:when>
               <XSL:when test="regex-group(1)='para'">¶</XSL:when>
               <XSL:when test="regex-group(1)='part'">∂</XSL:when>
               <XSL:when test="regex-group(1)='pashta'">֙</XSL:when>
               <XSL:when test="regex-group(1)='pcy'">п</XSL:when>
               <XSL:when test="regex-group(1)='pe'">פ</XSL:when>
               <XSL:when test="regex-group(1)='percnt'">%</XSL:when>
               <XSL:when test="regex-group(1)='period'">.</XSL:when>
               <XSL:when test="regex-group(1)='permil'">‰</XSL:when>
               <XSL:when test="regex-group(1)='perp'">⊥</XSL:when>
               <XSL:when test="regex-group(1)='pgr'">π</XSL:when>
               <XSL:when test="regex-group(1)='pgrave'"></XSL:when>
               <XSL:when test="regex-group(1)='phgr'">φ</XSL:when>
               <XSL:when test="regex-group(1)='phmmat'">ℳ</XSL:when>
               <XSL:when test="regex-group(1)='plus'">+</XSL:when>
               <XSL:when test="regex-group(1)='plusmn'">±</XSL:when>
               <XSL:when test="regex-group(1)='potash'">🝘</XSL:when>
               <XSL:when test="regex-group(1)='pound'">£</XSL:when>
               <XSL:when test="regex-group(1)='prime'">′</XSL:when>
               <XSL:when test="regex-group(1)='prop'">∝</XSL:when>
               <XSL:when test="regex-group(1)='proportion'">∷</XSL:when>
               <XSL:when test="regex-group(1)='psgr'">ψ</XSL:when>
               <XSL:when test="regex-group(1)='puncsp'"> </XSL:when>
               <XSL:when test="regex-group(1)='purify'">🝣</XSL:when>
               <XSL:when test="regex-group(1)='qacute'"></XSL:when>
               <XSL:when test="regex-group(1)='qbar'">ꝗ</XSL:when>
               <XSL:when test="regex-group(1)='qmgr'">;</XSL:when>
               <XSL:when test="regex-group(1)='qof'">ק</XSL:when>
               <XSL:when test="regex-group(1)='quaddot'">⸬</XSL:when>
               <XSL:when test="regex-group(1)='quest'">?</XSL:when>
               <XSL:when test="regex-group(1)='quicklime'">🝁</XSL:when>
               <XSL:when test="regex-group(1)='r'">ꝛ</XSL:when>
               <XSL:when test="regex-group(1)='rArr'">⇒</XSL:when>
               <XSL:when test="regex-group(1)='racute'">ŕ</XSL:when>
               <XSL:when test="regex-group(1)='radic'">√</XSL:when>
               <XSL:when test="regex-group(1)='rang'">〉</XSL:when>
               <XSL:when test="regex-group(1)='raquo'">»</XSL:when>
               <XSL:when test="regex-group(1)='rarr'">→</XSL:when>
               <XSL:when test="regex-group(1)='ratio'">∶</XSL:when>
               <XSL:when test="regex-group(1)='rayedSun'">☼</XSL:when>
               <XSL:when test="regex-group(1)='rbrace'">}</XSL:when>
               <XSL:when test="regex-group(1)='rcaron'">ř</XSL:when>
               <XSL:when test="regex-group(1)='rcedil'">ŗ</XSL:when>
               <XSL:when test="regex-group(1)='rcy'">р</XSL:when>
               <XSL:when test="regex-group(1)='rdquo'">”</XSL:when>
               <XSL:when test="regex-group(1)='rect'">▭</XSL:when>
               <XSL:when test="regex-group(1)='reg'">®</XSL:when>
               <XSL:when test="regex-group(1)='resh'">ר</XSL:when>
               <XSL:when test="regex-group(1)='resp'">℟</XSL:when>
               <XSL:when test="regex-group(1)='restbreve'">𝇃</XSL:when>
               <XSL:when test="regex-group(1)='restcrotchet'">𝇆</XSL:when>
               <XSL:when test="regex-group(1)='restlarge'">𝇁</XSL:when>
               <XSL:when test="regex-group(1)='restlong'">𝇂</XSL:when>
               <XSL:when test="regex-group(1)='restminim'">𝇅</XSL:when>
               <XSL:when test="regex-group(1)='restsemibreve'">𝇄</XSL:when>
               <XSL:when test="regex-group(1)='retort'">🝭</XSL:when>
               <XSL:when test="regex-group(1)='revC'">Ↄ</XSL:when>
               <XSL:when test="regex-group(1)='revc'">ↄ</XSL:when>
               <XSL:when test="regex-group(1)='revia'">֗</XSL:when>
               <XSL:when test="regex-group(1)='rgr'">ρ</XSL:when>
               <XSL:when test="regex-group(1)='rindx'">☞</XSL:when>
               <XSL:when test="regex-group(1)='rn10000'">ↂ</XSL:when>
               <XSL:when test="regex-group(1)='rn100000'">ↈ</XSL:when>
               <XSL:when test="regex-group(1)='rn5000'">ↁ</XSL:when>
               <XSL:when test="regex-group(1)='rn50000'">ↇ</XSL:when>
               <XSL:when test="regex-group(1)='rpar'">)</XSL:when>
               <XSL:when test="regex-group(1)='rrepeat'">𝄇</XSL:when>
               <XSL:when test="regex-group(1)='rrougr'">ῥ</XSL:when>
               <XSL:when test="regex-group(1)='rsqb'">]</XSL:when>
               <XSL:when test="regex-group(1)='rsquo'">’</XSL:when>
               <XSL:when test="regex-group(1)='rtri'">▹</XSL:when>
               <XSL:when test="regex-group(1)='rtrif'">▸</XSL:when>
               <XSL:when test="regex-group(1)='rx'">℞</XSL:when>
               <XSL:when test="regex-group(1)='s'">ſ</XSL:when>
               <XSL:when test="regex-group(1)='sacute'">ś</XSL:when>
               <XSL:when test="regex-group(1)='salarmon'">🜹</XSL:when>
               <XSL:when test="regex-group(1)='salt'">🜔</XSL:when>
               <XSL:when test="regex-group(1)='saltgemme'">🜘</XSL:when>
               <XSL:when test="regex-group(1)='saltire'">☓</XSL:when>
               <XSL:when test="regex-group(1)='samekh'">ס</XSL:when>
               <XSL:when test="regex-group(1)='samgr'">ϡ</XSL:when>
               <XSL:when test="regex-group(1)='scaron'">š</XSL:when>
               <XSL:when test="regex-group(1)='scedil'">ş</XSL:when>
               <XSL:when test="regex-group(1)='schwa'">ə</XSL:when>
               <XSL:when test="regex-group(1)='scirc'">ŝ</XSL:when>
               <XSL:when test="regex-group(1)='scruple'">℈</XSL:when>
               <XSL:when test="regex-group(1)='scy'">с</XSL:when>
               <XSL:when test="regex-group(1)='sect'">§</XSL:when>
               <XSL:when test="regex-group(1)='semi'">;</XSL:when>
               <XSL:when test="regex-group(1)='semisextile'">⚺</XSL:when>
               <XSL:when test="regex-group(1)='sext'">✶</XSL:when>
               <XSL:when test="regex-group(1)='sextile'">⚹</XSL:when>
               <XSL:when test="regex-group(1)='sfgr'">ς</XSL:when>
               <XSL:when test="regex-group(1)='sgr'">σ</XSL:when>
               <XSL:when test="regex-group(1)='sharp'">♯</XSL:when>
               <XSL:when test="regex-group(1)='shchcy'">щ</XSL:when>
               <XSL:when test="regex-group(1)='shcy'">ш</XSL:when>
               <XSL:when test="regex-group(1)='shin'">ש</XSL:when>
               <XSL:when test="regex-group(1)='shy'">­</XSL:when>
               <XSL:when test="regex-group(1)='sim'">∼</XSL:when>
               <XSL:when test="regex-group(1)='sime'">≃</XSL:when>
               <XSL:when test="regex-group(1)='skull'">💀</XSL:when>
               <XSL:when test="regex-group(1)='slungr'">ϲ</XSL:when>
               <XSL:when test="regex-group(1)='slur'">𝅷𝅷ᴗ</XSL:when>
               <XSL:when test="regex-group(1)='softcy'">ь</XSL:when>
               <XSL:when test="regex-group(1)='sol'">/</XSL:when>
               <XSL:when test="regex-group(1)='southnode'">☋</XSL:when>
               <XSL:when test="regex-group(1)='spades'">♠</XSL:when>
               <XSL:when test="regex-group(1)='spcDash'">╌</XSL:when>
               <XSL:when test="regex-group(1)='spcacute'">´</XSL:when>
               <XSL:when test="regex-group(1)='spcbreve'">˘</XSL:when>
               <XSL:when test="regex-group(1)='spccaron'">ˇ</XSL:when>
               <XSL:when test="regex-group(1)='spccedil'">¸</XSL:when>
               <XSL:when test="regex-group(1)='spccirc'">^</XSL:when>
               <XSL:when test="regex-group(1)='spccommaa'">᾿</XSL:when>
               <XSL:when test="regex-group(1)='spcdblac'">˝</XSL:when>
               <XSL:when test="regex-group(1)='spcdot'">˙</XSL:when>
               <XSL:when test="regex-group(1)='spcgrave'">`</XSL:when>
               <XSL:when test="regex-group(1)='spcibreve'"></XSL:when>
               <XSL:when test="regex-group(1)='spclowvertline'">ˌ</XSL:when>
               <XSL:when test="regex-group(1)='spcmacr'">¯</XSL:when>
               <XSL:when test="regex-group(1)='spcogon'">˛</XSL:when>
               <XSL:when test="regex-group(1)='spcperispo'">῀</XSL:when>
               <XSL:when test="regex-group(1)='spcrcomma'">῾</XSL:when>
               <XSL:when test="regex-group(1)='spcring'">˚</XSL:when>
               <XSL:when test="regex-group(1)='spctilde'">˜</XSL:when>
               <XSL:when test="regex-group(1)='spcuml'">¨</XSL:when>
               <XSL:when test="regex-group(1)='spcx'"></XSL:when>
               <XSL:when test="regex-group(1)='square'">□</XSL:when>
               <XSL:when test="regex-group(1)='squf'">■</XSL:when>
               <XSL:when test="regex-group(1)='star'">⋆</XSL:when>
               <XSL:when test="regex-group(1)='starf'">★</XSL:when>
               <XSL:when test="regex-group(1)='starw'">☆</XSL:when>
               <XSL:when test="regex-group(1)='stgr'">ϛ</XSL:when>
               <XSL:when test="regex-group(1)='sub'">⊂</XSL:when>
               <XSL:when test="regex-group(1)='sube'">⊆</XSL:when>
               <XSL:when test="regex-group(1)='subplus'">₊</XSL:when>
               <XSL:when test="regex-group(1)='sulphur'">🜍</XSL:when>
               <XSL:when test="regex-group(1)='sung'">♩</XSL:when>
               <XSL:when test="regex-group(1)='sup'">⊃</XSL:when>
               <XSL:when test="regex-group(1)='sup1'">¹</XSL:when>
               <XSL:when test="regex-group(1)='sup2'">²</XSL:when>
               <XSL:when test="regex-group(1)='sup3'">³</XSL:when>
               <XSL:when test="regex-group(1)='supe'">⊇</XSL:when>
               <XSL:when test="regex-group(1)='syri-qaph'">ܩ</XSL:when>
               <XSL:when test="regex-group(1)='szlig'">ß</XSL:when>
               <XSL:when test="regex-group(1)='target'">⌖</XSL:when>
               <XSL:when test="regex-group(1)='tartar'">🜿</XSL:when>
               <XSL:when test="regex-group(1)='tav'">ת</XSL:when>
               <XSL:when test="regex-group(1)='tcaron'">ť</XSL:when>
               <XSL:when test="regex-group(1)='tcedil'">ţ</XSL:when>
               <XSL:when test="regex-group(1)='tcy'">т</XSL:when>
               <XSL:when test="regex-group(1)='tdot'">⃛</XSL:when>
               <XSL:when test="regex-group(1)='telrec'">⌕</XSL:when>
               <XSL:when test="regex-group(1)='tet'">ט</XSL:when>
               <XSL:when test="regex-group(1)='tgr'">τ</XSL:when>
               <XSL:when test="regex-group(1)='that'">ꝧ</XSL:when>
               <XSL:when test="regex-group(1)='there4'">∴</XSL:when>
               <XSL:when test="regex-group(1)='thgr'">θ</XSL:when>
               <XSL:when test="regex-group(1)='thinsp'"> </XSL:when>
               <XSL:when test="regex-group(1)='thorn'">þ</XSL:when>
               <XSL:when test="regex-group(1)='thscrgr'">ϑ</XSL:when>
               <XSL:when test="regex-group(1)='timeimperf-prolatimperf'">𝇋</XSL:when>
               <XSL:when test="regex-group(1)='timeimperf-prolatimperf-rev'">𝇌</XSL:when>
               <XSL:when test="regex-group(1)='timeimperf-prolatimperf-rev-str'">𝇎</XSL:when>
               <XSL:when test="regex-group(1)='timeimperf-prolatimperf-str'">𝇍</XSL:when>
               <XSL:when test="regex-group(1)='timeimperf-prolatperf'">𝇊</XSL:when>
               <XSL:when test="regex-group(1)='timeperf-prolatimperf'">𝇈</XSL:when>
               <XSL:when test="regex-group(1)='timeperf-prolatperf'">𝇇</XSL:when>
               <XSL:when test="regex-group(1)='times'">×</XSL:when>
               <XSL:when test="regex-group(1)='tipeha'">֖</XSL:when>
               <XSL:when test="regex-group(1)='tprime'">‴</XSL:when>
               <XSL:when test="regex-group(1)='trade'">™</XSL:when>
               <XSL:when test="regex-group(1)='tridot'">⸫</XSL:when>
               <XSL:when test="regex-group(1)='tristar'">⁂</XSL:when>
               <XSL:when test="regex-group(1)='triwdot'">◬</XSL:when>
               <XSL:when test="regex-group(1)='tsadi'">צ</XSL:when>
               <XSL:when test="regex-group(1)='tscy'">ц</XSL:when>
               <XSL:when test="regex-group(1)='tstrok'">ŧ</XSL:when>
               <XSL:when test="regex-group(1)='uacugr'">ύ</XSL:when>
               <XSL:when test="regex-group(1)='uacute'">ú</XSL:when>
               <XSL:when test="regex-group(1)='uadgr'">ΰ</XSL:when>
               <XSL:when test="regex-group(1)='uarr'">↑</XSL:when>
               <XSL:when test="regex-group(1)='ubreve'">ŭ</XSL:when>
               <XSL:when test="regex-group(1)='ucdgr'">ῧ</XSL:when>
               <XSL:when test="regex-group(1)='ucirc'">û</XSL:when>
               <XSL:when test="regex-group(1)='ucirgr'">ῦ</XSL:when>
               <XSL:when test="regex-group(1)='ucy'">у</XSL:when>
               <XSL:when test="regex-group(1)='udblac'">ű</XSL:when>
               <XSL:when test="regex-group(1)='udotb'">ụ</XSL:when>
               <XSL:when test="regex-group(1)='ugdgr'">ῢ</XSL:when>
               <XSL:when test="regex-group(1)='ugr'">υ</XSL:when>
               <XSL:when test="regex-group(1)='ugragr'">ὺ</XSL:when>
               <XSL:when test="regex-group(1)='ugrave'">ù</XSL:when>
               <XSL:when test="regex-group(1)='uhacek'">ǔ</XSL:when>
               <XSL:when test="regex-group(1)='uhblk'">▀</XSL:when>
               <XSL:when test="regex-group(1)='uindx'">☝</XSL:when>
               <XSL:when test="regex-group(1)='ulcrop'">⌏</XSL:when>
               <XSL:when test="regex-group(1)='umacr'">ū</XSL:when>
               <XSL:when test="regex-group(1)='uogon'">ų</XSL:when>
               <XSL:when test="regex-group(1)='uragr'">ὕ</XSL:when>
               <XSL:when test="regex-group(1)='urcgr'">ὗ</XSL:when>
               <XSL:when test="regex-group(1)='urcrop'">⌎</XSL:when>
               <XSL:when test="regex-group(1)='urggr'">ὓ</XSL:when>
               <XSL:when test="regex-group(1)='urine'">🝕</XSL:when>
               <XSL:when test="regex-group(1)='uring'">ů</XSL:when>
               <XSL:when test="regex-group(1)='urougr'">ὑ</XSL:when>
               <XSL:when test="regex-group(1)='usagr'">ὔ</XSL:when>
               <XSL:when test="regex-group(1)='uscgr'">ὖ</XSL:when>
               <XSL:when test="regex-group(1)='usggr'">ὒ</XSL:when>
               <XSL:when test="regex-group(1)='usmogr'">ὐ</XSL:when>
               <XSL:when test="regex-group(1)='utilde'">ũ</XSL:when>
               <XSL:when test="regex-group(1)='utri'">▵</XSL:when>
               <XSL:when test="regex-group(1)='utrif'">▴</XSL:when>
               <XSL:when test="regex-group(1)='uuml'">ü</XSL:when>
               <XSL:when test="regex-group(1)='vav'">ו</XSL:when>
               <XSL:when test="regex-group(1)='vbreve'"></XSL:when>
               <XSL:when test="regex-group(1)='vcy'">в</XSL:when>
               <XSL:when test="regex-group(1)='vellip'">⋮</XSL:when>
               <XSL:when test="regex-group(1)='verbar'">|</XSL:when>
               <XSL:when test="regex-group(1)='vers'">℣</XSL:when>
               <XSL:when test="regex-group(1)='vinedist'">🜋</XSL:when>
               <XSL:when test="regex-group(1)='vinegar'">🜊</XSL:when>
               <XSL:when test="regex-group(1)='vitriol'">🜖</XSL:when>
               <XSL:when test="regex-group(1)='w'">ỽ</XSL:when>
               <XSL:when test="regex-group(1)='water'">🜄</XSL:when>
               <XSL:when test="regex-group(1)='wax'">🝊</XSL:when>
               <XSL:when test="regex-group(1)='wcirc'">ŵ</XSL:when>
               <XSL:when test="regex-group(1)='wedgeq'">≙</XSL:when>
               <XSL:when test="regex-group(1)='whbull'">◦</XSL:when>
               <XSL:when test="regex-group(1)='wyn'">ƿ</XSL:when>
               <XSL:when test="regex-group(1)='xgr'">ξ</XSL:when>
               <XSL:when test="regex-group(1)='y'">ỿ</XSL:when>
               <XSL:when test="regex-group(1)='yacute'">ý</XSL:when>
               <XSL:when test="regex-group(1)='yacy'">я</XSL:when>
               <XSL:when test="regex-group(1)='ycirc'">ŷ</XSL:when>
               <XSL:when test="regex-group(1)='ycy'">ы</XSL:when>
               <XSL:when test="regex-group(1)='ydot'">ẏ</XSL:when>
               <XSL:when test="regex-group(1)='yen'">¥</XSL:when>
               <XSL:when test="regex-group(1)='yhook'">ƴ</XSL:when>
               <XSL:when test="regex-group(1)='ymacr'">ȳ</XSL:when>
               <XSL:when test="regex-group(1)='yod'">י</XSL:when>
               <XSL:when test="regex-group(1)='yogh'">ȝ</XSL:when>
               <XSL:when test="regex-group(1)='yucy'">ю</XSL:when>
               <XSL:when test="regex-group(1)='yuml'">ÿ</XSL:when>
               <XSL:when test="regex-group(1)='z'">Ꝫ</XSL:when>
               <XSL:when test="regex-group(1)='zacute'">ź</XSL:when>
               <XSL:when test="regex-group(1)='zaqef-qatan'">֔</XSL:when>
               <XSL:when test="regex-group(1)='zayin'">ז</XSL:when>
               <XSL:when test="regex-group(1)='zcaron'">ž</XSL:when>
               <XSL:when test="regex-group(1)='zcy'">з</XSL:when>
               <XSL:when test="regex-group(1)='zdot'">ż</XSL:when>
               <XSL:when test="regex-group(1)='zgr'">ζ</XSL:when>
               <XSL:when test="regex-group(1)='zhcy'">ж</XSL:when>
               <XSL:when test="regex-group(1)='Ggr-rev'">
                  <XSL:variable name="replace">Γ</XSL:variable>
                  <XSL:choose>
                     <XSL:when test="not($usemarkup)">
                        <XSL:value-of select="$replace"/>
                     </XSL:when>
                     <XSL:when test="starts-with($replace,'{')">
                        <XSL:sequence select="tei:makeExpan('Ggr-rev',translate($replace,'{}',''))"/>
                     </XSL:when>
                     <XSL:otherwise>
                        <XSL:sequence select="tei:makeG('Ggr-rev',$replace)"/>
                     </XSL:otherwise>
                  </XSL:choose>
               </XSL:when>
               <XSL:when test="regex-group(1)='Moon'">
                  <XSL:variable name="replace">☽</XSL:variable>
                  <XSL:choose>
                     <XSL:when test="not($usemarkup)">
                        <XSL:value-of select="$replace"/>
                     </XSL:when>
                     <XSL:when test="starts-with($replace,'{')">
                        <XSL:sequence select="tei:makeExpan('Moon',translate($replace,'{}',''))"/>
                     </XSL:when>
                     <XSL:otherwise>
                        <XSL:sequence select="tei:makeG('Moon',$replace)"/>
                     </XSL:otherwise>
                  </XSL:choose>
               </XSL:when>
               <XSL:when test="regex-group(1)='Moonnew'">
                  <XSL:variable name="replace">●</XSL:variable>
                  <XSL:choose>
                     <XSL:when test="not($usemarkup)">
                        <XSL:value-of select="$replace"/>
                     </XSL:when>
                     <XSL:when test="starts-with($replace,'{')">
                        <XSL:sequence select="tei:makeExpan('Moonnew',translate($replace,'{}',''))"/>
                     </XSL:when>
                     <XSL:otherwise>
                        <XSL:sequence select="tei:makeG('Moonnew',$replace)"/>
                     </XSL:otherwise>
                  </XSL:choose>
               </XSL:when>
               <XSL:when test="regex-group(1)='Moonround'">
                  <XSL:variable name="replace">❍</XSL:variable>
                  <XSL:choose>
                     <XSL:when test="not($usemarkup)">
                        <XSL:value-of select="$replace"/>
                     </XSL:when>
                     <XSL:when test="starts-with($replace,'{')">
                        <XSL:sequence select="tei:makeExpan('Moonround',translate($replace,'{}',''))"/>
                     </XSL:when>
                     <XSL:otherwise>
                        <XSL:sequence select="tei:makeG('Moonround',$replace)"/>
                     </XSL:otherwise>
                  </XSL:choose>
               </XSL:when>
               <XSL:when test="regex-group(1)='Rgr-rev'">
                  <XSL:variable name="replace">Ρ</XSL:variable>
                  <XSL:choose>
                     <XSL:when test="not($usemarkup)">
                        <XSL:value-of select="$replace"/>
                     </XSL:when>
                     <XSL:when test="starts-with($replace,'{')">
                        <XSL:sequence select="tei:makeExpan('Rgr-rev',translate($replace,'{}',''))"/>
                     </XSL:when>
                     <XSL:otherwise>
                        <XSL:sequence select="tei:makeG('Rgr-rev',$replace)"/>
                     </XSL:otherwise>
                  </XSL:choose>
               </XSL:when>
               <XSL:when test="regex-group(1)='Sgr-rev'">
                  <XSL:variable name="replace">Σ</XSL:variable>
                  <XSL:choose>
                     <XSL:when test="not($usemarkup)">
                        <XSL:value-of select="$replace"/>
                     </XSL:when>
                     <XSL:when test="starts-with($replace,'{')">
                        <XSL:sequence select="tei:makeExpan('Sgr-rev',translate($replace,'{}',''))"/>
                     </XSL:when>
                     <XSL:otherwise>
                        <XSL:sequence select="tei:makeG('Sgr-rev',$replace)"/>
                     </XSL:otherwise>
                  </XSL:choose>
               </XSL:when>
               <XSL:when test="regex-group(1)='V'">
                  <XSL:variable name="replace">Ʋ</XSL:variable>
                  <XSL:choose>
                     <XSL:when test="not($usemarkup)">
                        <XSL:value-of select="$replace"/>
                     </XSL:when>
                     <XSL:when test="starts-with($replace,'{')">
                        <XSL:sequence select="tei:makeExpan('V',translate($replace,'{}',''))"/>
                     </XSL:when>
                     <XSL:otherwise>
                        <XSL:sequence select="tei:makeG('V',$replace)"/>
                     </XSL:otherwise>
                  </XSL:choose>
               </XSL:when>
               <XSL:when test="regex-group(1)='abPRI'">
                  <XSL:variable name="replace">{PRI}</XSL:variable>
                  <XSL:choose>
                     <XSL:when test="not($usemarkup)">
                        <XSL:value-of select="$replace"/>
                     </XSL:when>
                     <XSL:when test="starts-with($replace,'{')">
                        <XSL:sequence select="tei:makeExpan('abPRI',translate($replace,'{}',''))"/>
                     </XSL:when>
                     <XSL:otherwise>
                        <XSL:sequence select="tei:makeG('abPRI',$replace)"/>
                     </XSL:otherwise>
                  </XSL:choose>
               </XSL:when>
               <XSL:when test="regex-group(1)='abQUE'">
                  <XSL:variable name="replace">{QUE}</XSL:variable>
                  <XSL:choose>
                     <XSL:when test="not($usemarkup)">
                        <XSL:value-of select="$replace"/>
                     </XSL:when>
                     <XSL:when test="starts-with($replace,'{')">
                        <XSL:sequence select="tei:makeExpan('abQUE',translate($replace,'{}',''))"/>
                     </XSL:when>
                     <XSL:otherwise>
                        <XSL:sequence select="tei:makeG('abQUE',$replace)"/>
                     </XSL:otherwise>
                  </XSL:choose>
               </XSL:when>
               <XSL:when test="regex-group(1)='abUS'">
                  <XSL:variable name="replace">{US}</XSL:variable>
                  <XSL:choose>
                     <XSL:when test="not($usemarkup)">
                        <XSL:value-of select="$replace"/>
                     </XSL:when>
                     <XSL:when test="starts-with($replace,'{')">
                        <XSL:sequence select="tei:makeExpan('abUS',translate($replace,'{}',''))"/>
                     </XSL:when>
                     <XSL:otherwise>
                        <XSL:sequence select="tei:makeG('abUS',$replace)"/>
                     </XSL:otherwise>
                  </XSL:choose>
               </XSL:when>
               <XSL:when test="regex-group(1)='abbrapo'">
                  <XSL:variable name="replace">’</XSL:variable>
                  <XSL:choose>
                     <XSL:when test="not($usemarkup)">
                        <XSL:value-of select="$replace"/>
                     </XSL:when>
                     <XSL:when test="starts-with($replace,'{')">
                        <XSL:sequence select="tei:makeExpan('abbrapo',translate($replace,'{}',''))"/>
                     </XSL:when>
                     <XSL:otherwise>
                        <XSL:sequence select="tei:makeG('abbrapo',$replace)"/>
                     </XSL:otherwise>
                  </XSL:choose>
               </XSL:when>
               <XSL:when test="regex-group(1)='abbus'">
                  <XSL:variable name="replace">{bus}</XSL:variable>
                  <XSL:choose>
                     <XSL:when test="not($usemarkup)">
                        <XSL:value-of select="$replace"/>
                     </XSL:when>
                     <XSL:when test="starts-with($replace,'{')">
                        <XSL:sequence select="tei:makeExpan('abbus',translate($replace,'{}',''))"/>
                     </XSL:when>
                     <XSL:otherwise>
                        <XSL:sequence select="tei:makeG('abbus',$replace)"/>
                     </XSL:otherwise>
                  </XSL:choose>
               </XSL:when>
               <XSL:when test="regex-group(1)='aber'">
                  <XSL:variable name="replace">{er}</XSL:variable>
                  <XSL:choose>
                     <XSL:when test="not($usemarkup)">
                        <XSL:value-of select="$replace"/>
                     </XSL:when>
                     <XSL:when test="starts-with($replace,'{')">
                        <XSL:sequence select="tei:makeExpan('aber',translate($replace,'{}',''))"/>
                     </XSL:when>
                     <XSL:otherwise>
                        <XSL:sequence select="tei:makeG('aber',$replace)"/>
                     </XSL:otherwise>
                  </XSL:choose>
               </XSL:when>
               <XSL:when test="regex-group(1)='abpre'">
                  <XSL:variable name="replace">p̄</XSL:variable>
                  <XSL:choose>
                     <XSL:when test="not($usemarkup)">
                        <XSL:value-of select="$replace"/>
                     </XSL:when>
                     <XSL:when test="starts-with($replace,'{')">
                        <XSL:sequence select="tei:makeExpan('abpre',translate($replace,'{}',''))"/>
                     </XSL:when>
                     <XSL:otherwise>
                        <XSL:sequence select="tei:makeG('abpre',$replace)"/>
                     </XSL:otherwise>
                  </XSL:choose>
               </XSL:when>
               <XSL:when test="regex-group(1)='abpri'">
                  <XSL:variable name="replace">{pri}</XSL:variable>
                  <XSL:choose>
                     <XSL:when test="not($usemarkup)">
                        <XSL:value-of select="$replace"/>
                     </XSL:when>
                     <XSL:when test="starts-with($replace,'{')">
                        <XSL:sequence select="tei:makeExpan('abpri',translate($replace,'{}',''))"/>
                     </XSL:when>
                     <XSL:otherwise>
                        <XSL:sequence select="tei:makeG('abpri',$replace)"/>
                     </XSL:otherwise>
                  </XSL:choose>
               </XSL:when>
               <XSL:when test="regex-group(1)='abqu'">
                  <XSL:variable name="replace">{qu}</XSL:variable>
                  <XSL:choose>
                     <XSL:when test="not($usemarkup)">
                        <XSL:value-of select="$replace"/>
                     </XSL:when>
                     <XSL:when test="starts-with($replace,'{')">
                        <XSL:sequence select="tei:makeExpan('abqu',translate($replace,'{}',''))"/>
                     </XSL:when>
                     <XSL:otherwise>
                        <XSL:sequence select="tei:makeG('abqu',$replace)"/>
                     </XSL:otherwise>
                  </XSL:choose>
               </XSL:when>
               <XSL:when test="regex-group(1)='abquam'">
                  <XSL:variable name="replace">{quam}</XSL:variable>
                  <XSL:choose>
                     <XSL:when test="not($usemarkup)">
                        <XSL:value-of select="$replace"/>
                     </XSL:when>
                     <XSL:when test="starts-with($replace,'{')">
                        <XSL:sequence select="tei:makeExpan('abquam',translate($replace,'{}',''))"/>
                     </XSL:when>
                     <XSL:otherwise>
                        <XSL:sequence select="tei:makeG('abquam',$replace)"/>
                     </XSL:otherwise>
                  </XSL:choose>
               </XSL:when>
               <XSL:when test="regex-group(1)='abque'">
                  <XSL:variable name="replace">{que}</XSL:variable>
                  <XSL:choose>
                     <XSL:when test="not($usemarkup)">
                        <XSL:value-of select="$replace"/>
                     </XSL:when>
                     <XSL:when test="starts-with($replace,'{')">
                        <XSL:sequence select="tei:makeExpan('abque',translate($replace,'{}',''))"/>
                     </XSL:when>
                     <XSL:otherwise>
                        <XSL:sequence select="tei:makeG('abque',$replace)"/>
                     </XSL:otherwise>
                  </XSL:choose>
               </XSL:when>
               <XSL:when test="regex-group(1)='abqui'">
                  <XSL:variable name="replace">{qui}</XSL:variable>
                  <XSL:choose>
                     <XSL:when test="not($usemarkup)">
                        <XSL:value-of select="$replace"/>
                     </XSL:when>
                     <XSL:when test="starts-with($replace,'{')">
                        <XSL:sequence select="tei:makeExpan('abqui',translate($replace,'{}',''))"/>
                     </XSL:when>
                     <XSL:otherwise>
                        <XSL:sequence select="tei:makeG('abqui',$replace)"/>
                     </XSL:otherwise>
                  </XSL:choose>
               </XSL:when>
               <XSL:when test="regex-group(1)='abris'">
                  <XSL:variable name="replace">{ris}</XSL:variable>
                  <XSL:choose>
                     <XSL:when test="not($usemarkup)">
                        <XSL:value-of select="$replace"/>
                     </XSL:when>
                     <XSL:when test="starts-with($replace,'{')">
                        <XSL:sequence select="tei:makeExpan('abris',translate($replace,'{}',''))"/>
                     </XSL:when>
                     <XSL:otherwise>
                        <XSL:sequence select="tei:makeG('abris',$replace)"/>
                     </XSL:otherwise>
                  </XSL:choose>
               </XSL:when>
               <XSL:when test="regex-group(1)='abrum'">
                  <XSL:variable name="replace">{rum}</XSL:variable>
                  <XSL:choose>
                     <XSL:when test="not($usemarkup)">
                        <XSL:value-of select="$replace"/>
                     </XSL:when>
                     <XSL:when test="starts-with($replace,'{')">
                        <XSL:sequence select="tei:makeExpan('abrum',translate($replace,'{}',''))"/>
                     </XSL:when>
                     <XSL:otherwise>
                        <XSL:sequence select="tei:makeG('abrum',$replace)"/>
                     </XSL:otherwise>
                  </XSL:choose>
               </XSL:when>
               <XSL:when test="regex-group(1)='absed'">
                  <XSL:variable name="replace">{sed}</XSL:variable>
                  <XSL:choose>
                     <XSL:when test="not($usemarkup)">
                        <XSL:value-of select="$replace"/>
                     </XSL:when>
                     <XSL:when test="starts-with($replace,'{')">
                        <XSL:sequence select="tei:makeExpan('absed',translate($replace,'{}',''))"/>
                     </XSL:when>
                     <XSL:otherwise>
                        <XSL:sequence select="tei:makeG('absed',$replace)"/>
                     </XSL:otherwise>
                  </XSL:choose>
               </XSL:when>
               <XSL:when test="regex-group(1)='abser'">
                  <XSL:variable name="replace">{ser}</XSL:variable>
                  <XSL:choose>
                     <XSL:when test="not($usemarkup)">
                        <XSL:value-of select="$replace"/>
                     </XSL:when>
                     <XSL:when test="starts-with($replace,'{')">
                        <XSL:sequence select="tei:makeExpan('abser',translate($replace,'{}',''))"/>
                     </XSL:when>
                     <XSL:otherwise>
                        <XSL:sequence select="tei:makeG('abser',$replace)"/>
                     </XSL:otherwise>
                  </XSL:choose>
               </XSL:when>
               <XSL:when test="regex-group(1)='abur'">
                  <XSL:variable name="replace">{ur}</XSL:variable>
                  <XSL:choose>
                     <XSL:when test="not($usemarkup)">
                        <XSL:value-of select="$replace"/>
                     </XSL:when>
                     <XSL:when test="starts-with($replace,'{')">
                        <XSL:sequence select="tei:makeExpan('abur',translate($replace,'{}',''))"/>
                     </XSL:when>
                     <XSL:otherwise>
                        <XSL:sequence select="tei:makeG('abur',$replace)"/>
                     </XSL:otherwise>
                  </XSL:choose>
               </XSL:when>
               <XSL:when test="regex-group(1)='alum'">
                  <XSL:variable name="replace">{alum}</XSL:variable>
                  <XSL:choose>
                     <XSL:when test="not($usemarkup)">
                        <XSL:value-of select="$replace"/>
                     </XSL:when>
                     <XSL:when test="starts-with($replace,'{')">
                        <XSL:sequence select="tei:makeExpan('alum',translate($replace,'{}',''))"/>
                     </XSL:when>
                     <XSL:otherwise>
                        <XSL:sequence select="tei:makeG('alum',$replace)"/>
                     </XSL:otherwise>
                  </XSL:choose>
               </XSL:when>
               <XSL:when test="regex-group(1)='alum2'">
                  <XSL:variable name="replace">{alum}</XSL:variable>
                  <XSL:choose>
                     <XSL:when test="not($usemarkup)">
                        <XSL:value-of select="$replace"/>
                     </XSL:when>
                     <XSL:when test="starts-with($replace,'{')">
                        <XSL:sequence select="tei:makeExpan('alum2',translate($replace,'{}',''))"/>
                     </XSL:when>
                     <XSL:otherwise>
                        <XSL:sequence select="tei:makeG('alum2',$replace)"/>
                     </XSL:otherwise>
                  </XSL:choose>
               </XSL:when>
               <XSL:when test="regex-group(1)='angulum'">
                  <XSL:variable name="replace">{angulum}</XSL:variable>
                  <XSL:choose>
                     <XSL:when test="not($usemarkup)">
                        <XSL:value-of select="$replace"/>
                     </XSL:when>
                     <XSL:when test="starts-with($replace,'{')">
                        <XSL:sequence select="tei:makeExpan('angulum',translate($replace,'{}',''))"/>
                     </XSL:when>
                     <XSL:otherwise>
                        <XSL:sequence select="tei:makeG('angulum',$replace)"/>
                     </XSL:otherwise>
                  </XSL:choose>
               </XSL:when>
               <XSL:when test="regex-group(1)='antimony'">
                  <XSL:variable name="replace">{antimony}</XSL:variable>
                  <XSL:choose>
                     <XSL:when test="not($usemarkup)">
                        <XSL:value-of select="$replace"/>
                     </XSL:when>
                     <XSL:when test="starts-with($replace,'{')">
                        <XSL:sequence select="tei:makeExpan('antimony',translate($replace,'{}',''))"/>
                     </XSL:when>
                     <XSL:otherwise>
                        <XSL:sequence select="tei:makeG('antimony',$replace)"/>
                     </XSL:otherwise>
                  </XSL:choose>
               </XSL:when>
               <XSL:when test="regex-group(1)='arsenic2'">
                  <XSL:variable name="replace">{arsenic}</XSL:variable>
                  <XSL:choose>
                     <XSL:when test="not($usemarkup)">
                        <XSL:value-of select="$replace"/>
                     </XSL:when>
                     <XSL:when test="starts-with($replace,'{')">
                        <XSL:sequence select="tei:makeExpan('arsenic2',translate($replace,'{}',''))"/>
                     </XSL:when>
                     <XSL:otherwise>
                        <XSL:sequence select="tei:makeG('arsenic2',$replace)"/>
                     </XSL:otherwise>
                  </XSL:choose>
               </XSL:when>
               <XSL:when test="regex-group(1)='asterisc'">
                  <XSL:variable name="replace">܍</XSL:variable>
                  <XSL:choose>
                     <XSL:when test="not($usemarkup)">
                        <XSL:value-of select="$replace"/>
                     </XSL:when>
                     <XSL:when test="starts-with($replace,'{')">
                        <XSL:sequence select="tei:makeExpan('asterisc',translate($replace,'{}',''))"/>
                     </XSL:when>
                     <XSL:otherwise>
                        <XSL:sequence select="tei:makeG('asterisc',$replace)"/>
                     </XSL:otherwise>
                  </XSL:choose>
               </XSL:when>
               <XSL:when test="regex-group(1)='barlinef'">
                  <XSL:variable name="replace">𝄀</XSL:variable>
                  <XSL:choose>
                     <XSL:when test="not($usemarkup)">
                        <XSL:value-of select="$replace"/>
                     </XSL:when>
                     <XSL:when test="starts-with($replace,'{')">
                        <XSL:sequence select="tei:makeExpan('barlinef',translate($replace,'{}',''))"/>
                     </XSL:when>
                     <XSL:otherwise>
                        <XSL:sequence select="tei:makeG('barlinef',$replace)"/>
                     </XSL:otherwise>
                  </XSL:choose>
               </XSL:when>
               <XSL:when test="regex-group(1)='bezoarMin'">
                  <XSL:variable name="replace">♌</XSL:variable>
                  <XSL:choose>
                     <XSL:when test="not($usemarkup)">
                        <XSL:value-of select="$replace"/>
                     </XSL:when>
                     <XSL:when test="starts-with($replace,'{')">
                        <XSL:sequence select="tei:makeExpan('bezoarMin',translate($replace,'{}',''))"/>
                     </XSL:when>
                     <XSL:otherwise>
                        <XSL:sequence select="tei:makeG('bezoarMin',$replace)"/>
                     </XSL:otherwise>
                  </XSL:choose>
               </XSL:when>
               <XSL:when test="regex-group(1)='blood'">
                  <XSL:variable name="replace">{blood}</XSL:variable>
                  <XSL:choose>
                     <XSL:when test="not($usemarkup)">
                        <XSL:value-of select="$replace"/>
                     </XSL:when>
                     <XSL:when test="starts-with($replace,'{')">
                        <XSL:sequence select="tei:makeExpan('blood',translate($replace,'{}',''))"/>
                     </XSL:when>
                     <XSL:otherwise>
                        <XSL:sequence select="tei:makeG('blood',$replace)"/>
                     </XSL:otherwise>
                  </XSL:choose>
               </XSL:when>
               <XSL:when test="regex-group(1)='cinnabar2'">
                  <XSL:variable name="replace">{cinnabar}</XSL:variable>
                  <XSL:choose>
                     <XSL:when test="not($usemarkup)">
                        <XSL:value-of select="$replace"/>
                     </XSL:when>
                     <XSL:when test="starts-with($replace,'{')">
                        <XSL:sequence select="tei:makeExpan('cinnabar2',translate($replace,'{}',''))"/>
                     </XSL:when>
                     <XSL:otherwise>
                        <XSL:sequence select="tei:makeG('cinnabar2',$replace)"/>
                     </XSL:otherwise>
                  </XSL:choose>
               </XSL:when>
               <XSL:when test="regex-group(1)='circdot'">
                  <XSL:variable name="replace">⊙</XSL:variable>
                  <XSL:choose>
                     <XSL:when test="not($usemarkup)">
                        <XSL:value-of select="$replace"/>
                     </XSL:when>
                     <XSL:when test="starts-with($replace,'{')">
                        <XSL:sequence select="tei:makeExpan('circdot',translate($replace,'{}',''))"/>
                     </XSL:when>
                     <XSL:otherwise>
                        <XSL:sequence select="tei:makeG('circdot',$replace)"/>
                     </XSL:otherwise>
                  </XSL:choose>
               </XSL:when>
               <XSL:when test="regex-group(1)='commonTime-allegro'">
                  <XSL:variable name="replace">{common time (allegro)}</XSL:variable>
                  <XSL:choose>
                     <XSL:when test="not($usemarkup)">
                        <XSL:value-of select="$replace"/>
                     </XSL:when>
                     <XSL:when test="starts-with($replace,'{')">
                        <XSL:sequence select="tei:makeExpan('commonTime-allegro',translate($replace,'{}',''))"/>
                     </XSL:when>
                     <XSL:otherwise>
                        <XSL:sequence select="tei:makeG('commonTime-allegro',$replace)"/>
                     </XSL:otherwise>
                  </XSL:choose>
               </XSL:when>
               <XSL:when test="regex-group(1)='commonTime-largo'">
                  <XSL:variable name="replace">{common time (largro)}</XSL:variable>
                  <XSL:choose>
                     <XSL:when test="not($usemarkup)">
                        <XSL:value-of select="$replace"/>
                     </XSL:when>
                     <XSL:when test="starts-with($replace,'{')">
                        <XSL:sequence select="tei:makeExpan('commonTime-largo',translate($replace,'{}',''))"/>
                     </XSL:when>
                     <XSL:otherwise>
                        <XSL:sequence select="tei:makeG('commonTime-largo',$replace)"/>
                     </XSL:otherwise>
                  </XSL:choose>
               </XSL:when>
               <XSL:when test="regex-group(1)='cross'">
                  <XSL:variable name="replace">✚</XSL:variable>
                  <XSL:choose>
                     <XSL:when test="not($usemarkup)">
                        <XSL:value-of select="$replace"/>
                     </XSL:when>
                     <XSL:when test="starts-with($replace,'{')">
                        <XSL:sequence select="tei:makeExpan('cross',translate($replace,'{}',''))"/>
                     </XSL:when>
                     <XSL:otherwise>
                        <XSL:sequence select="tei:makeG('cross',$replace)"/>
                     </XSL:otherwise>
                  </XSL:choose>
               </XSL:when>
               <XSL:when test="regex-group(1)='day'">
                  <XSL:variable name="replace">{day}</XSL:variable>
                  <XSL:choose>
                     <XSL:when test="not($usemarkup)">
                        <XSL:value-of select="$replace"/>
                     </XSL:when>
                     <XSL:when test="starts-with($replace,'{')">
                        <XSL:sequence select="tei:makeExpan('day',translate($replace,'{}',''))"/>
                     </XSL:when>
                     <XSL:otherwise>
                        <XSL:sequence select="tei:makeG('day',$replace)"/>
                     </XSL:otherwise>
                  </XSL:choose>
               </XSL:when>
               <XSL:when test="regex-group(1)='decimalL'">
                  <XSL:variable name="replace">⌊</XSL:variable>
                  <XSL:choose>
                     <XSL:when test="not($usemarkup)">
                        <XSL:value-of select="$replace"/>
                     </XSL:when>
                     <XSL:when test="starts-with($replace,'{')">
                        <XSL:sequence select="tei:makeExpan('decimalL',translate($replace,'{}',''))"/>
                     </XSL:when>
                     <XSL:otherwise>
                        <XSL:sequence select="tei:makeG('decimalL',$replace)"/>
                     </XSL:otherwise>
                  </XSL:choose>
               </XSL:when>
               <XSL:when test="regex-group(1)='decimalc'">
                  <XSL:variable name="replace">.</XSL:variable>
                  <XSL:choose>
                     <XSL:when test="not($usemarkup)">
                        <XSL:value-of select="$replace"/>
                     </XSL:when>
                     <XSL:when test="starts-with($replace,'{')">
                        <XSL:sequence select="tei:makeExpan('decimalc',translate($replace,'{}',''))"/>
                     </XSL:when>
                     <XSL:otherwise>
                        <XSL:sequence select="tei:makeG('decimalc',$replace)"/>
                     </XSL:otherwise>
                  </XSL:choose>
               </XSL:when>
               <XSL:when test="regex-group(1)='dhook'">
                  <XSL:variable name="replace">d̔</XSL:variable>
                  <XSL:choose>
                     <XSL:when test="not($usemarkup)">
                        <XSL:value-of select="$replace"/>
                     </XSL:when>
                     <XSL:when test="starts-with($replace,'{')">
                        <XSL:sequence select="tei:makeExpan('dhook',translate($replace,'{}',''))"/>
                     </XSL:when>
                     <XSL:otherwise>
                        <XSL:sequence select="tei:makeG('dhook',$replace)"/>
                     </XSL:otherwise>
                  </XSL:choose>
               </XSL:when>
               <XSL:when test="regex-group(1)='direct'">
                  <XSL:variable name="replace">{direct}</XSL:variable>
                  <XSL:choose>
                     <XSL:when test="not($usemarkup)">
                        <XSL:value-of select="$replace"/>
                     </XSL:when>
                     <XSL:when test="starts-with($replace,'{')">
                        <XSL:sequence select="tei:makeExpan('direct',translate($replace,'{}',''))"/>
                     </XSL:when>
                     <XSL:otherwise>
                        <XSL:sequence select="tei:makeG('direct',$replace)"/>
                     </XSL:otherwise>
                  </XSL:choose>
               </XSL:when>
               <XSL:when test="regex-group(1)='divisor'">
                  <XSL:variable name="replace">{divisor}</XSL:variable>
                  <XSL:choose>
                     <XSL:when test="not($usemarkup)">
                        <XSL:value-of select="$replace"/>
                     </XSL:when>
                     <XSL:when test="starts-with($replace,'{')">
                        <XSL:sequence select="tei:makeExpan('divisor',translate($replace,'{}',''))"/>
                     </XSL:when>
                     <XSL:otherwise>
                        <XSL:sequence select="tei:makeG('divisor',$replace)"/>
                     </XSL:otherwise>
                  </XSL:choose>
               </XSL:when>
               <XSL:when test="regex-group(1)='dnc-female'">
                  <XSL:variable name="replace">☽</XSL:variable>
                  <XSL:choose>
                     <XSL:when test="not($usemarkup)">
                        <XSL:value-of select="$replace"/>
                     </XSL:when>
                     <XSL:when test="starts-with($replace,'{')">
                        <XSL:sequence select="tei:makeExpan('dnc-female',translate($replace,'{}',''))"/>
                     </XSL:when>
                     <XSL:otherwise>
                        <XSL:sequence select="tei:makeG('dnc-female',$replace)"/>
                     </XSL:otherwise>
                  </XSL:choose>
               </XSL:when>
               <XSL:when test="regex-group(1)='dnc-male'">
                  <XSL:variable name="replace">☉</XSL:variable>
                  <XSL:choose>
                     <XSL:when test="not($usemarkup)">
                        <XSL:value-of select="$replace"/>
                     </XSL:when>
                     <XSL:when test="starts-with($replace,'{')">
                        <XSL:sequence select="tei:makeExpan('dnc-male',translate($replace,'{}',''))"/>
                     </XSL:when>
                     <XSL:otherwise>
                        <XSL:sequence select="tei:makeG('dnc-male',$replace)"/>
                     </XSL:otherwise>
                  </XSL:choose>
               </XSL:when>
               <XSL:when test="regex-group(1)='dnc-repeat'">
                  <XSL:variable name="replace"> .̲̲ </XSL:variable>
                  <XSL:choose>
                     <XSL:when test="not($usemarkup)">
                        <XSL:value-of select="$replace"/>
                     </XSL:when>
                     <XSL:when test="starts-with($replace,'{')">
                        <XSL:sequence select="tei:makeExpan('dnc-repeat',translate($replace,'{}',''))"/>
                     </XSL:when>
                     <XSL:otherwise>
                        <XSL:sequence select="tei:makeG('dnc-repeat',$replace)"/>
                     </XSL:otherwise>
                  </XSL:choose>
               </XSL:when>
               <XSL:when test="regex-group(1)='dnc-repeat2'">
                  <XSL:variable name="replace"> :̲̲ </XSL:variable>
                  <XSL:choose>
                     <XSL:when test="not($usemarkup)">
                        <XSL:value-of select="$replace"/>
                     </XSL:when>
                     <XSL:when test="starts-with($replace,'{')">
                        <XSL:sequence select="tei:makeExpan('dnc-repeat2',translate($replace,'{}',''))"/>
                     </XSL:when>
                     <XSL:otherwise>
                        <XSL:sequence select="tei:makeG('dnc-repeat2',$replace)"/>
                     </XSL:otherwise>
                  </XSL:choose>
               </XSL:when>
               <XSL:when test="regex-group(1)='dnc-repeat3'">
                  <XSL:variable name="replace"> .̲:̲̲ </XSL:variable>
                  <XSL:choose>
                     <XSL:when test="not($usemarkup)">
                        <XSL:value-of select="$replace"/>
                     </XSL:when>
                     <XSL:when test="starts-with($replace,'{')">
                        <XSL:sequence select="tei:makeExpan('dnc-repeat3',translate($replace,'{}',''))"/>
                     </XSL:when>
                     <XSL:otherwise>
                        <XSL:sequence select="tei:makeG('dnc-repeat3',$replace)"/>
                     </XSL:otherwise>
                  </XSL:choose>
               </XSL:when>
               <XSL:when test="regex-group(1)='dnc-startover'">
                  <XSL:variable name="replace">⁜</XSL:variable>
                  <XSL:choose>
                     <XSL:when test="not($usemarkup)">
                        <XSL:value-of select="$replace"/>
                     </XSL:when>
                     <XSL:when test="starts-with($replace,'{')">
                        <XSL:sequence select="tei:makeExpan('dnc-startover',translate($replace,'{}',''))"/>
                     </XSL:when>
                     <XSL:otherwise>
                        <XSL:sequence select="tei:makeG('dnc-startover',$replace)"/>
                     </XSL:otherwise>
                  </XSL:choose>
               </XSL:when>
               <XSL:when test="regex-group(1)='dram'">
                  <XSL:variable name="replace">ʒ</XSL:variable>
                  <XSL:choose>
                     <XSL:when test="not($usemarkup)">
                        <XSL:value-of select="$replace"/>
                     </XSL:when>
                     <XSL:when test="starts-with($replace,'{')">
                        <XSL:sequence select="tei:makeExpan('dram',translate($replace,'{}',''))"/>
                     </XSL:when>
                     <XSL:otherwise>
                        <XSL:sequence select="tei:makeG('dram',$replace)"/>
                     </XSL:otherwise>
                  </XSL:choose>
               </XSL:when>
               <XSL:when test="regex-group(1)='dtristar'">
                  <XSL:variable name="replace">*⁎*</XSL:variable>
                  <XSL:choose>
                     <XSL:when test="not($usemarkup)">
                        <XSL:value-of select="$replace"/>
                     </XSL:when>
                     <XSL:when test="starts-with($replace,'{')">
                        <XSL:sequence select="tei:makeExpan('dtristar',translate($replace,'{}',''))"/>
                     </XSL:when>
                     <XSL:otherwise>
                        <XSL:sequence select="tei:makeG('dtristar',$replace)"/>
                     </XSL:otherwise>
                  </XSL:choose>
               </XSL:when>
               <XSL:when test="regex-group(1)='endq'">
                  <XSL:variable name="replace">”</XSL:variable>
                  <XSL:choose>
                     <XSL:when test="not($usemarkup)">
                        <XSL:value-of select="$replace"/>
                     </XSL:when>
                     <XSL:when test="starts-with($replace,'{')">
                        <XSL:sequence select="tei:makeExpan('endq',translate($replace,'{}',''))"/>
                     </XSL:when>
                     <XSL:otherwise>
                        <XSL:sequence select="tei:makeG('endq',$replace)"/>
                     </XSL:otherwise>
                  </XSL:choose>
               </XSL:when>
               <XSL:when test="regex-group(1)='es'">
                  <XSL:variable name="replace">{es}</XSL:variable>
                  <XSL:choose>
                     <XSL:when test="not($usemarkup)">
                        <XSL:value-of select="$replace"/>
                     </XSL:when>
                     <XSL:when test="starts-with($replace,'{')">
                        <XSL:sequence select="tei:makeExpan('es',translate($replace,'{}',''))"/>
                     </XSL:when>
                     <XSL:otherwise>
                        <XSL:sequence select="tei:makeG('es',$replace)"/>
                     </XSL:otherwise>
                  </XSL:choose>
               </XSL:when>
               <XSL:when test="regex-group(1)='etc'">
                  <XSL:variable name="replace">{etc}</XSL:variable>
                  <XSL:choose>
                     <XSL:when test="not($usemarkup)">
                        <XSL:value-of select="$replace"/>
                     </XSL:when>
                     <XSL:when test="starts-with($replace,'{')">
                        <XSL:sequence select="tei:makeExpan('etc',translate($replace,'{}',''))"/>
                     </XSL:when>
                     <XSL:otherwise>
                        <XSL:sequence select="tei:makeG('etc',$replace)"/>
                     </XSL:otherwise>
                  </XSL:choose>
               </XSL:when>
               <XSL:when test="regex-group(1)='female'">
                  <XSL:variable name="replace">♀</XSL:variable>
                  <XSL:choose>
                     <XSL:when test="not($usemarkup)">
                        <XSL:value-of select="$replace"/>
                     </XSL:when>
                     <XSL:when test="starts-with($replace,'{')">
                        <XSL:sequence select="tei:makeExpan('female',translate($replace,'{}',''))"/>
                     </XSL:when>
                     <XSL:otherwise>
                        <XSL:sequence select="tei:makeG('female',$replace)"/>
                     </XSL:otherwise>
                  </XSL:choose>
               </XSL:when>
               <XSL:when test="regex-group(1)='finallamed'">
                  <XSL:variable name="replace">ﬥ</XSL:variable>
                  <XSL:choose>
                     <XSL:when test="not($usemarkup)">
                        <XSL:value-of select="$replace"/>
                     </XSL:when>
                     <XSL:when test="starts-with($replace,'{')">
                        <XSL:sequence select="tei:makeExpan('finallamed',translate($replace,'{}',''))"/>
                     </XSL:when>
                     <XSL:otherwise>
                        <XSL:sequence select="tei:makeG('finallamed',$replace)"/>
                     </XSL:otherwise>
                  </XSL:choose>
               </XSL:when>
               <XSL:when test="regex-group(1)='fivedash'">
                  <XSL:variable name="replace">{fivedash}</XSL:variable>
                  <XSL:choose>
                     <XSL:when test="not($usemarkup)">
                        <XSL:value-of select="$replace"/>
                     </XSL:when>
                     <XSL:when test="starts-with($replace,'{')">
                        <XSL:sequence select="tei:makeExpan('fivedash',translate($replace,'{}',''))"/>
                     </XSL:when>
                     <XSL:otherwise>
                        <XSL:sequence select="tei:makeG('fivedash',$replace)"/>
                     </XSL:otherwise>
                  </XSL:choose>
               </XSL:when>
               <XSL:when test="regex-group(1)='fjlig'">
                  <XSL:variable name="replace">{fj}</XSL:variable>
                  <XSL:choose>
                     <XSL:when test="not($usemarkup)">
                        <XSL:value-of select="$replace"/>
                     </XSL:when>
                     <XSL:when test="starts-with($replace,'{')">
                        <XSL:sequence select="tei:makeExpan('fjlig',translate($replace,'{}',''))"/>
                     </XSL:when>
                     <XSL:otherwise>
                        <XSL:sequence select="tei:makeG('fjlig',$replace)"/>
                     </XSL:otherwise>
                  </XSL:choose>
               </XSL:when>
               <XSL:when test="regex-group(1)='glass'">
                  <XSL:variable name="replace">{glass}</XSL:variable>
                  <XSL:choose>
                     <XSL:when test="not($usemarkup)">
                        <XSL:value-of select="$replace"/>
                     </XSL:when>
                     <XSL:when test="starts-with($replace,'{')">
                        <XSL:sequence select="tei:makeExpan('glass',translate($replace,'{}',''))"/>
                     </XSL:when>
                     <XSL:otherwise>
                        <XSL:sequence select="tei:makeG('glass',$replace)"/>
                     </XSL:otherwise>
                  </XSL:choose>
               </XSL:when>
               <XSL:when test="regex-group(1)='hDagger'">
                  <XSL:variable name="replace">{horizontal ‡}</XSL:variable>
                  <XSL:choose>
                     <XSL:when test="not($usemarkup)">
                        <XSL:value-of select="$replace"/>
                     </XSL:when>
                     <XSL:when test="starts-with($replace,'{')">
                        <XSL:sequence select="tei:makeExpan('hDagger',translate($replace,'{}',''))"/>
                     </XSL:when>
                     <XSL:otherwise>
                        <XSL:sequence select="tei:makeG('hDagger',$replace)"/>
                     </XSL:otherwise>
                  </XSL:choose>
               </XSL:when>
               <XSL:when test="regex-group(1)='halfcross'">
                  <XSL:variable name="replace">⊢</XSL:variable>
                  <XSL:choose>
                     <XSL:when test="not($usemarkup)">
                        <XSL:value-of select="$replace"/>
                     </XSL:when>
                     <XSL:when test="starts-with($replace,'{')">
                        <XSL:sequence select="tei:makeExpan('halfcross',translate($replace,'{}',''))"/>
                     </XSL:when>
                     <XSL:otherwise>
                        <XSL:sequence select="tei:makeG('halfcross',$replace)"/>
                     </XSL:otherwise>
                  </XSL:choose>
               </XSL:when>
               <XSL:when test="regex-group(1)='heart'">
                  <XSL:variable name="replace">♡</XSL:variable>
                  <XSL:choose>
                     <XSL:when test="not($usemarkup)">
                        <XSL:value-of select="$replace"/>
                     </XSL:when>
                     <XSL:when test="starts-with($replace,'{')">
                        <XSL:sequence select="tei:makeExpan('heart',translate($replace,'{}',''))"/>
                     </XSL:when>
                     <XSL:otherwise>
                        <XSL:sequence select="tei:makeG('heart',$replace)"/>
                     </XSL:otherwise>
                  </XSL:choose>
               </XSL:when>
               <XSL:when test="regex-group(1)='higherterm'">
                  <XSL:variable name="replace">{higher term}</XSL:variable>
                  <XSL:choose>
                     <XSL:when test="not($usemarkup)">
                        <XSL:value-of select="$replace"/>
                     </XSL:when>
                     <XSL:when test="starts-with($replace,'{')">
                        <XSL:sequence select="tei:makeExpan('higherterm',translate($replace,'{}',''))"/>
                     </XSL:when>
                     <XSL:otherwise>
                        <XSL:sequence select="tei:makeG('higherterm',$replace)"/>
                     </XSL:otherwise>
                  </XSL:choose>
               </XSL:when>
               <XSL:when test="regex-group(1)='higherthan'">
                  <XSL:variable name="replace">∧</XSL:variable>
                  <XSL:choose>
                     <XSL:when test="not($usemarkup)">
                        <XSL:value-of select="$replace"/>
                     </XSL:when>
                     <XSL:when test="starts-with($replace,'{')">
                        <XSL:sequence select="tei:makeExpan('higherthan',translate($replace,'{}',''))"/>
                     </XSL:when>
                     <XSL:otherwise>
                        <XSL:sequence select="tei:makeG('higherthan',$replace)"/>
                     </XSL:otherwise>
                  </XSL:choose>
               </XSL:when>
               <XSL:when test="regex-group(1)='hyperlemnisc'">
                  <XSL:variable name="replace">∸</XSL:variable>
                  <XSL:choose>
                     <XSL:when test="not($usemarkup)">
                        <XSL:value-of select="$replace"/>
                     </XSL:when>
                     <XSL:when test="starts-with($replace,'{')">
                        <XSL:sequence select="tei:makeExpan('hyperlemnisc',translate($replace,'{}',''))"/>
                     </XSL:when>
                     <XSL:otherwise>
                        <XSL:sequence select="tei:makeG('hyperlemnisc',$replace)"/>
                     </XSL:otherwise>
                  </XSL:choose>
               </XSL:when>
               <XSL:when test="regex-group(1)='hypolemnisc'">
                  <XSL:variable name="replace">܋</XSL:variable>
                  <XSL:choose>
                     <XSL:when test="not($usemarkup)">
                        <XSL:value-of select="$replace"/>
                     </XSL:when>
                     <XSL:when test="starts-with($replace,'{')">
                        <XSL:sequence select="tei:makeExpan('hypolemnisc',translate($replace,'{}',''))"/>
                     </XSL:when>
                     <XSL:otherwise>
                        <XSL:sequence select="tei:makeG('hypolemnisc',$replace)"/>
                     </XSL:otherwise>
                  </XSL:choose>
               </XSL:when>
               <XSL:when test="regex-group(1)='idagger'">
                  <XSL:variable name="replace">{inverted †}</XSL:variable>
                  <XSL:choose>
                     <XSL:when test="not($usemarkup)">
                        <XSL:value-of select="$replace"/>
                     </XSL:when>
                     <XSL:when test="starts-with($replace,'{')">
                        <XSL:sequence select="tei:makeExpan('idagger',translate($replace,'{}',''))"/>
                     </XSL:when>
                     <XSL:otherwise>
                        <XSL:sequence select="tei:makeG('idagger',$replace)"/>
                     </XSL:otherwise>
                  </XSL:choose>
               </XSL:when>
               <XSL:when test="regex-group(1)='ipara'">
                  <XSL:variable name="replace">⁋</XSL:variable>
                  <XSL:choose>
                     <XSL:when test="not($usemarkup)">
                        <XSL:value-of select="$replace"/>
                     </XSL:when>
                     <XSL:when test="starts-with($replace,'{')">
                        <XSL:sequence select="tei:makeExpan('ipara',translate($replace,'{}',''))"/>
                     </XSL:when>
                     <XSL:otherwise>
                        <XSL:sequence select="tei:makeG('ipara',$replace)"/>
                     </XSL:otherwise>
                  </XSL:choose>
               </XSL:when>
               <XSL:when test="regex-group(1)='ldagger'">
                  <XSL:variable name="replace">{left †}</XSL:variable>
                  <XSL:choose>
                     <XSL:when test="not($usemarkup)">
                        <XSL:value-of select="$replace"/>
                     </XSL:when>
                     <XSL:when test="starts-with($replace,'{')">
                        <XSL:sequence select="tei:makeExpan('ldagger',translate($replace,'{}',''))"/>
                     </XSL:when>
                     <XSL:otherwise>
                        <XSL:sequence select="tei:makeG('ldagger',$replace)"/>
                     </XSL:otherwise>
                  </XSL:choose>
               </XSL:when>
               <XSL:when test="regex-group(1)='ldiple'">
                  <XSL:variable name="replace">‹</XSL:variable>
                  <XSL:choose>
                     <XSL:when test="not($usemarkup)">
                        <XSL:value-of select="$replace"/>
                     </XSL:when>
                     <XSL:when test="starts-with($replace,'{')">
                        <XSL:sequence select="tei:makeExpan('ldiple',translate($replace,'{}',''))"/>
                     </XSL:when>
                     <XSL:otherwise>
                        <XSL:sequence select="tei:makeG('ldiple',$replace)"/>
                     </XSL:otherwise>
                  </XSL:choose>
               </XSL:when>
               <XSL:when test="regex-group(1)='leaf'">
                  <XSL:variable name="replace">❧</XSL:variable>
                  <XSL:choose>
                     <XSL:when test="not($usemarkup)">
                        <XSL:value-of select="$replace"/>
                     </XSL:when>
                     <XSL:when test="starts-with($replace,'{')">
                        <XSL:sequence select="tei:makeExpan('leaf',translate($replace,'{}',''))"/>
                     </XSL:when>
                     <XSL:otherwise>
                        <XSL:sequence select="tei:makeG('leaf',$replace)"/>
                     </XSL:otherwise>
                  </XSL:choose>
               </XSL:when>
               <XSL:when test="regex-group(1)='leftblank'">
                  <XSL:variable name="replace">{left blank}</XSL:variable>
                  <XSL:choose>
                     <XSL:when test="not($usemarkup)">
                        <XSL:value-of select="$replace"/>
                     </XSL:when>
                     <XSL:when test="starts-with($replace,'{')">
                        <XSL:sequence select="tei:makeExpan('leftblank',translate($replace,'{}',''))"/>
                     </XSL:when>
                     <XSL:otherwise>
                        <XSL:sequence select="tei:makeG('leftblank',$replace)"/>
                     </XSL:otherwise>
                  </XSL:choose>
               </XSL:when>
               <XSL:when test="regex-group(1)='lemnisc'">
                  <XSL:variable name="replace">÷</XSL:variable>
                  <XSL:choose>
                     <XSL:when test="not($usemarkup)">
                        <XSL:value-of select="$replace"/>
                     </XSL:when>
                     <XSL:when test="starts-with($replace,'{')">
                        <XSL:sequence select="tei:makeExpan('lemnisc',translate($replace,'{}',''))"/>
                     </XSL:when>
                     <XSL:otherwise>
                        <XSL:sequence select="tei:makeG('lemnisc',$replace)"/>
                     </XSL:otherwise>
                  </XSL:choose>
               </XSL:when>
               <XSL:when test="regex-group(1)='lessthan'">
                  <XSL:variable name="replace">‹</XSL:variable>
                  <XSL:choose>
                     <XSL:when test="not($usemarkup)">
                        <XSL:value-of select="$replace"/>
                     </XSL:when>
                     <XSL:when test="starts-with($replace,'{')">
                        <XSL:sequence select="tei:makeExpan('lessthan',translate($replace,'{}',''))"/>
                     </XSL:when>
                     <XSL:otherwise>
                        <XSL:sequence select="tei:makeG('lessthan',$replace)"/>
                     </XSL:otherwise>
                  </XSL:choose>
               </XSL:when>
               <XSL:when test="regex-group(1)='lloop'">
                  <XSL:variable name="replace">lʾ</XSL:variable>
                  <XSL:choose>
                     <XSL:when test="not($usemarkup)">
                        <XSL:value-of select="$replace"/>
                     </XSL:when>
                     <XSL:when test="starts-with($replace,'{')">
                        <XSL:sequence select="tei:makeExpan('lloop',translate($replace,'{}',''))"/>
                     </XSL:when>
                     <XSL:otherwise>
                        <XSL:sequence select="tei:makeG('lloop',$replace)"/>
                     </XSL:otherwise>
                  </XSL:choose>
               </XSL:when>
               <XSL:when test="regex-group(1)='logarithm'">
                  <XSL:variable name="replace">{logarithm}</XSL:variable>
                  <XSL:choose>
                     <XSL:when test="not($usemarkup)">
                        <XSL:value-of select="$replace"/>
                     </XSL:when>
                     <XSL:when test="starts-with($replace,'{')">
                        <XSL:sequence select="tei:makeExpan('logarithm',translate($replace,'{}',''))"/>
                     </XSL:when>
                     <XSL:otherwise>
                        <XSL:sequence select="tei:makeG('logarithm',$replace)"/>
                     </XSL:otherwise>
                  </XSL:choose>
               </XSL:when>
               <XSL:when test="regex-group(1)='lowerterm'">
                  <XSL:variable name="replace">⊽</XSL:variable>
                  <XSL:choose>
                     <XSL:when test="not($usemarkup)">
                        <XSL:value-of select="$replace"/>
                     </XSL:when>
                     <XSL:when test="starts-with($replace,'{')">
                        <XSL:sequence select="tei:makeExpan('lowerterm',translate($replace,'{}',''))"/>
                     </XSL:when>
                     <XSL:otherwise>
                        <XSL:sequence select="tei:makeG('lowerterm',$replace)"/>
                     </XSL:otherwise>
                  </XSL:choose>
               </XSL:when>
               <XSL:when test="regex-group(1)='lowerthan'">
                  <XSL:variable name="replace">∨</XSL:variable>
                  <XSL:choose>
                     <XSL:when test="not($usemarkup)">
                        <XSL:value-of select="$replace"/>
                     </XSL:when>
                     <XSL:when test="starts-with($replace,'{')">
                        <XSL:sequence select="tei:makeExpan('lowerthan',translate($replace,'{}',''))"/>
                     </XSL:when>
                     <XSL:otherwise>
                        <XSL:sequence select="tei:makeG('lowerthan',$replace)"/>
                     </XSL:otherwise>
                  </XSL:choose>
               </XSL:when>
               <XSL:when test="regex-group(1)='lpunctel'">
                  <XSL:variable name="replace">؛</XSL:variable>
                  <XSL:choose>
                     <XSL:when test="not($usemarkup)">
                        <XSL:value-of select="$replace"/>
                     </XSL:when>
                     <XSL:when test="starts-with($replace,'{')">
                        <XSL:sequence select="tei:makeExpan('lpunctel',translate($replace,'{}',''))"/>
                     </XSL:when>
                     <XSL:otherwise>
                        <XSL:sequence select="tei:makeG('lpunctel',$replace)"/>
                     </XSL:otherwise>
                  </XSL:choose>
               </XSL:when>
               <XSL:when test="regex-group(1)='lquest'">
                  <XSL:variable name="replace">{reversed ?}</XSL:variable>
                  <XSL:choose>
                     <XSL:when test="not($usemarkup)">
                        <XSL:value-of select="$replace"/>
                     </XSL:when>
                     <XSL:when test="starts-with($replace,'{')">
                        <XSL:sequence select="tei:makeExpan('lquest',translate($replace,'{}',''))"/>
                     </XSL:when>
                     <XSL:otherwise>
                        <XSL:sequence select="tei:makeG('lquest',$replace)"/>
                     </XSL:otherwise>
                  </XSL:choose>
               </XSL:when>
               <XSL:when test="regex-group(1)='magnesia'">
                  <XSL:variable name="replace">○→</XSL:variable>
                  <XSL:choose>
                     <XSL:when test="not($usemarkup)">
                        <XSL:value-of select="$replace"/>
                     </XSL:when>
                     <XSL:when test="starts-with($replace,'{')">
                        <XSL:sequence select="tei:makeExpan('magnesia',translate($replace,'{}',''))"/>
                     </XSL:when>
                     <XSL:otherwise>
                        <XSL:sequence select="tei:makeG('magnesia',$replace)"/>
                     </XSL:otherwise>
                  </XSL:choose>
               </XSL:when>
               <XSL:when test="regex-group(1)='male'">
                  <XSL:variable name="replace">♂</XSL:variable>
                  <XSL:choose>
                     <XSL:when test="not($usemarkup)">
                        <XSL:value-of select="$replace"/>
                     </XSL:when>
                     <XSL:when test="starts-with($replace,'{')">
                        <XSL:sequence select="tei:makeExpan('male',translate($replace,'{}',''))"/>
                     </XSL:when>
                     <XSL:otherwise>
                        <XSL:sequence select="tei:makeG('male',$replace)"/>
                     </XSL:otherwise>
                  </XSL:choose>
               </XSL:when>
               <XSL:when test="regex-group(1)='minim'">
                  <XSL:variable name="replace">♏</XSL:variable>
                  <XSL:choose>
                     <XSL:when test="not($usemarkup)">
                        <XSL:value-of select="$replace"/>
                     </XSL:when>
                     <XSL:when test="starts-with($replace,'{')">
                        <XSL:sequence select="tei:makeExpan('minim',translate($replace,'{}',''))"/>
                     </XSL:when>
                     <XSL:otherwise>
                        <XSL:sequence select="tei:makeG('minim',$replace)"/>
                     </XSL:otherwise>
                  </XSL:choose>
               </XSL:when>
               <XSL:when test="regex-group(1)='minim2'">
                  <XSL:variable name="replace">♍</XSL:variable>
                  <XSL:choose>
                     <XSL:when test="not($usemarkup)">
                        <XSL:value-of select="$replace"/>
                     </XSL:when>
                     <XSL:when test="starts-with($replace,'{')">
                        <XSL:sequence select="tei:makeExpan('minim2',translate($replace,'{}',''))"/>
                     </XSL:when>
                     <XSL:otherwise>
                        <XSL:sequence select="tei:makeG('minim2',$replace)"/>
                     </XSL:otherwise>
                  </XSL:choose>
               </XSL:when>
               <XSL:when test="regex-group(1)='morethan'">
                  <XSL:variable name="replace">›</XSL:variable>
                  <XSL:choose>
                     <XSL:when test="not($usemarkup)">
                        <XSL:value-of select="$replace"/>
                     </XSL:when>
                     <XSL:when test="starts-with($replace,'{')">
                        <XSL:sequence select="tei:makeExpan('morethan',translate($replace,'{}',''))"/>
                     </XSL:when>
                     <XSL:otherwise>
                        <XSL:sequence select="tei:makeG('morethan',$replace)"/>
                     </XSL:otherwise>
                  </XSL:choose>
               </XSL:when>
               <XSL:when test="regex-group(1)='multiplier'">
                  <XSL:variable name="replace">{multiplier}</XSL:variable>
                  <XSL:choose>
                     <XSL:when test="not($usemarkup)">
                        <XSL:value-of select="$replace"/>
                     </XSL:when>
                     <XSL:when test="starts-with($replace,'{')">
                        <XSL:sequence select="tei:makeExpan('multiplier',translate($replace,'{}',''))"/>
                     </XSL:when>
                     <XSL:otherwise>
                        <XSL:sequence select="tei:makeG('multiplier',$replace)"/>
                     </XSL:otherwise>
                  </XSL:choose>
               </XSL:when>
               <XSL:when test="regex-group(1)='musicNote'">
                  <XSL:variable name="replace">♩</XSL:variable>
                  <XSL:choose>
                     <XSL:when test="not($usemarkup)">
                        <XSL:value-of select="$replace"/>
                     </XSL:when>
                     <XSL:when test="starts-with($replace,'{')">
                        <XSL:sequence select="tei:makeExpan('musicNote',translate($replace,'{}',''))"/>
                     </XSL:when>
                     <XSL:otherwise>
                        <XSL:sequence select="tei:makeG('musicNote',$replace)"/>
                     </XSL:otherwise>
                  </XSL:choose>
               </XSL:when>
               <XSL:when test="regex-group(1)='notedemisemiquaver'">
                  <XSL:variable name="replace">{demisemiquaver note}</XSL:variable>
                  <XSL:choose>
                     <XSL:when test="not($usemarkup)">
                        <XSL:value-of select="$replace"/>
                     </XSL:when>
                     <XSL:when test="starts-with($replace,'{')">
                        <XSL:sequence select="tei:makeExpan('notedemisemiquaver',translate($replace,'{}',''))"/>
                     </XSL:when>
                     <XSL:otherwise>
                        <XSL:sequence select="tei:makeG('notedemisemiquaver',$replace)"/>
                     </XSL:otherwise>
                  </XSL:choose>
               </XSL:when>
               <XSL:when test="regex-group(1)='oil2'">
                  <XSL:variable name="replace">⦾</XSL:variable>
                  <XSL:choose>
                     <XSL:when test="not($usemarkup)">
                        <XSL:value-of select="$replace"/>
                     </XSL:when>
                     <XSL:when test="starts-with($replace,'{')">
                        <XSL:sequence select="tei:makeExpan('oil2',translate($replace,'{}',''))"/>
                     </XSL:when>
                     <XSL:otherwise>
                        <XSL:sequence select="tei:makeG('oil2',$replace)"/>
                     </XSL:otherwise>
                  </XSL:choose>
               </XSL:when>
               <XSL:when test="regex-group(1)='ougr'">
                  <XSL:variable name="replace">ȣ</XSL:variable>
                  <XSL:choose>
                     <XSL:when test="not($usemarkup)">
                        <XSL:value-of select="$replace"/>
                     </XSL:when>
                     <XSL:when test="starts-with($replace,'{')">
                        <XSL:sequence select="tei:makeExpan('ougr',translate($replace,'{}',''))"/>
                     </XSL:when>
                     <XSL:otherwise>
                        <XSL:sequence select="tei:makeG('ougr',$replace)"/>
                     </XSL:otherwise>
                  </XSL:choose>
               </XSL:when>
               <XSL:when test="regex-group(1)='pashtayin'">
                  <XSL:variable name="replace">֙ ֨</XSL:variable>
                  <XSL:choose>
                     <XSL:when test="not($usemarkup)">
                        <XSL:value-of select="$replace"/>
                     </XSL:when>
                     <XSL:when test="starts-with($replace,'{')">
                        <XSL:sequence select="tei:makeExpan('pashtayin',translate($replace,'{}',''))"/>
                     </XSL:when>
                     <XSL:otherwise>
                        <XSL:sequence select="tei:makeG('pashtayin',$replace)"/>
                     </XSL:otherwise>
                  </XSL:choose>
               </XSL:when>
               <XSL:when test="regex-group(1)='potestas'">
                  <XSL:variable name="replace">{potestas}</XSL:variable>
                  <XSL:choose>
                     <XSL:when test="not($usemarkup)">
                        <XSL:value-of select="$replace"/>
                     </XSL:when>
                     <XSL:when test="starts-with($replace,'{')">
                        <XSL:sequence select="tei:makeExpan('potestas',translate($replace,'{}',''))"/>
                     </XSL:when>
                     <XSL:otherwise>
                        <XSL:sequence select="tei:makeG('potestas',$replace)"/>
                     </XSL:otherwise>
                  </XSL:choose>
               </XSL:when>
               <XSL:when test="regex-group(1)='powerof1'">
                  <XSL:variable name="replace">{powerof1}</XSL:variable>
                  <XSL:choose>
                     <XSL:when test="not($usemarkup)">
                        <XSL:value-of select="$replace"/>
                     </XSL:when>
                     <XSL:when test="starts-with($replace,'{')">
                        <XSL:sequence select="tei:makeExpan('powerof1',translate($replace,'{}',''))"/>
                     </XSL:when>
                     <XSL:otherwise>
                        <XSL:sequence select="tei:makeG('powerof1',$replace)"/>
                     </XSL:otherwise>
                  </XSL:choose>
               </XSL:when>
               <XSL:when test="regex-group(1)='powerof2'">
                  <XSL:variable name="replace">{powerof2}</XSL:variable>
                  <XSL:choose>
                     <XSL:when test="not($usemarkup)">
                        <XSL:value-of select="$replace"/>
                     </XSL:when>
                     <XSL:when test="starts-with($replace,'{')">
                        <XSL:sequence select="tei:makeExpan('powerof2',translate($replace,'{}',''))"/>
                     </XSL:when>
                     <XSL:otherwise>
                        <XSL:sequence select="tei:makeG('powerof2',$replace)"/>
                     </XSL:otherwise>
                  </XSL:choose>
               </XSL:when>
               <XSL:when test="regex-group(1)='powerof3'">
                  <XSL:variable name="replace">{powerof3}</XSL:variable>
                  <XSL:choose>
                     <XSL:when test="not($usemarkup)">
                        <XSL:value-of select="$replace"/>
                     </XSL:when>
                     <XSL:when test="starts-with($replace,'{')">
                        <XSL:sequence select="tei:makeExpan('powerof3',translate($replace,'{}',''))"/>
                     </XSL:when>
                     <XSL:otherwise>
                        <XSL:sequence select="tei:makeG('powerof3',$replace)"/>
                     </XSL:otherwise>
                  </XSL:choose>
               </XSL:when>
               <XSL:when test="regex-group(1)='powerof4'">
                  <XSL:variable name="replace">{powerof4}</XSL:variable>
                  <XSL:choose>
                     <XSL:when test="not($usemarkup)">
                        <XSL:value-of select="$replace"/>
                     </XSL:when>
                     <XSL:when test="starts-with($replace,'{')">
                        <XSL:sequence select="tei:makeExpan('powerof4',translate($replace,'{}',''))"/>
                     </XSL:when>
                     <XSL:otherwise>
                        <XSL:sequence select="tei:makeG('powerof4',$replace)"/>
                     </XSL:otherwise>
                  </XSL:choose>
               </XSL:when>
               <XSL:when test="regex-group(1)='powerof5'">
                  <XSL:variable name="replace">{powerof5}</XSL:variable>
                  <XSL:choose>
                     <XSL:when test="not($usemarkup)">
                        <XSL:value-of select="$replace"/>
                     </XSL:when>
                     <XSL:when test="starts-with($replace,'{')">
                        <XSL:sequence select="tei:makeExpan('powerof5',translate($replace,'{}',''))"/>
                     </XSL:when>
                     <XSL:otherwise>
                        <XSL:sequence select="tei:makeG('powerof5',$replace)"/>
                     </XSL:otherwise>
                  </XSL:choose>
               </XSL:when>
               <XSL:when test="regex-group(1)='powerof6'">
                  <XSL:variable name="replace">{powerof6}</XSL:variable>
                  <XSL:choose>
                     <XSL:when test="not($usemarkup)">
                        <XSL:value-of select="$replace"/>
                     </XSL:when>
                     <XSL:when test="starts-with($replace,'{')">
                        <XSL:sequence select="tei:makeExpan('powerof6',translate($replace,'{}',''))"/>
                     </XSL:when>
                     <XSL:otherwise>
                        <XSL:sequence select="tei:makeG('powerof6',$replace)"/>
                     </XSL:otherwise>
                  </XSL:choose>
               </XSL:when>
               <XSL:when test="regex-group(1)='pprime'">
                  <XSL:variable name="replace">'''''</XSL:variable>
                  <XSL:choose>
                     <XSL:when test="not($usemarkup)">
                        <XSL:value-of select="$replace"/>
                     </XSL:when>
                     <XSL:when test="starts-with($replace,'{')">
                        <XSL:sequence select="tei:makeExpan('pprime',translate($replace,'{}',''))"/>
                     </XSL:when>
                     <XSL:otherwise>
                        <XSL:sequence select="tei:makeG('pprime',$replace)"/>
                     </XSL:otherwise>
                  </XSL:choose>
               </XSL:when>
               <XSL:when test="regex-group(1)='product'">
                  <XSL:variable name="replace">{product}</XSL:variable>
                  <XSL:choose>
                     <XSL:when test="not($usemarkup)">
                        <XSL:value-of select="$replace"/>
                     </XSL:when>
                     <XSL:when test="starts-with($replace,'{')">
                        <XSL:sequence select="tei:makeExpan('product',translate($replace,'{}',''))"/>
                     </XSL:when>
                     <XSL:otherwise>
                        <XSL:sequence select="tei:makeG('product',$replace)"/>
                     </XSL:otherwise>
                  </XSL:choose>
               </XSL:when>
               <XSL:when test="regex-group(1)='proportion2'">
                  <XSL:variable name="replace">∝</XSL:variable>
                  <XSL:choose>
                     <XSL:when test="not($usemarkup)">
                        <XSL:value-of select="$replace"/>
                     </XSL:when>
                     <XSL:when test="starts-with($replace,'{')">
                        <XSL:sequence select="tei:makeExpan('proportion2',translate($replace,'{}',''))"/>
                     </XSL:when>
                     <XSL:otherwise>
                        <XSL:sequence select="tei:makeG('proportion2',$replace)"/>
                     </XSL:otherwise>
                  </XSL:choose>
               </XSL:when>
               <XSL:when test="regex-group(1)='punc'">
                  <XSL:variable name="replace">▪</XSL:variable>
                  <XSL:choose>
                     <XSL:when test="not($usemarkup)">
                        <XSL:value-of select="$replace"/>
                     </XSL:when>
                     <XSL:when test="starts-with($replace,'{')">
                        <XSL:sequence select="tei:makeExpan('punc',translate($replace,'{}',''))"/>
                     </XSL:when>
                     <XSL:otherwise>
                        <XSL:sequence select="tei:makeG('punc',$replace)"/>
                     </XSL:otherwise>
                  </XSL:choose>
               </XSL:when>
               <XSL:when test="regex-group(1)='punctel'">
                  <XSL:variable name="replace">{punctel}</XSL:variable>
                  <XSL:choose>
                     <XSL:when test="not($usemarkup)">
                        <XSL:value-of select="$replace"/>
                     </XSL:when>
                     <XSL:when test="starts-with($replace,'{')">
                        <XSL:sequence select="tei:makeExpan('punctel',translate($replace,'{}',''))"/>
                     </XSL:when>
                     <XSL:otherwise>
                        <XSL:sequence select="tei:makeG('punctel',$replace)"/>
                     </XSL:otherwise>
                  </XSL:choose>
               </XSL:when>
               <XSL:when test="regex-group(1)='qprime'">
                  <XSL:variable name="replace">''''</XSL:variable>
                  <XSL:choose>
                     <XSL:when test="not($usemarkup)">
                        <XSL:value-of select="$replace"/>
                     </XSL:when>
                     <XSL:when test="starts-with($replace,'{')">
                        <XSL:sequence select="tei:makeExpan('qprime',translate($replace,'{}',''))"/>
                     </XSL:when>
                     <XSL:otherwise>
                        <XSL:sequence select="tei:makeG('qprime',$replace)"/>
                     </XSL:otherwise>
                  </XSL:choose>
               </XSL:when>
               <XSL:when test="regex-group(1)='quaddotl'">
                  <XSL:variable name="replace">˙.˙.</XSL:variable>
                  <XSL:choose>
                     <XSL:when test="not($usemarkup)">
                        <XSL:value-of select="$replace"/>
                     </XSL:when>
                     <XSL:when test="starts-with($replace,'{')">
                        <XSL:sequence select="tei:makeExpan('quaddotl',translate($replace,'{}',''))"/>
                     </XSL:when>
                     <XSL:otherwise>
                        <XSL:sequence select="tei:makeG('quaddotl',$replace)"/>
                     </XSL:otherwise>
                  </XSL:choose>
               </XSL:when>
               <XSL:when test="regex-group(1)='quaddotr'">
                  <XSL:variable name="replace">.˙.˙</XSL:variable>
                  <XSL:choose>
                     <XSL:when test="not($usemarkup)">
                        <XSL:value-of select="$replace"/>
                     </XSL:when>
                     <XSL:when test="starts-with($replace,'{')">
                        <XSL:sequence select="tei:makeExpan('quaddotr',translate($replace,'{}',''))"/>
                     </XSL:when>
                     <XSL:otherwise>
                        <XSL:sequence select="tei:makeG('quaddotr',$replace)"/>
                     </XSL:otherwise>
                  </XSL:choose>
               </XSL:when>
               <XSL:when test="regex-group(1)='quadrine'">
                  <XSL:variable name="replace">□</XSL:variable>
                  <XSL:choose>
                     <XSL:when test="not($usemarkup)">
                        <XSL:value-of select="$replace"/>
                     </XSL:when>
                     <XSL:when test="starts-with($replace,'{')">
                        <XSL:sequence select="tei:makeExpan('quadrine',translate($replace,'{}',''))"/>
                     </XSL:when>
                     <XSL:otherwise>
                        <XSL:sequence select="tei:makeG('quadrine',$replace)"/>
                     </XSL:otherwise>
                  </XSL:choose>
               </XSL:when>
               <XSL:when test="regex-group(1)='quotient'">
                  <XSL:variable name="replace">{quotient}</XSL:variable>
                  <XSL:choose>
                     <XSL:when test="not($usemarkup)">
                        <XSL:value-of select="$replace"/>
                     </XSL:when>
                     <XSL:when test="starts-with($replace,'{')">
                        <XSL:sequence select="tei:makeExpan('quotient',translate($replace,'{}',''))"/>
                     </XSL:when>
                     <XSL:otherwise>
                        <XSL:sequence select="tei:makeG('quotient',$replace)"/>
                     </XSL:otherwise>
                  </XSL:choose>
               </XSL:when>
               <XSL:when test="regex-group(1)='ration'">
                  <XSL:variable name="replace">ℛ</XSL:variable>
                  <XSL:choose>
                     <XSL:when test="not($usemarkup)">
                        <XSL:value-of select="$replace"/>
                     </XSL:when>
                     <XSL:when test="starts-with($replace,'{')">
                        <XSL:sequence select="tei:makeExpan('ration',translate($replace,'{}',''))"/>
                     </XSL:when>
                     <XSL:otherwise>
                        <XSL:sequence select="tei:makeG('ration',$replace)"/>
                     </XSL:otherwise>
                  </XSL:choose>
               </XSL:when>
               <XSL:when test="regex-group(1)='rdagger'">
                  <XSL:variable name="replace">{right †}</XSL:variable>
                  <XSL:choose>
                     <XSL:when test="not($usemarkup)">
                        <XSL:value-of select="$replace"/>
                     </XSL:when>
                     <XSL:when test="starts-with($replace,'{')">
                        <XSL:sequence select="tei:makeExpan('rdagger',translate($replace,'{}',''))"/>
                     </XSL:when>
                     <XSL:otherwise>
                        <XSL:sequence select="tei:makeG('rdagger',$replace)"/>
                     </XSL:otherwise>
                  </XSL:choose>
               </XSL:when>
               <XSL:when test="regex-group(1)='rdiple'">
                  <XSL:variable name="replace">›</XSL:variable>
                  <XSL:choose>
                     <XSL:when test="not($usemarkup)">
                        <XSL:value-of select="$replace"/>
                     </XSL:when>
                     <XSL:when test="starts-with($replace,'{')">
                        <XSL:sequence select="tei:makeExpan('rdiple',translate($replace,'{}',''))"/>
                     </XSL:when>
                     <XSL:otherwise>
                        <XSL:sequence select="tei:makeG('rdiple',$replace)"/>
                     </XSL:otherwise>
                  </XSL:choose>
               </XSL:when>
               <XSL:when test="regex-group(1)='repeat'">
                  <XSL:variable name="replace">{repeat}</XSL:variable>
                  <XSL:choose>
                     <XSL:when test="not($usemarkup)">
                        <XSL:value-of select="$replace"/>
                     </XSL:when>
                     <XSL:when test="starts-with($replace,'{')">
                        <XSL:sequence select="tei:makeExpan('repeat',translate($replace,'{}',''))"/>
                     </XSL:when>
                     <XSL:otherwise>
                        <XSL:sequence select="tei:makeG('repeat',$replace)"/>
                     </XSL:otherwise>
                  </XSL:choose>
               </XSL:when>
               <XSL:when test="regex-group(1)='restdemisemiquaver'">
                  <XSL:variable name="replace">{demisemiquaver rest}</XSL:variable>
                  <XSL:choose>
                     <XSL:when test="not($usemarkup)">
                        <XSL:value-of select="$replace"/>
                     </XSL:when>
                     <XSL:when test="starts-with($replace,'{')">
                        <XSL:sequence select="tei:makeExpan('restdemisemiquaver',translate($replace,'{}',''))"/>
                     </XSL:when>
                     <XSL:otherwise>
                        <XSL:sequence select="tei:makeG('restdemisemiquaver',$replace)"/>
                     </XSL:otherwise>
                  </XSL:choose>
               </XSL:when>
               <XSL:when test="regex-group(1)='restquaver'">
                  <XSL:variable name="replace">{quaver rest}</XSL:variable>
                  <XSL:choose>
                     <XSL:when test="not($usemarkup)">
                        <XSL:value-of select="$replace"/>
                     </XSL:when>
                     <XSL:when test="starts-with($replace,'{')">
                        <XSL:sequence select="tei:makeExpan('restquaver',translate($replace,'{}',''))"/>
                     </XSL:when>
                     <XSL:otherwise>
                        <XSL:sequence select="tei:makeG('restquaver',$replace)"/>
                     </XSL:otherwise>
                  </XSL:choose>
               </XSL:when>
               <XSL:when test="regex-group(1)='restsemiquaver'">
                  <XSL:variable name="replace">{semiquaver rest}</XSL:variable>
                  <XSL:choose>
                     <XSL:when test="not($usemarkup)">
                        <XSL:value-of select="$replace"/>
                     </XSL:when>
                     <XSL:when test="starts-with($replace,'{')">
                        <XSL:sequence select="tei:makeExpan('restsemiquaver',translate($replace,'{}',''))"/>
                     </XSL:when>
                     <XSL:otherwise>
                        <XSL:sequence select="tei:makeG('restsemiquaver',$replace)"/>
                     </XSL:otherwise>
                  </XSL:choose>
               </XSL:when>
               <XSL:when test="regex-group(1)='rhalfcross'">
                  <XSL:variable name="replace">⊣</XSL:variable>
                  <XSL:choose>
                     <XSL:when test="not($usemarkup)">
                        <XSL:value-of select="$replace"/>
                     </XSL:when>
                     <XSL:when test="starts-with($replace,'{')">
                        <XSL:sequence select="tei:makeExpan('rhalfcross',translate($replace,'{}',''))"/>
                     </XSL:when>
                     <XSL:otherwise>
                        <XSL:sequence select="tei:makeG('rhalfcross',$replace)"/>
                     </XSL:otherwise>
                  </XSL:choose>
               </XSL:when>
               <XSL:when test="regex-group(1)='rn1000000'">
                  <XSL:variable name="replace">{roman 1000000}</XSL:variable>
                  <XSL:choose>
                     <XSL:when test="not($usemarkup)">
                        <XSL:value-of select="$replace"/>
                     </XSL:when>
                     <XSL:when test="starts-with($replace,'{')">
                        <XSL:sequence select="tei:makeExpan('rn1000000',translate($replace,'{}',''))"/>
                     </XSL:when>
                     <XSL:otherwise>
                        <XSL:sequence select="tei:makeG('rn1000000',$replace)"/>
                     </XSL:otherwise>
                  </XSL:choose>
               </XSL:when>
               <XSL:when test="regex-group(1)='rn500000'">
                  <XSL:variable name="replace">{roman 500000}</XSL:variable>
                  <XSL:choose>
                     <XSL:when test="not($usemarkup)">
                        <XSL:value-of select="$replace"/>
                     </XSL:when>
                     <XSL:when test="starts-with($replace,'{')">
                        <XSL:sequence select="tei:makeExpan('rn500000',translate($replace,'{}',''))"/>
                     </XSL:when>
                     <XSL:otherwise>
                        <XSL:sequence select="tei:makeG('rn500000',$replace)"/>
                     </XSL:otherwise>
                  </XSL:choose>
               </XSL:when>
               <XSL:when test="regex-group(1)='root'">
                  <XSL:variable name="replace">ℛ</XSL:variable>
                  <XSL:choose>
                     <XSL:when test="not($usemarkup)">
                        <XSL:value-of select="$replace"/>
                     </XSL:when>
                     <XSL:when test="starts-with($replace,'{')">
                        <XSL:sequence select="tei:makeExpan('root',translate($replace,'{}',''))"/>
                     </XSL:when>
                     <XSL:otherwise>
                        <XSL:sequence select="tei:makeG('root',$replace)"/>
                     </XSL:otherwise>
                  </XSL:choose>
               </XSL:when>
               <XSL:when test="regex-group(1)='rsect'">
                  <XSL:variable name="replace">{reversed §}</XSL:variable>
                  <XSL:choose>
                     <XSL:when test="not($usemarkup)">
                        <XSL:value-of select="$replace"/>
                     </XSL:when>
                     <XSL:when test="starts-with($replace,'{')">
                        <XSL:sequence select="tei:makeExpan('rsect',translate($replace,'{}',''))"/>
                     </XSL:when>
                     <XSL:otherwise>
                        <XSL:sequence select="tei:makeG('rsect',$replace)"/>
                     </XSL:otherwise>
                  </XSL:choose>
               </XSL:when>
               <XSL:when test="regex-group(1)='salarmon2'">
                  <XSL:variable name="replace">⊕</XSL:variable>
                  <XSL:choose>
                     <XSL:when test="not($usemarkup)">
                        <XSL:value-of select="$replace"/>
                     </XSL:when>
                     <XSL:when test="starts-with($replace,'{')">
                        <XSL:sequence select="tei:makeExpan('salarmon2',translate($replace,'{}',''))"/>
                     </XSL:when>
                     <XSL:otherwise>
                        <XSL:sequence select="tei:makeG('salarmon2',$replace)"/>
                     </XSL:otherwise>
                  </XSL:choose>
               </XSL:when>
               <XSL:when test="regex-group(1)='sharp2'">
                  <XSL:variable name="replace">♯</XSL:variable>
                  <XSL:choose>
                     <XSL:when test="not($usemarkup)">
                        <XSL:value-of select="$replace"/>
                     </XSL:when>
                     <XSL:when test="starts-with($replace,'{')">
                        <XSL:sequence select="tei:makeExpan('sharp2',translate($replace,'{}',''))"/>
                     </XSL:when>
                     <XSL:otherwise>
                        <XSL:sequence select="tei:makeG('sharp2',$replace)"/>
                     </XSL:otherwise>
                  </XSL:choose>
               </XSL:when>
               <XSL:when test="regex-group(1)='sharpb'">
                  <XSL:variable name="replace">{sharpb}</XSL:variable>
                  <XSL:choose>
                     <XSL:when test="not($usemarkup)">
                        <XSL:value-of select="$replace"/>
                     </XSL:when>
                     <XSL:when test="starts-with($replace,'{')">
                        <XSL:sequence select="tei:makeExpan('sharpb',translate($replace,'{}',''))"/>
                     </XSL:when>
                     <XSL:otherwise>
                        <XSL:sequence select="tei:makeG('sharpb',$replace)"/>
                     </XSL:otherwise>
                  </XSL:choose>
               </XSL:when>
               <XSL:when test="regex-group(1)='shilling'">
                  <XSL:variable name="replace">ʃ</XSL:variable>
                  <XSL:choose>
                     <XSL:when test="not($usemarkup)">
                        <XSL:value-of select="$replace"/>
                     </XSL:when>
                     <XSL:when test="starts-with($replace,'{')">
                        <XSL:sequence select="tei:makeExpan('shilling',translate($replace,'{}',''))"/>
                     </XSL:when>
                     <XSL:otherwise>
                        <XSL:sequence select="tei:makeG('shilling',$replace)"/>
                     </XSL:otherwise>
                  </XSL:choose>
               </XSL:when>
               <XSL:when test="regex-group(1)='sloop'">
                  <XSL:variable name="replace">s̄</XSL:variable>
                  <XSL:choose>
                     <XSL:when test="not($usemarkup)">
                        <XSL:value-of select="$replace"/>
                     </XSL:when>
                     <XSL:when test="starts-with($replace,'{')">
                        <XSL:sequence select="tei:makeExpan('sloop',translate($replace,'{}',''))"/>
                     </XSL:when>
                     <XSL:otherwise>
                        <XSL:sequence select="tei:makeG('sloop',$replace)"/>
                     </XSL:otherwise>
                  </XSL:choose>
               </XSL:when>
               <XSL:when test="regex-group(1)='spcdotb'">
                  <XSL:variable name="replace">․</XSL:variable>
                  <XSL:choose>
                     <XSL:when test="not($usemarkup)">
                        <XSL:value-of select="$replace"/>
                     </XSL:when>
                     <XSL:when test="starts-with($replace,'{')">
                        <XSL:sequence select="tei:makeExpan('spcdotb',translate($replace,'{}',''))"/>
                     </XSL:when>
                     <XSL:otherwise>
                        <XSL:sequence select="tei:makeG('spcdotb',$replace)"/>
                     </XSL:otherwise>
                  </XSL:choose>
               </XSL:when>
               <XSL:when test="regex-group(1)='startq'">
                  <XSL:variable name="replace">“</XSL:variable>
                  <XSL:choose>
                     <XSL:when test="not($usemarkup)">
                        <XSL:value-of select="$replace"/>
                     </XSL:when>
                     <XSL:when test="starts-with($replace,'{')">
                        <XSL:sequence select="tei:makeExpan('startq',translate($replace,'{}',''))"/>
                     </XSL:when>
                     <XSL:otherwise>
                        <XSL:sequence select="tei:makeG('startq',$replace)"/>
                     </XSL:otherwise>
                  </XSL:choose>
               </XSL:when>
               <XSL:when test="regex-group(1)='stella'">
                  <XSL:variable name="replace">✴</XSL:variable>
                  <XSL:choose>
                     <XSL:when test="not($usemarkup)">
                        <XSL:value-of select="$replace"/>
                     </XSL:when>
                     <XSL:when test="starts-with($replace,'{')">
                        <XSL:sequence select="tei:makeExpan('stella',translate($replace,'{}',''))"/>
                     </XSL:when>
                     <XSL:otherwise>
                        <XSL:sequence select="tei:makeG('stella',$replace)"/>
                     </XSL:otherwise>
                  </XSL:choose>
               </XSL:when>
               <XSL:when test="regex-group(1)='talc'">
                  <XSL:variable name="replace">{talc}</XSL:variable>
                  <XSL:choose>
                     <XSL:when test="not($usemarkup)">
                        <XSL:value-of select="$replace"/>
                     </XSL:when>
                     <XSL:when test="starts-with($replace,'{')">
                        <XSL:sequence select="tei:makeExpan('talc',translate($replace,'{}',''))"/>
                     </XSL:when>
                     <XSL:otherwise>
                        <XSL:sequence select="tei:makeG('talc',$replace)"/>
                     </XSL:otherwise>
                  </XSL:choose>
               </XSL:when>
               <XSL:when test="regex-group(1)='tdagger'">
                  <XSL:variable name="replace">‡̶</XSL:variable>
                  <XSL:choose>
                     <XSL:when test="not($usemarkup)">
                        <XSL:value-of select="$replace"/>
                     </XSL:when>
                     <XSL:when test="starts-with($replace,'{')">
                        <XSL:sequence select="tei:makeExpan('tdagger',translate($replace,'{}',''))"/>
                     </XSL:when>
                     <XSL:otherwise>
                        <XSL:sequence select="tei:makeG('tdagger',$replace)"/>
                     </XSL:otherwise>
                  </XSL:choose>
               </XSL:when>
               <XSL:when test="regex-group(1)='timeimperf-prolatimperf-x'">
                  <XSL:variable name="replace">{timeimperf-prolatimperf-x}</XSL:variable>
                  <XSL:choose>
                     <XSL:when test="not($usemarkup)">
                        <XSL:value-of select="$replace"/>
                     </XSL:when>
                     <XSL:when test="starts-with($replace,'{')">
                        <XSL:sequence select="tei:makeExpan('timeimperf-prolatimperf-x',translate($replace,'{}',''))"/>
                     </XSL:when>
                     <XSL:otherwise>
                        <XSL:sequence select="tei:makeG('timeimperf-prolatimperf-x',$replace)"/>
                     </XSL:otherwise>
                  </XSL:choose>
               </XSL:when>
               <XSL:when test="regex-group(1)='timeimperf-prolatperf-rev'">
                  <XSL:variable name="replace">{timeimperf-prolatperf-rev}</XSL:variable>
                  <XSL:choose>
                     <XSL:when test="not($usemarkup)">
                        <XSL:value-of select="$replace"/>
                     </XSL:when>
                     <XSL:when test="starts-with($replace,'{')">
                        <XSL:sequence select="tei:makeExpan('timeimperf-prolatperf-rev',translate($replace,'{}',''))"/>
                     </XSL:when>
                     <XSL:otherwise>
                        <XSL:sequence select="tei:makeG('timeimperf-prolatperf-rev',$replace)"/>
                     </XSL:otherwise>
                  </XSL:choose>
               </XSL:when>
               <XSL:when test="regex-group(1)='timeimperf-prolatperf-rev-str'">
                  <XSL:variable name="replace">{timeimperf-prolatperf-rev-str}</XSL:variable>
                  <XSL:choose>
                     <XSL:when test="not($usemarkup)">
                        <XSL:value-of select="$replace"/>
                     </XSL:when>
                     <XSL:when test="starts-with($replace,'{')">
                        <XSL:sequence select="tei:makeExpan('timeimperf-prolatperf-rev-str',translate($replace,'{}',''))"/>
                     </XSL:when>
                     <XSL:otherwise>
                        <XSL:sequence select="tei:makeG('timeimperf-prolatperf-rev-str',$replace)"/>
                     </XSL:otherwise>
                  </XSL:choose>
               </XSL:when>
               <XSL:when test="regex-group(1)='timeimperf-prolatperf-str'">
                  <XSL:variable name="replace">{timeimperf-prolatperf-str}</XSL:variable>
                  <XSL:choose>
                     <XSL:when test="not($usemarkup)">
                        <XSL:value-of select="$replace"/>
                     </XSL:when>
                     <XSL:when test="starts-with($replace,'{')">
                        <XSL:sequence select="tei:makeExpan('timeimperf-prolatperf-str',translate($replace,'{}',''))"/>
                     </XSL:when>
                     <XSL:otherwise>
                        <XSL:sequence select="tei:makeG('timeimperf-prolatperf-str',$replace)"/>
                     </XSL:otherwise>
                  </XSL:choose>
               </XSL:when>
               <XSL:when test="regex-group(1)='timeperf-prolatimperf-str'">
                  <XSL:variable name="replace">{timeperf-prolatimperf-str}</XSL:variable>
                  <XSL:choose>
                     <XSL:when test="not($usemarkup)">
                        <XSL:value-of select="$replace"/>
                     </XSL:when>
                     <XSL:when test="starts-with($replace,'{')">
                        <XSL:sequence select="tei:makeExpan('timeperf-prolatimperf-str',translate($replace,'{}',''))"/>
                     </XSL:when>
                     <XSL:otherwise>
                        <XSL:sequence select="tei:makeG('timeperf-prolatimperf-str',$replace)"/>
                     </XSL:otherwise>
                  </XSL:choose>
               </XSL:when>
               <XSL:when test="regex-group(1)='timeperf-prolatimperf-x'">
                  <XSL:variable name="replace">{timeperf-prolatimperf-x}</XSL:variable>
                  <XSL:choose>
                     <XSL:when test="not($usemarkup)">
                        <XSL:value-of select="$replace"/>
                     </XSL:when>
                     <XSL:when test="starts-with($replace,'{')">
                        <XSL:sequence select="tei:makeExpan('timeperf-prolatimperf-x',translate($replace,'{}',''))"/>
                     </XSL:when>
                     <XSL:otherwise>
                        <XSL:sequence select="tei:makeG('timeperf-prolatimperf-x',$replace)"/>
                     </XSL:otherwise>
                  </XSL:choose>
               </XSL:when>
               <XSL:when test="regex-group(1)='timeperf-prolatperf-str'">
                  <XSL:variable name="replace">{timeperf-prolatperf-str}</XSL:variable>
                  <XSL:choose>
                     <XSL:when test="not($usemarkup)">
                        <XSL:value-of select="$replace"/>
                     </XSL:when>
                     <XSL:when test="starts-with($replace,'{')">
                        <XSL:sequence select="tei:makeExpan('timeperf-prolatperf-str',translate($replace,'{}',''))"/>
                     </XSL:when>
                     <XSL:otherwise>
                        <XSL:sequence select="tei:makeG('timeperf-prolatperf-str',$replace)"/>
                     </XSL:otherwise>
                  </XSL:choose>
               </XSL:when>
               <XSL:when test="regex-group(1)='trefoil'">
                  <XSL:variable name="replace">♣</XSL:variable>
                  <XSL:choose>
                     <XSL:when test="not($usemarkup)">
                        <XSL:value-of select="$replace"/>
                     </XSL:when>
                     <XSL:when test="starts-with($replace,'{')">
                        <XSL:sequence select="tei:makeExpan('trefoil',translate($replace,'{}',''))"/>
                     </XSL:when>
                     <XSL:otherwise>
                        <XSL:sequence select="tei:makeG('trefoil',$replace)"/>
                     </XSL:otherwise>
                  </XSL:choose>
               </XSL:when>
               <XSL:when test="regex-group(1)='triapost'">
                  <XSL:variable name="replace">','</XSL:variable>
                  <XSL:choose>
                     <XSL:when test="not($usemarkup)">
                        <XSL:value-of select="$replace"/>
                     </XSL:when>
                     <XSL:when test="starts-with($replace,'{')">
                        <XSL:sequence select="tei:makeExpan('triapost',translate($replace,'{}',''))"/>
                     </XSL:when>
                     <XSL:otherwise>
                        <XSL:sequence select="tei:makeG('triapost',$replace)"/>
                     </XSL:otherwise>
                  </XSL:choose>
               </XSL:when>
               <XSL:when test="regex-group(1)='trine'">
                  <XSL:variable name="replace">△</XSL:variable>
                  <XSL:choose>
                     <XSL:when test="not($usemarkup)">
                        <XSL:value-of select="$replace"/>
                     </XSL:when>
                     <XSL:when test="starts-with($replace,'{')">
                        <XSL:sequence select="tei:makeExpan('trine',translate($replace,'{}',''))"/>
                     </XSL:when>
                     <XSL:otherwise>
                        <XSL:sequence select="tei:makeG('trine',$replace)"/>
                     </XSL:otherwise>
                  </XSL:choose>
               </XSL:when>
               <XSL:when test="regex-group(1)='trine2'">
                  <XSL:variable name="replace">⊦</XSL:variable>
                  <XSL:choose>
                     <XSL:when test="not($usemarkup)">
                        <XSL:value-of select="$replace"/>
                     </XSL:when>
                     <XSL:when test="starts-with($replace,'{')">
                        <XSL:sequence select="tei:makeExpan('trine2',translate($replace,'{}',''))"/>
                     </XSL:when>
                     <XSL:otherwise>
                        <XSL:sequence select="tei:makeG('trine2',$replace)"/>
                     </XSL:otherwise>
                  </XSL:choose>
               </XSL:when>
               <XSL:when test="regex-group(1)='usd5'">
                  <XSL:variable name="replace">{inverted 5}</XSL:variable>
                  <XSL:choose>
                     <XSL:when test="not($usemarkup)">
                        <XSL:value-of select="$replace"/>
                     </XSL:when>
                     <XSL:when test="starts-with($replace,'{')">
                        <XSL:sequence select="tei:makeExpan('usd5',translate($replace,'{}',''))"/>
                     </XSL:when>
                     <XSL:otherwise>
                        <XSL:sequence select="tei:makeG('usd5',$replace)"/>
                     </XSL:otherwise>
                  </XSL:choose>
               </XSL:when>
               <XSL:when test="regex-group(1)='verdigris'">
                  <XSL:variable name="replace">{verdigris}</XSL:variable>
                  <XSL:choose>
                     <XSL:when test="not($usemarkup)">
                        <XSL:value-of select="$replace"/>
                     </XSL:when>
                     <XSL:when test="starts-with($replace,'{')">
                        <XSL:sequence select="tei:makeExpan('verdigris',translate($replace,'{}',''))"/>
                     </XSL:when>
                     <XSL:otherwise>
                        <XSL:sequence select="tei:makeG('verdigris',$replace)"/>
                     </XSL:otherwise>
                  </XSL:choose>
               </XSL:when>
               <XSL:when test="regex-group(1)='vitriol2'">
                  <XSL:variable name="replace">{vitriol}</XSL:variable>
                  <XSL:choose>
                     <XSL:when test="not($usemarkup)">
                        <XSL:value-of select="$replace"/>
                     </XSL:when>
                     <XSL:when test="starts-with($replace,'{')">
                        <XSL:sequence select="tei:makeExpan('vitriol2',translate($replace,'{}',''))"/>
                     </XSL:when>
                     <XSL:otherwise>
                        <XSL:sequence select="tei:makeG('vitriol2',$replace)"/>
                     </XSL:otherwise>
                  </XSL:choose>
               </XSL:when>
               <XSL:when test="regex-group(1)='vitriol3'">
                  <XSL:variable name="replace">{vitriol}</XSL:variable>
                  <XSL:choose>
                     <XSL:when test="not($usemarkup)">
                        <XSL:value-of select="$replace"/>
                     </XSL:when>
                     <XSL:when test="starts-with($replace,'{')">
                        <XSL:sequence select="tei:makeExpan('vitriol3',translate($replace,'{}',''))"/>
                     </XSL:when>
                     <XSL:otherwise>
                        <XSL:sequence select="tei:makeG('vitriol3',$replace)"/>
                     </XSL:otherwise>
                  </XSL:choose>
               </XSL:when>
               <XSL:when test="regex-group(1)='vocaljoin'">
                  <XSL:variable name="replace">{vocal join}</XSL:variable>
                  <XSL:choose>
                     <XSL:when test="not($usemarkup)">
                        <XSL:value-of select="$replace"/>
                     </XSL:when>
                     <XSL:when test="starts-with($replace,'{')">
                        <XSL:sequence select="tei:makeExpan('vocaljoin',translate($replace,'{}',''))"/>
                     </XSL:when>
                     <XSL:otherwise>
                        <XSL:sequence select="tei:makeG('vocaljoin',$replace)"/>
                     </XSL:otherwise>
                  </XSL:choose>
               </XSL:when>
               <XSL:when test="regex-group(1)='yhwh'">
                  <XSL:variable name="replace">יהוה</XSL:variable>
                  <XSL:choose>
                     <XSL:when test="not($usemarkup)">
                        <XSL:value-of select="$replace"/>
                     </XSL:when>
                     <XSL:when test="starts-with($replace,'{')">
                        <XSL:sequence select="tei:makeExpan('yhwh',translate($replace,'{}',''))"/>
                     </XSL:when>
                     <XSL:otherwise>
                        <XSL:sequence select="tei:makeG('yhwh',$replace)"/>
                     </XSL:otherwise>
                  </XSL:choose>
               </XSL:when>
            </XSL:choose>
         </XSL:matching-substring>
         <XSL:non-matching-substring>
            <XSL:value-of select="."/>
         </XSL:non-matching-substring>
      </XSL:analyze-string>
   </XSL:function>
   <XSL:function name="tei:makeG">
      <XSL:param name="char"/>
      <XSL:param name="replacement"/>
      <g ref="char:{$char}">
         <XSL:value-of select="$replacement"/>
      </g>
   </XSL:function>
   <XSL:function name="tei:makeExpan">
      <XSL:param name="char"/>
      <XSL:param name="replacement"/>
      <expan>
         <am>
            <g ref="char:{$char}"/>
         </am>
         <ex>
            <XSL:value-of select="$replacement"/>
         </ex>
      </expan>
   </XSL:function>
</XSL:stylesheet>
