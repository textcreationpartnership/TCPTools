<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet xmlns:tei="http://www.tei-c.org/ns/1.0" xmlns="http://www.tei-c.org/ns/1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="2.0">
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
  <xsl:output indent="yes"/>
  <xsl:template match="/">
    <xsl:result-document href="tcpchars.xml">
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
            <xsl:for-each select="//char[equiv/@compat='pua' or @compat='partial']">
              <xsl:sort select="ent/@tcp"/>
              <charDecl>
                <xsl:for-each select="comment">
                  <desc>
                    <xsl:value-of select="."/>
                  </desc>
                </xsl:for-each>
                <char xml:id="{ent/@tcp}">
                  <xsl:for-each select="equiv/@desc">
                    <charName>
                      <xsl:value-of select="."/>
                    </charName>
                  </xsl:for-each>
		  <xsl:for-each select="repl">
                    <mapping type="{@sup}">
                      <xsl:value-of select="@txt"/>
                    </mapping>
		  </xsl:for-each>
                  <xsl:if test="equiv/@compat='pua'">
                    <mapping type="PUA">
                      <xsl:value-of disable-output-escaping="yes" select="tei:toEnt(equiv/@unic)"/>
                    </mapping>
                  </xsl:if>
                </char>
              </charDecl>
            </xsl:for-each>
          </encodingDesc>
        </teiHeader>
      </TEI>
    </xsl:result-document>
    <xsl:result-document href="tcpentities.dtd" method="text">
        <xsl:text>&lt;!ENTITY gcross "&amp;#x271A;"&gt;
</xsl:text>
        <xsl:text>&lt;!ENTITY ballot "&amp;#x2610;"&gt;
</xsl:text>
        <xsl:text>&lt;!ENTITY music "&amp;#x266B;"&gt;
</xsl:text>
      <xsl:for-each select="//char[equiv/@compat='exact']">
        <xsl:sort select="ent/@tcp"/>
        <xsl:text>&lt;!ENTITY </xsl:text>
        <xsl:value-of select="ent/@tcp"/>
        <xsl:text> "</xsl:text>
        <xsl:value-of select="tei:toEnt(replace(equiv/@unic,'^u',''))"/>
        <xsl:text>"&gt; 
</xsl:text>
      </xsl:for-each>
      <xsl:for-each select="//char[equiv/@compat='pua' or        equiv/@compat='partial']">
        <xsl:sort select="ent/@tcp"/>
        <xsl:text>&lt;!ENTITY </xsl:text>
        <xsl:value-of select="ent/@tcp"/>
        <xsl:text> "</xsl:text>
	<xsl:call-template name="replacement"/>
	<xsl:text>"&gt;
</xsl:text>
      </xsl:for-each>
    </xsl:result-document>
  </xsl:template>

  <xsl:template name="replacement">
    <xsl:choose>
      <xsl:when test="repl/@sup='Unicode'">
        <xsl:sequence select="tei:makeG(ent/@tcp,repl[@sup='Unicode']/@txt)"/>
      </xsl:when>
      <xsl:when test="repl/@sup='Arial Unicode MS'">
        <xsl:sequence select="tei:makeG(ent/@tcp,repl[@sup='Arial Unicode MS'][1]/@txt)"/>
      </xsl:when>
      <xsl:otherwise>
        <xsl:variable name="name" select="repl[@sup='default']/@txt"/>
	<xsl:choose>
	  <xsl:when test="starts-with($name,'{')">
            <xsl:sequence select="tei:makeExpan(ent/@tcp,translate($name,'{}',''))"/>
	  </xsl:when>
	  <xsl:otherwise>
            <xsl:value-of select="$name"/>
	  </xsl:otherwise>
	</xsl:choose>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <xsl:function name="tei:toEnt">
    <xsl:param name="codes"/>
    <xsl:choose>
      <xsl:when test="$codes='1d177u1d178'">
        <xsl:text>&amp;#x1d177;&amp;#x1d178;</xsl:text>
      </xsl:when>
      <xsl:otherwise>
        <xsl:for-each select="tokenize(replace($codes,';$',''),';')">
          <xsl:text>&amp;#x</xsl:text>
          <xsl:value-of select="replace(.,'^u','')"/>
          <xsl:text>;</xsl:text>
        </xsl:for-each>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:function>


  <xsl:function name="tei:makeG">
    <xsl:param name="char"/>
    <xsl:param name="replacement"/>
    <xsl:text>&lt;g ref='char:</xsl:text>
    <xsl:value-of select="$char"/>
        <xsl:text>'&gt;</xsl:text>
        <xsl:value-of select="$replacement"/>
        <xsl:text>&lt;/g&gt;</xsl:text>
  </xsl:function>

  <xsl:function name="tei:makeExpan">
    <xsl:param name="char"/>
    <xsl:param name="replacement"/>
    <xsl:text>&lt;expan&gt;&lt;am&gt;&lt;g ref='char:</xsl:text>
    <xsl:value-of select="$char"/>
    <xsl:text>'/&gt;&lt;/am&gt;&lt;ex&gt;</xsl:text>
    <xsl:value-of select="$replacement"/>
    <xsl:text>&lt;/ex&gt;&lt;/expan&gt;</xsl:text>
  </xsl:function>


</xsl:stylesheet>
