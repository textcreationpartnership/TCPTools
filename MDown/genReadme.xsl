<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:tei="http://www.tei-c.org/ns/1.0" xmlns:n="www.example.com"
    xpath-default-namespace="http://www.tei-c.org/ns/1.0" 
    exclude-result-prefixes="xs"
    version="2.0">
    
    <!--
This software is dual-licensed:

1. Distributed under a Creative Commons Attribution-ShareAlike 3.0
Unported License http://creativecommons.org/licenses/by-sa/3.0/ 

2. http://www.opensource.org/licenses/BSD-2-Clause
		
All rights reserved.

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

$Id$

20014, TEI Consortium
-->
    <!-- 
Read TEI P5 document and construct markdown readme file with summary of the file textual content and tag usage
-->
    
    <xsl:import href="diagnose.xsl"/>
    
    <xsl:output method="text"/>
    <xsl:strip-space elements="*"/>
    
    <!-- restricted or free access -->
    <xsl:param name="restricted">true</xsl:param>
    <!-- turn on debug messages -->
    <xsl:param name="debug">true</xsl:param>
    <!-- turn on messages -->
    <xsl:param name="prefix"/>
    <xsl:param name="verbose">true</xsl:param>
    <xsl:param name="generalSummary">true</xsl:param>
    <xsl:param name="headingSummary">false</xsl:param>
    

    <xsl:key name="attVals" match="@*" use="concat(local-name(parent::*),local-name(),string())"/>
    <xsl:key name="All" match="*" use="'1'"/>
    <xsl:key name="E" match="/TEI/text//*" use="local-name()"/>
    <xsl:key name="Elements" match="*" use="'1'"/>
    <xsl:key name="drama" match="/TEI/text//sp" use="'1'"/>
    <xsl:key name="verseInDrama" match="/TEI/text//l[ancestor::sp]" use="'1'"/>
    <xsl:key name="dramaCumVerse" match="/TEI/text//sp[descendant::l]" use="'1'"/>
    <xsl:key name="dramaCumProse" match="/TEI/text//sp[descendant::ab or descendant::p]" use="'1'"/>
    

<xsl:variable name="all">
    <xsl:copy-of select="/"/>
</xsl:variable>
    
    <xsl:template name="main" match="/">
  
        <xsl:if test="$debug='true'">
            <xsl:message>Process </xsl:message>
        </xsl:if>
        
        <xsl:variable name="ranges">
            <ranges>
                <xsl:call-template name="diagnose">
                    <xsl:with-param name="content" select="$all/string()"/>
                </xsl:call-template>
            </ranges>
        </xsl:variable>
        
        <xsl:variable name="all">
           <xsl:if test="$verbose='true'">
                        <xsl:message>processing <xsl:value-of
                            select="base-uri(.)"/>, root element is <xsl:value-of select="name(.)"/>        </xsl:message>
          </xsl:if>
            
            <xsl:text>#</xsl:text><xsl:value-of select="/TEI/teiHeader/fileDesc/titleStmt/title"/><xsl:text>#&#xa;</xsl:text>
            <xsl:for-each select="/TEI/teiHeader/fileDesc/titleStmt/author">
                <xsl:text>&#xa;##</xsl:text><xsl:value-of select="."/><xsl:text>##&#xa;</xsl:text>
            </xsl:for-each>

            <xsl:for-each select="/TEI/teiHeader/fileDesc/titleStmt/*[not(author) and not(title)]">
                <xsl:text></xsl:text><xsl:value-of select="."/><xsl:text>&#xa;</xsl:text>
            </xsl:for-each>
            
            <xsl:variable name="subdir">
                <xsl:choose>
                    <xsl:when test="$restricted='true'">
                        <xsl:text>restricted</xsl:text>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:text>free</xsl:text>
                    </xsl:otherwise>
                </xsl:choose>      
            </xsl:variable>
            <xsl:if test="$generalSummary='true'">
                <xsl:text>&#xa;##General Summary##&#xa;</xsl:text>
                
                <xsl:text>&#xa;**Links**&#xa;</xsl:text>
                <xsl:text>&#xa;[TCP catalogue](http://www.ota.ox.ac.uk/tcp/)</xsl:text>
                <xsl:text>  &#8226; &#xa;[HTML](http://downloads.it.ox.ac.uk/tcp/Texts-HTML/</xsl:text><xsl:value-of select="$subdir"/><xsl:text>/</xsl:text><xsl:value-of select="substring(/TEI/teiHeader/fileDesc/publicationStmt/idno[@type='DLPS'], 1, 3)"/><xsl:text>/</xsl:text><xsl:value-of select="/TEI/teiHeader/fileDesc/publicationStmt/idno[@type='DLPS']"/><xsl:text>.html)</xsl:text>
                <xsl:text>  &#8226; &#xa;[EPUB](http://downloads.it.ox.ac.uk/tcp/Texts-EPUB/</xsl:text><xsl:value-of select="$subdir"/><xsl:text>/</xsl:text><xsl:value-of select="substring(/TEI/teiHeader/fileDesc/publicationStmt/idno[@type='DLPS'], 1, 3)"/><xsl:text>/</xsl:text><xsl:value-of select="/TEI/teiHeader/fileDesc/publicationStmt/idno[@type='DLPS']"/><xsl:text>.epub)</xsl:text>
                <xsl:if test="/TEI/teiHeader/fileDesc/publicationStmt/idno[@type='EEBO-CITATION']/string() and /TEI/teiHeader/fileDesc/publicationStmt/idno[@type='VID']/string()">
                <xsl:text> &#8226; &#xa;[Page images (Historical Texts)](https://data.historicaltexts.jisc.ac.uk/view?pubId=eebo-</xsl:text><xsl:value-of select="/TEI/teiHeader/fileDesc/publicationStmt/idno[@type='EEBO-CITATION']"/><xsl:text>e&amp;pageId=eebo-</xsl:text><xsl:value-of select="/TEI/teiHeader/fileDesc/publicationStmt/idno[@type='EEBO-CITATION']"/><xsl:text>e-</xsl:text><xsl:value-of select="/TEI/teiHeader/fileDesc/publicationStmt/idno[@type='VID']"/><xsl:text>-1)</xsl:text>
                </xsl:if>
                
                <xsl:text>&#xa;</xsl:text>
                
                <xsl:if test="/TEI/teiHeader/fileDesc/publicationStmt/availability"><xsl:text>&#xa;**Availability**&#xa;</xsl:text></xsl:if>
                <xsl:for-each select="/TEI/teiHeader/fileDesc/publicationStmt/availability"><xsl:text>&#xa;</xsl:text><xsl:value-of select="."/>&#xa;</xsl:for-each>
                <xsl:text>&#xa;</xsl:text>

                <xsl:if test="/TEI/teiHeader/revisionDesc/change"><xsl:text>&#xa;**Major revisions**&#xa;</xsl:text></xsl:if>
                <xsl:for-each select="/TEI/teiHeader/revisionDesc/change"><xsl:text>&#xa;1. </xsl:text><xsl:apply-templates mode="header" select="."/></xsl:for-each>
                <xsl:text>&#xa;</xsl:text>
                
            
        <xsl:if test="$headingSummary='true'">
            <xsl:text>&#xa;##Header Summary##&#xa;</xsl:text>
            <xsl:for-each select="/TEI/teiHeader/*[not(fileDesc)]">
                <xsl:apply-templates mode="header"/>
            </xsl:for-each>
        </xsl:if>            
            
            <xsl:text>&#xa;##Content Summary##&#xa;</xsl:text>
            <xsl:call-template name="toc">
                <xsl:with-param name="set">
                    <xsl:copy-of select="/TEI/text/front/*"/>
                </xsl:with-param>
                <xsl:with-param name="label">Front</xsl:with-param>
            </xsl:call-template>
            
            <xsl:call-template name="toc">
                <xsl:with-param name="set">
                    <xsl:copy-of select="/TEI/text/body/*"/>
                </xsl:with-param>
                <xsl:with-param name="label">Body</xsl:with-param>
            </xsl:call-template>
            
            <xsl:call-template name="toc">
                <xsl:with-param name="set">
                    <xsl:copy-of select="/TEI/text/back/*"/>
                </xsl:with-param>
                <xsl:with-param name="label">Back</xsl:with-param>
            </xsl:call-template>

                <xsl:call-template name="entityList">
                    <xsl:with-param name="set">
                        <xsl:copy-of select="/TEI/teiHeader//listPerson"/>
                    </xsl:with-param>
                    <xsl:with-param name="elementName">person</xsl:with-param>
                    <xsl:with-param name="label">People</xsl:with-param>
                </xsl:call-template>
                
                <xsl:call-template name="entityList">
                    <xsl:with-param name="set">
                        <xsl:copy-of select="/TEI/teiHeader//listPlace"/>
                    </xsl:with-param>
                    <xsl:with-param name="elementName">place</xsl:with-param>
                    <xsl:with-param name="label">Places</xsl:with-param>
                </xsl:call-template>
                
                <xsl:call-template name="entityList">
                    <xsl:with-param name="set">
                        <xsl:copy-of select="/TEI/teiHeader//listWit"/>
                    </xsl:with-param>
                    <xsl:with-param name="elementName">witness</xsl:with-param>
                    <xsl:with-param name="label">Witnesses</xsl:with-param>
                </xsl:call-template>
                
                <xsl:call-template name="entityList">
                    <xsl:with-param name="set">
                        <xsl:copy-of select="/TEI/text//castList"/>
                    </xsl:with-param>
                    <xsl:with-param name="elementName">castItem</xsl:with-param>
                    <xsl:with-param name="label">Cast List</xsl:with-param>
                </xsl:call-template>
                
                
                <xsl:text>&#xa;**Types of content**&#xa;</xsl:text>
                <xsl:if test="count(key('E', 'l'))">&#xa;  * There are <xsl:value-of select="count(key('E', 'l'))"/> **verse** lines!</xsl:if>
                <xsl:if test="key('E', 'u')">&#xa;  * There are <xsl:value-of select="count(key('E', 'u'))"/> **speech** utterances!</xsl:if>
                <xsl:if test="key('E', 'sp')"><xsl:text>&#xa;  * There are </xsl:text><xsl:value-of select="count(key('E', 'sp'))"/><xsl:text> **drama** parts!</xsl:text>
                    
                    <xsl:choose>
                        <xsl:when test="count(key('dramaCumVerse', '1')) = count(key('drama', '1'))">
                            <xsl:text> This is **verse drama**.</xsl:text>
                        </xsl:when>
                        <xsl:when test="count(key('dramaCumProse', '1')) = count(key('drama', '1'))">
                            <xsl:text> This is **prose drama**.</xsl:text>
                        </xsl:when>
                        <xsl:otherwise>
                            <xsl:text> This is mixed prose (</xsl:text><xsl:value-of select="count(key('dramaCumProse', '1'))"/><xsl:text>) and verse (</xsl:text><xsl:value-of select="count(key('dramaCumVerse', '1'))"/><xsl:text>) drama.</xsl:text>
                        </xsl:otherwise>
                    </xsl:choose>
                </xsl:if>
                <xsl:if test="key('E', 'p')">&#xa;  * Oh, Mr. Jourdain, there is **prose** in there!</xsl:if>
                
                <xsl:if test="matches(/, '\p{IsAlchemicalSymbols}')">
                    <xsl:message>Text has alchemical characters</xsl:message>
                </xsl:if>
                
                <xsl:text>&#xa;</xsl:text>
            </xsl:if>    
            
            <!-- gaps -->
            <xsl:if test="count(key('E', 'gap'))">
                <xsl:text>&#xa;There are </xsl:text><xsl:value-of select="count(key('E', 'gap'))"/><xsl:text> **ommitted** fragments! &#xa;</xsl:text>
                <xsl:for-each-group select="key('E', 'gap')/@*" group-by="name()">
                    <xsl:text> @__</xsl:text><xsl:value-of select="current-grouping-key()"/><xsl:text>__ (</xsl:text>
                    <xsl:value-of select="count(current-group())"/><xsl:text>) : </xsl:text>
                    <xsl:for-each select="distinct-values(current-group())"><xsl:variable name="current"><xsl:value-of select="."/></xsl:variable><xsl:value-of select="."/><xsl:text> (</xsl:text><xsl:value-of select="count(key('attVals', concat('gap', current-grouping-key(), $current), $all))"/><xsl:text>)</xsl:text><xsl:if test="position()!=last()"><xsl:text>, </xsl:text></xsl:if></xsl:for-each>
                    <xsl:if test="position()!=last()"><xsl:text>  &#8226; </xsl:text></xsl:if>
                </xsl:for-each-group>
                <xsl:text>&#xa;</xsl:text>
                
            </xsl:if>            
            
            <xsl:text>&#xa;**Character listing**&#xa;</xsl:text>
            <xsl:text>&#xa;&#xa;|Text|string(s)|codepoint(s)|</xsl:text>
            <xsl:text>&#xa;|---|---|---|</xsl:text>
            <xsl:for-each-group select="$ranges//range" group-by="@n">
                <xsl:variable name="text"><xsl:value-of
                    select="current-group()//text()" separator=""/></xsl:variable>
                
                <xsl:text>&#xa;|</xsl:text>
                <xsl:value-of select="@n"/>
                <xsl:text>|</xsl:text>
                <xsl:value-of select="codepoints-to-string(distinct-values(string-to-codepoints($text)))"/>
                <xsl:text>|</xsl:text>
                <xsl:value-of select="distinct-values(string-to-codepoints($text))"/>
                <xsl:text>|</xsl:text>
            </xsl:for-each-group>
            
            <xsl:text>&#xa;</xsl:text>

            <xsl:text>&#xa;##Tag Usage Summary##&#xa;</xsl:text>
           
            <xsl:call-template name="tagUsage">
                <xsl:with-param name="set">
                    <xsl:copy-of select="/TEI/teiHeader//*"/>
                </xsl:with-param>
                <xsl:with-param name="label">Header Tag Usage</xsl:with-param>
            </xsl:call-template>

            <xsl:text>&#xa;</xsl:text>
            
            <xsl:call-template name="tagUsage">
                <xsl:with-param name="set">
                    <xsl:copy-of select="/TEI/text//*"/>
                </xsl:with-param>
                <xsl:with-param name="label">Text Tag Usage</xsl:with-param>
            </xsl:call-template>
            
        </xsl:variable>
        
        <xsl:copy-of select="$all"/>
    </xsl:template>

   <xsl:template name="entityList">
       <xsl:param name="set"/>
       <xsl:param name="elementName"/>
       <xsl:param name="label"/>
       <xsl:if test="$set/node()"><xsl:text>&#xa;**</xsl:text><xsl:value-of select="$label"></xsl:value-of><xsl:text>**</xsl:text><xsl:text> (</xsl:text><xsl:value-of select="count($set//*[name()=$elementName])"/>)
       <xsl:for-each select="$set//*[name()=$elementName]"><xsl:text>&#xa;1. </xsl:text><xsl:value-of select="."/></xsl:for-each>
       <xsl:text>&#xa;</xsl:text>
       </xsl:if>
       
   </xsl:template>

    <xsl:template name="toc">
        <xsl:param name="label"/>
        <xsl:param name="set"/>
        <xsl:if test="$set/node()">
            <xsl:text>&#xa;#####</xsl:text><xsl:value-of select="$label"></xsl:value-of><xsl:text>#####&#xa;</xsl:text>
        <xsl:choose>
        <xsl:when test="$set/div">
            <xsl:call-template name="tocHead">
                <xsl:with-param name="level" select="1"/>
                <xsl:with-param name="set"><xsl:copy-of select="$set/div"/></xsl:with-param>
            </xsl:call-template>
        </xsl:when>
        <xsl:otherwise>
                <xsl:value-of select="substring(string(.), 1, 100)"/>
        </xsl:otherwise>
        </xsl:choose>
        </xsl:if>  
    </xsl:template>


    <xsl:template name="tocHead">
        <xsl:param name="level"/>
        <xsl:param name="set"/>
        
        <xsl:variable name="hdng">
        <xsl:choose>
            <xsl:when test="$level=1">1. </xsl:when>
            <xsl:when test="$level=2">    _ </xsl:when>
            <xsl:when test="$level=3">      * </xsl:when>
            <xsl:otherwise/>
        </xsl:choose>
        </xsl:variable>

        
                <xsl:for-each select="$set/div">
                    <xsl:choose>
                        <xsl:when test="head">
                            <xsl:text>&#xa;</xsl:text>
                            <xsl:value-of select="$hdng"/><xsl:value-of select="head[1]"/><xsl:text>&#xa;</xsl:text>
                        </xsl:when>
                        <xsl:otherwise>
                            <xsl:value-of select="substring(., 1, 100)"/>
                        </xsl:otherwise>
                    </xsl:choose>
                    
                    <xsl:if test="$level&lt;4">
                        <xsl:call-template name="tocHead">
                            <xsl:with-param name="level" select="$level + 1"/>
                            <xsl:with-param name="set"><xsl:copy-of select="$set/div/div"/></xsl:with-param>
                        </xsl:call-template>
                    </xsl:if>
        
                </xsl:for-each>        
        
    </xsl:template>
    

    <xsl:template name="tagUsage">
        <xsl:param name="set"/>
        <xsl:param name="label"/>
        
        <xsl:text>&#xa;###</xsl:text>
        <xsl:value-of select="$label"/>
        <xsl:text>###</xsl:text>
        <xsl:text>&#xa;</xsl:text>

        <xsl:text>&#xa;|No|element name|occ|attributes|</xsl:text>
        <xsl:text>&#xa;|---|---|---|---|</xsl:text>
        
        <xsl:for-each-group select="$set/*" group-by="local-name()">
            <xsl:sort select="local-name()"/>

            <xsl:text>&#xa;|</xsl:text>
            <xsl:value-of select="position()"/><xsl:text>.</xsl:text>
            
            <xsl:text>|</xsl:text>
            <xsl:text>__</xsl:text><xsl:value-of select="current-grouping-key()"/> <xsl:text>__</xsl:text>
            <xsl:text>|</xsl:text>
            <xsl:value-of select="count(current-group())"/>
            <xsl:text>|</xsl:text>
            <xsl:variable name="eName" select="current-grouping-key()"/>
            <xsl:for-each-group select="current-group()/@*" group-by="name()">
                <xsl:text> @__</xsl:text><xsl:value-of select="current-grouping-key()"/><xsl:text>__ (</xsl:text>
                <xsl:value-of select="count(current-group())"/><xsl:text>) : </xsl:text>
                <xsl:for-each select="distinct-values(current-group())"><xsl:variable name="current"><xsl:value-of select="."/></xsl:variable><xsl:value-of select="."/><xsl:text> (</xsl:text><xsl:value-of select="count(key('attVals', concat($eName, current-grouping-key(), $current), $all))"/><xsl:text>)</xsl:text><xsl:if test="position()!=last()"><xsl:text>, </xsl:text></xsl:if></xsl:for-each>
                <xsl:if test="position()!=last()"><xsl:text>  &#8226; </xsl:text></xsl:if>
            </xsl:for-each-group>
            <xsl:text>|</xsl:text>
        </xsl:for-each-group>
        <xsl:text>&#xa;</xsl:text>
    </xsl:template>
    
    <xsl:template match="note | title | projectDesc" mode="header"><xsl:text>&#xa;*</xsl:text><xsl:value-of select="name()"/><xsl:text>*</xsl:text><xsl:apply-templates mode="header"/><xsl:text>&#xa;</xsl:text></xsl:template>

    <xsl:template match="change" mode="header" xml:space="default">
          <xsl:text>__</xsl:text><xsl:value-of select="date"/><xsl:text>__ </xsl:text>
          <xsl:text>__</xsl:text><xsl:value-of select="label"/><xsl:text>__</xsl:text>
          <xsl:text> *</xsl:text><xsl:for-each select="child::text()"><xsl:value-of select="."/>*</xsl:for-each>
    </xsl:template>

</xsl:stylesheet>