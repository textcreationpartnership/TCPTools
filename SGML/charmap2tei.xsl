<?xml version="1.0" encoding="utf-8"?>
<XSL:stylesheet xmlns:tei="http://www.tei-c.org/ns/1.0" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns="http://www.tei-c.org/ns/1.0" xmlns:XSL="http://www.w3.org/1999/XSL/Transform" xmlns:xsl="http://www.w3.org/1999/XSL/TransformAlias" version="2.0">
  <!--
This software is dual-licensed:

1. Distributed under a Creative Commons Attribution-ShareAlike 3.0
Unported License http://creativecommons.org/licenses/by-sa/3.0/ 

2. http://www.opensource.org/licenses/BSD-2-Clause
		
Redistribution and use in source and binary forms, with or without
modification, are permitted provided that the following conditions are
met:

* Redistributions of source code must retain the above copyright
notice, this list of conditions and the following disclaimer.

* Redistributions in binary form must reproduce the above copyright
notice, this list of conditions and the following disclaimer in the
documentation and/or other materials provided with the distribution.

This software is provided by the copyright holders and contributors
"as is" and any express or implied warranties, including, but not
limited to, the implied warranties of merchantability and fitness for
a particular purpose are disclaimed. In no event shall the copyright
holder or contributors be liable for any direct, indirect, incidental,
special, exemplary, or consequential damages (including, but not
limited to, procurement of substitute goods or services; loss of use,
data, or profits; or business interruption) however caused and on any
theory of liability, whether in contract, strict liability, or tort
(including negligence or otherwise) arising in any way out of the use
of this software, even if advised of the possibility of such damage.

-->
  <XSL:namespace-alias stylesheet-prefix="xsl" result-prefix="XSL"/>
  <XSL:output indent="yes"/>
  <XSL:template match="/">
    <XSL:result-document href="tcpchars.xml">
      <TEI xmlns="http://www.tei-c.org/ns/1.0">
        <teiHeader>
          <fileDesc>
            <titleStmt>
              <title type="main">TCP characters</title>
              <editor>Paul Schaffner</editor>
            </titleStmt>
            <publicationStmt>
              <p>https://github.com/textcreationpartnership/TCPTools</p>
            </publicationStmt>
            <sourceDesc>
              <p>from charmap.sgm, maintained by TCP</p>
            </sourceDesc>
          </fileDesc>
          <encodingDesc>
            <XSL:for-each select="//char[equiv/@compat='pua' or @compat='partial']">
              <XSL:sort select="ent/@tcp"/>
              <charDecl>
                <XSL:for-each select="comment">
                  <desc>
                    <XSL:value-of select="."/>
                  </desc>
                </XSL:for-each>
                <char xml:id="{ent/@tcp}">
                  <XSL:for-each select="equiv/@desc">
                    <charName>
                      <XSL:value-of select="."/>
                    </charName>
                  </XSL:for-each>
                  <XSL:for-each select="repl">
                    <mapping type="{@sup}">
                      <XSL:value-of select="@txt"/>
                    </mapping>
                  </XSL:for-each>
                  <XSL:if test="equiv/@compat='pua'">
                    <mapping type="PUA">
                      <XSL:value-of disable-output-escaping="yes" select="tei:toEnt(equiv/@unic)"/>
                    </mapping>
                  </XSL:if>
                </char>
              </charDecl>
            </XSL:for-each>
          </encodingDesc>
        </teiHeader>
      </TEI>
    </XSL:result-document>
    <XSL:result-document href="cleantcp.xsl" method="xml">
      <xsl:stylesheet xmlns:tei="http://www.tei-c.org/ns/1.0" xmlns="" exclude-result-prefixes="tei xs" version="2.0">
        <xsl:template match="*">
          <xsl:copy>
            <xsl:apply-templates select="@*|*|processing-instruction()|comment()|text()"/>
          </xsl:copy>
        </xsl:template>
	<xsl:template match="ETS">
	  <xsl:copy>
	    <xsl:variable name="hfile" select="concat('./',//IDG/@ID,'.hdr')"/>
            <xsl:if test="doc-available($hfile)">
		<xsl:message> attempt to load header <xsl:value-of select="$hfile"/></xsl:message>
		<xsl:copy-of select="doc($hfile)/*"/>
	    </xsl:if>
            <xsl:apply-templates
		select="*|processing-instruction()|comment()|text()"/>
	  </xsl:copy>
	</xsl:template>

        <xsl:template match="LICENSE">
          <Q>
            <TEXT>
              <xsl:apply-templates select="@*"/>
              <BODY>
                <DIV1 TYPE="license">
                  <xsl:apply-templates select="*|processing-instruction()|comment()|text()"/>
                </DIV1>
              </BODY>
            </TEXT>
          </Q>
        </xsl:template>
        <xsl:template match="FLOATEXT">
          <Q>
            <TEXT>
              <xsl:apply-templates select="@*"/>
              <BODY>
                <DIV1>
                  <xsl:apply-templates select="@TYPE"/>
                  <xsl:apply-templates select="@N"/>
                  <xsl:apply-templates select="*|processing-instruction()|comment()|text()"/>
                </DIV1>
              </BODY>
            </TEXT>
          </Q>
        </xsl:template>
        <xsl:template match="comment()|processing-instruction()">
          <xsl:copy-of select="."/>
        </xsl:template>
        <xsl:template match="@*">
          <xsl:attribute>
            <XSL:attribute name="name">{name()}</XSL:attribute>
            <xsl:sequence select="tei:entities(.,false())"/>
          </xsl:attribute>
        </xsl:template>
        <xsl:template match="text()">
          <xsl:sequence select="tei:entities(.,true())"/>
        </xsl:template>
        <xsl:function name="tei:entities">
          <xsl:param name="words"/>
          <xsl:param name="usemarkup"/>
          <xsl:analyze-string select="$words" regex="&amp;([A-z0-9\-]+);">
            <xsl:matching-substring>
              <xsl:choose>
                <xsl:when test="regex-group(1)='ballot'">☐</xsl:when>
                <xsl:when test="regex-group(1)='music'">⚻</xsl:when>
                <xsl:when test="regex-group(1)='spcacute'">´</xsl:when>
                <xsl:when test="regex-group(1)='spcbreve'">˘</xsl:when>
                <xsl:when test="regex-group(1)='spccaron'">ˇ</xsl:when>
                <xsl:when test="regex-group(1)='spccedil'">¸</xsl:when>
                <xsl:when test="regex-group(1)='spccirc'">^</xsl:when>
                <xsl:when test="regex-group(1)='spcdblac'">˝</xsl:when>
                <xsl:when test="regex-group(1)='spcdot'">˙</xsl:when>
                <xsl:when test="regex-group(1)='spcgrave'">`</xsl:when>
                <xsl:when test="regex-group(1)='spcmacr'">¯</xsl:when>
                <xsl:when test="regex-group(1)='spcogon'">˛</xsl:when>
                <xsl:when test="regex-group(1)='spcrcomma'">῾</xsl:when>
                <xsl:when test="regex-group(1)='spcring'">˚</xsl:when>
                <xsl:when test="regex-group(1)='spctilde'">˜</xsl:when>
                <xsl:when test="regex-group(1)='spcuml'">¨</xsl:when>
                <XSL:for-each select="//char[equiv/@compat='exact']">
                  <XSL:sort select="ent/@tcp"/>
                  <XSL:variable name="ent" select="ent/@tcp"/>
                  <XSL:variable name="replace">
                    <XSL:value-of select="tei:toEnt(replace(equiv/@unic,'^u',''))"/>
                  </XSL:variable>
                  <xsl:when>
                    <XSL:attribute name="test">
                      <XSL:text>regex-group(1)='</XSL:text>
                      <XSL:value-of select="$ent"/>
                      <XSL:text>'</XSL:text>
                    </XSL:attribute>
                    <XSL:value-of select="$replace"/>
                  </xsl:when>
                </XSL:for-each>
                <XSL:for-each select="//char[equiv/@compat='pua' or        equiv/@compat='partial']">
                  <XSL:sort select="ent/@tcp"/>
                  <xsl:when>
                    <XSL:attribute name="test">
                      <XSL:text>regex-group(1)='</XSL:text>
                      <XSL:value-of select="ent/@tcp"/>
                      <XSL:text>'</XSL:text>
                    </XSL:attribute>
                    <xsl:variable name="replace">
                      <XSL:call-template name="firstreplacement"/>
                    </xsl:variable>
                    <xsl:choose>
                      <xsl:when test="not($usemarkup)">
                        <xsl:value-of select="$replace"/>
                      </xsl:when>
                      <xsl:when>
                        <XSL:attribute name="test">starts-with($replace,'{')</XSL:attribute>
                        <xsl:sequence>
                          <XSL:attribute name="select">tei:makeExpan('<XSL:value-of select="ent/@tcp"/>',translate($replace,'{}',''))</XSL:attribute>
                        </xsl:sequence>
                      </xsl:when>
                      <xsl:otherwise>
                        <xsl:sequence>
                          <XSL:attribute name="select">tei:makeG('<XSL:value-of select="ent/@tcp"/>',$replace)</XSL:attribute>
                        </xsl:sequence>
                      </xsl:otherwise>
                    </xsl:choose>
                  </xsl:when>
                </XSL:for-each>
              </xsl:choose>
            </xsl:matching-substring>
            <xsl:non-matching-substring>
              <xsl:value-of select="."/>
            </xsl:non-matching-substring>
          </xsl:analyze-string>
        </xsl:function>
        <xsl:function name="tei:makeG">
          <xsl:param name="char"/>
          <xsl:param name="replacement"/>
          <g>
            <XSL:attribute name="ref">char:{$char}</XSL:attribute>
            <xsl:value-of select="$replacement"/>
          </g>
        </xsl:function>
        <xsl:function name="tei:makeExpan">
          <xsl:param name="char"/>
          <xsl:param name="replacement"/>
          <expan>
            <am>
              <g>
                <XSL:attribute name="ref">char:{$char}</XSL:attribute>
              </g>
            </am>
            <ex>
              <xsl:value-of select="$replacement"/>
            </ex>
          </expan>
        </xsl:function>
      </xsl:stylesheet>
    </XSL:result-document>
  </XSL:template>
  <XSL:template name="firstreplacement">
    <XSL:choose>
      <XSL:when test="repl/@sup='Unicode'">
        <XSL:value-of select="repl[@sup='Unicode']/@txt"/>
      </XSL:when>
      <XSL:when test="repl/@sup='Arial Unicode MS'">
        <XSL:value-of select="repl[@sup='Arial Unicode MS'][1]/@txt"/>
      </XSL:when>
      <XSL:otherwise>
        <XSL:value-of select="repl[@sup='default']/@txt"/>
      </XSL:otherwise>
    </XSL:choose>
  </XSL:template>
  <XSL:function name="tei:toEnt">
    <XSL:param name="codes"/>
    <XSL:choose>
      <XSL:when test="$codes='1d177u1d178'">
        <XSL:text>𝅷𝅸</XSL:text>
      </XSL:when>
      <XSL:otherwise>
        <XSL:for-each select="tokenize(replace($codes,';$',''),';')">
          <XSL:value-of select="tei:chars(replace(.,'^u',''))"/>
        </XSL:for-each>
      </XSL:otherwise>
    </XSL:choose>
  </XSL:function>
  <XSL:function name="tei:chars">
    <XSL:param name="s" as="xs:string"/>
    <XSL:value-of>
      <XSL:analyze-string select="$s" regex="([0-9a-fA-F]+|[a-zA-Z][a-zA-Z0-9]*)">
        <XSL:matching-substring>
          <XSL:value-of select="codepoints-to-string(          tei:hex(            for $i in string-to-codepoints(upper-case(regex-group(1)))            return if ($i &gt; 64) then $i - 55 else $i - 48))"/>
        </XSL:matching-substring>
        <XSL:non-matching-substring>
          <XSL:value-of select="."/>
        </XSL:non-matching-substring>
      </XSL:analyze-string>
    </XSL:value-of>
  </XSL:function>
  <XSL:function name="tei:hex" as="xs:integer">
    <XSL:param name="x" as="xs:integer*"/>
    <XSL:value-of select="if (empty($x)) then 0 else ($x[last()] + 16* tei:hex($x[position()!=last()]))"/>
  </XSL:function>
</XSL:stylesheet>
