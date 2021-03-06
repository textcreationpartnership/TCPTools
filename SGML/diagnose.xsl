<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet
    xmlns:tei="http://www.tei-c.org/ns/1.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="2.0">
  <xsl:output indent="yes"/>

  <xsl:template match="/">
    <xsl:variable name="ranges">
      <ranges>
	<xsl:apply-templates/>
      </ranges>
    </xsl:variable>
<html>
<head>
  <title>Character listing</title>
</head>
<body>
<h1><xsl:value-of select="base-uri(/)"/></h1>
<table>
<xsl:for-each-group select="$ranges//range" group-by="@n">
<xsl:variable name="text"><xsl:value-of
			      select="current-group()//text()" separator=""/></xsl:variable>
<tr>
    <td><xsl:value-of select="@n"/></td>
    <td><xsl:value-of
    select="codepoints-to-string(distinct-values(string-to-codepoints($text)))"/></td>
    <td><xsl:value-of
    select="distinct-values(string-to-codepoints($text))"/></td>
</tr>
</xsl:for-each-group>
</table>
</body>
</html>
  </xsl:template>

  <xsl:template match="tei:desc/text()"/>
  <xsl:template match="text()">
<!--<xsl:sequence select="tei:range(.,'IsBasicLatin','BasicLatin')"/>-->
<xsl:sequence select="tei:range(.,'IsLatin-1Supplement','Latin-1 Supplement')"/>
<xsl:sequence select="tei:range(.,'IsLatinExtended-A','Latin Extended-A')"/>
<xsl:sequence select="tei:range(.,'IsLatinExtended-B','Latin Extended-B')"/>
<xsl:sequence select="tei:range(.,'IsIPAExtensions','IPA  Extensions')"/>
<xsl:sequence select="tei:range(.,'IsSpacingModifierLetters','Spacing
		      Modifier Letters')"/>
<xsl:sequence
    select="tei:range(.,'IsCombiningDiacriticalMarks','Combining
	    Diacritical Marks')"/>
<xsl:sequence select="tei:range(.,'IsGreek','Greek')"/>
<xsl:sequence select="tei:range(.,'IsGreekandCoptic','GreekandCoptic')"/>
<xsl:sequence select="tei:range(.,'IsCyrillic','Cyrillic')"/>
<xsl:sequence select="tei:range(.,'IsCyrillicSupplementary','Cyrillic Supplementary')"/>
<xsl:sequence select="tei:range(.,'IsCyrillicSupplement','Cyrillic Supplement')"/>
<xsl:sequence select="tei:range(.,'IsArmenian','Armenian')"/>
<xsl:sequence select="tei:range(.,'IsHebrew','Hebrew')"/>
<xsl:sequence select="tei:range(.,'IsArabic','Arabic')"/>
<xsl:sequence select="tei:range(.,'IsSyriac','Syriac')"/>
<xsl:sequence select="tei:range(.,'IsArabicSupplement','ArabicSupplement')"/>
<xsl:sequence select="tei:range(.,'IsThaana','Thaana')"/>
<xsl:sequence select="tei:range(.,'IsNKo','NKo')"/>
<xsl:sequence select="tei:range(.,'IsSamaritan','Samaritan')"/>
<xsl:sequence select="tei:range(.,'IsMandaic','Mandaic')"/>
<xsl:sequence select="tei:range(.,'IsDevanagari','Devanagari')"/>
<xsl:sequence select="tei:range(.,'IsBengali','Bengali')"/>
<xsl:sequence select="tei:range(.,'IsGurmukhi','Gurmukhi')"/>
<xsl:sequence select="tei:range(.,'IsGujarati','Gujarati')"/>
<xsl:sequence select="tei:range(.,'IsOriya','Oriya')"/>
<xsl:sequence select="tei:range(.,'IsTamil','Tamil')"/>
<xsl:sequence select="tei:range(.,'IsTelugu','Telugu')"/>
<xsl:sequence select="tei:range(.,'IsKannada','Kannada')"/>
<xsl:sequence select="tei:range(.,'IsMalayalam','Malayalam')"/>
<xsl:sequence select="tei:range(.,'IsSinhala','Sinhala')"/>
<xsl:sequence select="tei:range(.,'IsThai','Thai')"/>
<xsl:sequence select="tei:range(.,'IsLao','Lao')"/>
<xsl:sequence select="tei:range(.,'IsTibetan','Tibetan')"/>
<xsl:sequence select="tei:range(.,'IsMyanmar','Myanmar')"/>
<xsl:sequence select="tei:range(.,'IsGeorgian','Georgian')"/>
<xsl:sequence select="tei:range(.,'IsHangulJamo','HangulJamo')"/>
<xsl:sequence select="tei:range(.,'IsEthiopic','Ethiopic')"/>
<xsl:sequence select="tei:range(.,'IsEthiopicSupplement','EthiopicSupplement')"/>
<xsl:sequence select="tei:range(.,'IsCherokee','Cherokee')"/>
<xsl:sequence select="tei:range(.,'IsUnifiedCanadianAboriginalSyllabics','UnifiedCanadianAboriginalSyllabics')"/>
<xsl:sequence select="tei:range(.,'IsOgham','Ogham')"/>
<xsl:sequence select="tei:range(.,'IsRunic','Runic')"/>
<xsl:sequence select="tei:range(.,'IsTagalog','Tagalog')"/>
<xsl:sequence select="tei:range(.,'IsHanunoo','Hanunoo')"/>
<xsl:sequence select="tei:range(.,'IsBuhid','Buhid')"/>
<xsl:sequence select="tei:range(.,'IsTagbanwa','Tagbanwa')"/>
<xsl:sequence select="tei:range(.,'IsKhmer','Khmer')"/>
<xsl:sequence select="tei:range(.,'IsMongolian','Mongolian')"/>
<xsl:sequence select="tei:range(.,'IsUnifiedCanadianAboriginalSyllabicsExtended','UnifiedCanadianAboriginalSyllabicsExtended')"/>
<xsl:sequence select="tei:range(.,'IsLimbu','Limbu')"/>
<xsl:sequence select="tei:range(.,'IsTaiLe','TaiLe')"/>
<xsl:sequence select="tei:range(.,'IsNewTaiLue','NewTaiLue')"/>
<xsl:sequence select="tei:range(.,'IsKhmerSymbols','KhmerSymbols')"/>
<xsl:sequence select="tei:range(.,'IsBuginese','Buginese')"/>
<xsl:sequence select="tei:range(.,'IsTaiTham','TaiTham')"/>
<xsl:sequence select="tei:range(.,'IsBalinese','Balinese')"/>
<xsl:sequence select="tei:range(.,'IsSundanese','Sundanese')"/>
<xsl:sequence select="tei:range(.,'IsBatak','Batak')"/>
<xsl:sequence select="tei:range(.,'IsLepcha','Lepcha')"/>
<xsl:sequence select="tei:range(.,'IsOlChiki','OlChiki')"/>
<xsl:sequence select="tei:range(.,'IsVedicExtensions','VedicExtensions')"/>
<xsl:sequence select="tei:range(.,'IsPhoneticExtensions','PhoneticExtensions')"/>
<xsl:sequence
    select="tei:range(.,'IsPhoneticExtensionsSupplement','Phonetic
	    Extensions Supplement')"/>
<xsl:sequence
    select="tei:range(.,'IsCombiningDiacriticalMarksSupplement','Combining
	    DiacriticalMarks Supplement')"/>
<xsl:sequence select="tei:range(.,'IsLatinExtendedAdditional','Latin ExtendedAdditional')"/>
<xsl:sequence select="tei:range(.,'IsGreekExtended','GreekExtended')"/>
<xsl:sequence select="tei:range(.,'IsGeneralPunctuation','General Punctuation')"/>
<xsl:sequence
    select="tei:range(.,'IsSuperscriptsandSubscripts','Superscripts
	    and Subscripts')"/>
<xsl:sequence select="tei:range(.,'IsCurrencySymbols','CurrencySymbols')"/>
<xsl:sequence
    select="tei:range(.,'IsCombiningMarksforSymbols','Combining MarksforSymbols')"/>
<xsl:sequence
    select="tei:range(.,'IsCombiningDiacriticalMarksforSymbols','Combining
	    Diacritical Marks for Symbols')"/>
<xsl:sequence select="tei:range(.,'IsLetterlikeSymbols','Letterlike Symbols')"/>
<xsl:sequence select="tei:range(.,'IsNumberForms','Number Forms')"/>
<xsl:sequence select="tei:range(.,'IsArrows','Arrows')"/>
<xsl:sequence
    select="tei:range(.,'IsMathematicalOperators','Mathematical Operators')"/>
<xsl:sequence
    select="tei:range(.,'IsMiscellaneousTechnical','Miscellaneous Technical')"/>
<xsl:sequence select="tei:range(.,'IsControlPictures','ControlPictures')"/>
<xsl:sequence
    select="tei:range(.,'IsOpticalCharacterRecognition','Optical
	    Character Recognition')"/>
<xsl:sequence select="tei:range(.,'IsEnclosedAlphanumerics','Enclosed Alphanumerics')"/>
<xsl:sequence select="tei:range(.,'IsBoxDrawing','Box Drawing')"/>
<xsl:sequence select="tei:range(.,'IsBlockElements','Block Elements')"/>
<xsl:sequence select="tei:range(.,'IsGeometricShapes','Geometric Shapes')"/>
<xsl:sequence
    select="tei:range(.,'IsMiscellaneousSymbols','Miscellaneous Symbols')"/>
<xsl:sequence select="tei:range(.,'IsDingbats','Dingbats')"/>
<xsl:sequence select="tei:range(.,'IsMiscellaneousMathematicalSymbols-A','MiscellaneousMathematicalSymbols-A')"/>
<xsl:sequence select="tei:range(.,'IsSupplementalArrows-A','SupplementalArrows-A')"/>
<xsl:sequence select="tei:range(.,'IsBraillePatterns','BraillePatterns')"/>
<xsl:sequence select="tei:range(.,'IsSupplementalArrows-B','SupplementalArrows-B')"/>
<xsl:sequence select="tei:range(.,'IsMiscellaneousMathematicalSymbols-B','MiscellaneousMathematicalSymbols-B')"/>
<xsl:sequence
    select="tei:range(.,'IsSupplementalMathematicalOperators','Supplemental
	    MathematicalOperators')"/>
<xsl:sequence
    select="tei:range(.,'IsMiscellaneousSymbolsandArrows','Miscellaneous
	    Symbols and Arrows')"/>
<xsl:sequence select="tei:range(.,'IsGlagolitic','Glagolitic')"/>
<xsl:sequence select="tei:range(.,'IsLatinExtended-C','Latin Extended-C')"/>
<xsl:sequence select="tei:range(.,'IsCoptic','Coptic')"/>
<xsl:sequence select="tei:range(.,'IsGeorgianSupplement','GeorgianSupplement')"/>
<xsl:sequence select="tei:range(.,'IsTifinagh','Tifinagh')"/>
<xsl:sequence select="tei:range(.,'IsEthiopicExtended','Ethiopic Extended')"/>
<xsl:sequence select="tei:range(.,'IsCyrillicExtended-A','Cyrillic Extended-A')"/>
<xsl:sequence select="tei:range(.,'IsSupplementalPunctuation','SupplementalPunctuation')"/>
<xsl:sequence select="tei:range(.,'IsCJKRadicalsSupplement','CJKRadicalsSupplement')"/>
<xsl:sequence select="tei:range(.,'IsKangxiRadicals','KangxiRadicals')"/>
<xsl:sequence select="tei:range(.,'IsIdeographicDescriptionCharacters','IdeographicDescriptionCharacters')"/>
<xsl:sequence select="tei:range(.,'IsCJKSymbolsandPunctuation','CJKSymbolsandPunctuation')"/>
<xsl:sequence select="tei:range(.,'IsHiragana','Hiragana')"/>
<xsl:sequence select="tei:range(.,'IsKatakana','Katakana')"/>
<xsl:sequence select="tei:range(.,'IsBopomofo','Bopomofo')"/>
<xsl:sequence select="tei:range(.,'IsHangulCompatibilityJamo','HangulCompatibilityJamo')"/>
<xsl:sequence select="tei:range(.,'IsKanbun','Kanbun')"/>
<xsl:sequence select="tei:range(.,'IsBopomofoExtended','BopomofoExtended')"/>
<xsl:sequence select="tei:range(.,'IsCJKStrokes','CJKStrokes')"/>
<xsl:sequence select="tei:range(.,'IsKatakanaPhoneticExtensions','KatakanaPhoneticExtensions')"/>
<xsl:sequence select="tei:range(.,'IsEnclosedCJKLettersandMonths','EnclosedCJKLettersandMonths')"/>
<xsl:sequence select="tei:range(.,'IsCJKCompatibility','CJKCompatibility')"/>
<xsl:sequence select="tei:range(.,'IsCJKUnifiedIdeographsExtensionA','CJKUnifiedIdeographsExtensionA')"/>
<xsl:sequence select="tei:range(.,'IsCJKUnifiedIdeographsExtensionA','CJKUnifiedIdeographsExtensionA')"/>
<xsl:sequence select="tei:range(.,'IsYijingHexagramSymbols','YijingHexagramSymbols')"/>
<xsl:sequence select="tei:range(.,'IsCJKUnifiedIdeographs','CJKUnifiedIdeographs')"/>
<xsl:sequence select="tei:range(.,'IsYiSyllables','YiSyllables')"/>
<xsl:sequence select="tei:range(.,'IsYiRadicals','YiRadicals')"/>
<xsl:sequence select="tei:range(.,'IsLisu','Lisu')"/>
<xsl:sequence select="tei:range(.,'IsVai','Vai')"/>
<xsl:sequence select="tei:range(.,'IsCyrillicExtended-B','CyrillicExtended-B')"/>
<xsl:sequence select="tei:range(.,'IsBamum','Bamum')"/>
<xsl:sequence select="tei:range(.,'IsModifierToneLetters','ModifierToneLetters')"/>
<xsl:sequence select="tei:range(.,'IsLatinExtended-D','LatinExtended-D')"/>
<xsl:sequence select="tei:range(.,'IsSylotiNagri','SylotiNagri')"/>
<xsl:sequence select="tei:range(.,'IsCommonIndicNumberForms','CommonIndicNumberForms')"/>
<xsl:sequence select="tei:range(.,'IsPhags-pa','Phags-pa')"/>
<xsl:sequence select="tei:range(.,'IsSaurashtra','Saurashtra')"/>
<xsl:sequence select="tei:range(.,'IsDevanagariExtended','DevanagariExtended')"/>
<xsl:sequence select="tei:range(.,'IsKayahLi','KayahLi')"/>
<xsl:sequence select="tei:range(.,'IsRejang','Rejang')"/>
<xsl:sequence select="tei:range(.,'IsHangulJamoExtended-A','HangulJamoExtended-A')"/>
<xsl:sequence select="tei:range(.,'IsJavanese','Javanese')"/>
<xsl:sequence select="tei:range(.,'IsCham','Cham')"/>
<xsl:sequence select="tei:range(.,'IsMyanmarExtended-A','MyanmarExtended-A')"/>
<xsl:sequence select="tei:range(.,'IsTaiViet','TaiViet')"/>
<xsl:sequence select="tei:range(.,'IsEthiopicExtended-A','EthiopicExtended-A')"/>
<xsl:sequence select="tei:range(.,'IsMeeteiMayek','MeeteiMayek')"/>
<xsl:sequence select="tei:range(.,'IsHangulSyllables','HangulSyllables')"/>
<xsl:sequence select="tei:range(.,'IsHangulSyllables','HangulSyllables')"/>
<xsl:sequence select="tei:range(.,'IsHangulJamoExtended-B','HangulJamoExtended-B')"/>
<xsl:sequence select="tei:range(.,'IsHighSurrogates','HighSurrogates')"/>
<xsl:sequence select="tei:range(.,'IsHighPrivateUseSurrogates','HighPrivateUseSurrogates')"/>
<xsl:sequence select="tei:range(.,'IsLowSurrogates','LowSurrogates')"/>
<xsl:sequence select="tei:range(.,'IsPrivateUse','PrivateUse')"/>
<xsl:sequence select="tei:range(.,'IsPrivateUseArea','PrivateUseArea')"/>
<xsl:sequence select="tei:range(.,'IsCJKCompatibilityIdeographs','CJKCompatibilityIdeographs')"/>
<xsl:sequence select="tei:range(.,'IsAlphabeticPresentationForms','AlphabeticPresentationForms')"/>
<xsl:sequence select="tei:range(.,'IsArabicPresentationForms-A','ArabicPresentationForms-A')"/>
<xsl:sequence select="tei:range(.,'IsVariationSelectors','VariationSelectors')"/>
<xsl:sequence select="tei:range(.,'IsVerticalForms','VerticalForms')"/>
<xsl:sequence select="tei:range(.,'IsCombiningHalfMarks','CombiningHalfMarks')"/>
<xsl:sequence select="tei:range(.,'IsCJKCompatibilityForms','CJKCompatibilityForms')"/>
<xsl:sequence select="tei:range(.,'IsSmallFormVariants','SmallFormVariants')"/>
<xsl:sequence select="tei:range(.,'IsArabicPresentationForms-B','ArabicPresentationForms-B')"/>
<xsl:sequence select="tei:range(.,'IsArabicPresentationForms-B','ArabicPresentationForms-B')"/>
<xsl:sequence select="tei:range(.,'IsSpecials','Specials')"/>
<xsl:sequence select="tei:range(.,'IsHalfwidthandFullwidthForms','HalfwidthandFullwidthForms')"/>
<xsl:sequence select="tei:range(.,'IsSpecials','Specials')"/>
<xsl:sequence select="tei:range(.,'IsSpecials','Specials')"/>
<xsl:sequence select="tei:range(.,'IsLinearBSyllabary','LinearBSyllabary')"/>
<xsl:sequence select="tei:range(.,'IsLinearBIdeograms','LinearBIdeograms')"/>
<xsl:sequence select="tei:range(.,'IsAegeanNumbers','AegeanNumbers')"/>
<xsl:sequence select="tei:range(.,'IsAncientGreekNumbers','AncientGreekNumbers')"/>
<xsl:sequence select="tei:range(.,'IsAncientSymbols','AncientSymbols')"/>
<xsl:sequence select="tei:range(.,'IsPhaistosDisc','PhaistosDisc')"/>
<xsl:sequence select="tei:range(.,'IsLycian','Lycian')"/>
<xsl:sequence select="tei:range(.,'IsCarian','Carian')"/>
<xsl:sequence select="tei:range(.,'IsOldItalic','OldItalic')"/>
<xsl:sequence select="tei:range(.,'IsGothic','Gothic')"/>
<xsl:sequence select="tei:range(.,'IsUgaritic','Ugaritic')"/>
<xsl:sequence select="tei:range(.,'IsOldPersian','OldPersian')"/>
<xsl:sequence select="tei:range(.,'IsDeseret','Deseret')"/>
<xsl:sequence select="tei:range(.,'IsShavian','Shavian')"/>
<xsl:sequence select="tei:range(.,'IsOsmanya','Osmanya')"/>
<xsl:sequence select="tei:range(.,'IsCypriotSyllabary','CypriotSyllabary')"/>
<xsl:sequence select="tei:range(.,'IsImperialAramaic','ImperialAramaic')"/>
<xsl:sequence select="tei:range(.,'IsPhoenician','Phoenician')"/>
<xsl:sequence select="tei:range(.,'IsLydian','Lydian')"/>
<xsl:sequence select="tei:range(.,'IsKharoshthi','Kharoshthi')"/>
<xsl:sequence select="tei:range(.,'IsOldSouthArabian','OldSouthArabian')"/>
<xsl:sequence select="tei:range(.,'IsAvestan','Avestan')"/>
<xsl:sequence select="tei:range(.,'IsInscriptionalParthian','InscriptionalParthian')"/>
<xsl:sequence select="tei:range(.,'IsInscriptionalPahlavi','InscriptionalPahlavi')"/>
<xsl:sequence select="tei:range(.,'IsOldTurkic','OldTurkic')"/>
<xsl:sequence select="tei:range(.,'IsRumiNumeralSymbols','RumiNumeralSymbols')"/>
<xsl:sequence select="tei:range(.,'IsBrahmi','Brahmi')"/>
<xsl:sequence select="tei:range(.,'IsKaithi','Kaithi')"/>
<xsl:sequence select="tei:range(.,'IsCuneiform','Cuneiform')"/>
<xsl:sequence select="tei:range(.,'IsCuneiformNumbersandPunctuation','CuneiformNumbersandPunctuation')"/>
<xsl:sequence select="tei:range(.,'IsEgyptianHieroglyphs','EgyptianHieroglyphs')"/>
<xsl:sequence select="tei:range(.,'IsBamumSupplement','BamumSupplement')"/>
<xsl:sequence select="tei:range(.,'IsKanaSupplement','KanaSupplement')"/>
<xsl:sequence select="tei:range(.,'IsByzantineMusicalSymbols','ByzantineMusicalSymbols')"/>
<xsl:sequence select="tei:range(.,'IsMusicalSymbols','MusicalSymbols')"/>
<xsl:sequence select="tei:range(.,'IsAncientGreekMusicalNotation','AncientGreekMusicalNotation')"/>
<xsl:sequence select="tei:range(.,'IsTaiXuanJingSymbols','TaiXuanJingSymbols')"/>
<xsl:sequence select="tei:range(.,'IsCountingRodNumerals','CountingRodNumerals')"/>
<xsl:sequence select="tei:range(.,'IsMathematicalAlphanumericSymbols','MathematicalAlphanumericSymbols')"/>
<xsl:sequence select="tei:range(.,'IsMahjongTiles','MahjongTiles')"/>
<xsl:sequence select="tei:range(.,'IsDominoTiles','DominoTiles')"/>
<xsl:sequence select="tei:range(.,'IsPlayingCards','PlayingCards')"/>
<xsl:sequence select="tei:range(.,'IsEnclosedAlphanumericSupplement','EnclosedAlphanumericSupplement')"/>
<xsl:sequence select="tei:range(.,'IsEnclosedIdeographicSupplement','EnclosedIdeographicSupplement')"/>
<xsl:sequence select="tei:range(.,'IsMiscellaneousSymbolsAndPictographs','MiscellaneousSymbolsAndPictographs')"/>
<xsl:sequence select="tei:range(.,'IsEmoticons','Emoticons')"/>
<xsl:sequence select="tei:range(.,'IsTransportAndMapSymbols','TransportAndMapSymbols')"/>
<xsl:sequence select="tei:range(.,'IsAlchemicalSymbols','AlchemicalSymbols')"/>
<xsl:sequence select="tei:range(.,'IsCJKUnifiedIdeographsExtensionB','CJKUnifiedIdeographsExtensionB')"/>
<xsl:sequence select="tei:range(.,'IsCJKUnifiedIdeographsExtensionB','CJKUnifiedIdeographsExtensionB')"/>
<xsl:sequence select="tei:range(.,'IsCJKUnifiedIdeographsExtensionC','CJKUnifiedIdeographsExtensionC')"/>
<xsl:sequence select="tei:range(.,'IsCJKUnifiedIdeographsExtensionD','CJKUnifiedIdeographsExtensionD')"/>
<xsl:sequence select="tei:range(.,'IsCJKCompatibilityIdeographsSupplement','CJKCompatibilityIdeographsSupplement')"/>
<xsl:sequence select="tei:range(.,'IsTags','Tags')"/>
<xsl:sequence select="tei:range(.,'IsVariationSelectorsSupplement','VariationSelectorsSupplement')"/>
<xsl:sequence select="tei:range(.,'IsPrivateUse','PrivateUse')"/>
<xsl:sequence select="tei:range(.,'IsSupplementaryPrivateUseArea-A','SupplementaryPrivateUseArea-A')"/>
<xsl:sequence select="tei:range(.,'IsPrivateUse','PrivateUse')"/>
<xsl:sequence select="tei:range(.,'IsSupplementaryPrivateUseArea-B','SupplementaryPrivateUseArea-B')"/>
</xsl:template>

<xsl:function name="tei:hex">
    <xsl:param name="x" />
    <xsl:value-of select="if (empty($x)) then 0 else ($x[last()] + 16* tei:hex($x[position()!=last()]))"/>
  </xsl:function>

<xsl:function name="tei:range" as="node()*">
  <xsl:param name="text"/>
  <xsl:param name="key"/>
  <xsl:param name="name"/>
  <xsl:variable name="r" select="concat('\p{',$key,'}')"/>
  <xsl:if test="matches($text,$r)">
  <range n="{$name}">
    <xsl:value-of select="replace($text,concat('[^',$r,']'),'')"/>
  </range>
  </xsl:if>
</xsl:function>

</xsl:stylesheet>
<!--
#x0000–#x007F IsBasicLatin
#x0080–#x00FF IsLatin-1Supplement
#x0100–#x017F IsLatinExtended-A
#x0180–#x024F IsLatinExtended-B
#x0250–#x02AF IsIPAExtensions
#x02B0–#x02FF IsSpacingModifierLetters
#x0300–#x036F IsCombiningDiacriticalMarks
#x0370–#x03FF IsGreek
#x0370–#x03FF IsGreekandCoptic
#x0400–#x04FF IsCyrillic
#x0500–#x052F IsCyrillicSupplementary
#x0500–#x052F IsCyrillicSupplement
#x0530–#x058F IsArmenian
#x0590–#x05FF IsHebrew
#x0600–#x06FF IsArabic
#x0700–#x074F IsSyriac
#x0750–#x077F IsArabicSupplement
#x0780–#x07BF IsThaana
#x07C0–#x07FF IsNKo
#x0800–#x083F IsSamaritan
#x0840–#x085F IsMandaic
#x0900–#x097F IsDevanagari
#x0980–#x09FF IsBengali
#x0A00–#x0A7F IsGurmukhi
#x0A80–#x0AFF IsGujarati
#x0B00–#x0B7F IsOriya
#x0B80–#x0BFF IsTamil
#x0C00–#x0C7F IsTelugu
#x0C80–#x0CFF IsKannada
#x0D00–#x0D7F IsMalayalam
#x0D80–#x0DFF IsSinhala
#x0E00–#x0E7F IsThai
#x0E80–#x0EFF IsLao
#x0F00–#x0FBF IsTibetan
#x0F00–#x0FFF IsTibetan
#x1000–#x109F IsMyanmar
#x10A0–#x10FF IsGeorgian
#x1100–#x11FF IsHangulJamo
#x1200–#x137F IsEthiopic
#x1380–#x139F IsEthiopicSupplement
#x13A0–#x13FF IsCherokee
#x1400–#x167F IsUnifiedCanadianAboriginalSyllabics
#x1680–#x169F IsOgham
#x16A0–#x16FF IsRunic
#x1700–#x171F IsTagalog
#x1720–#x173F IsHanunoo
#x1740–#x175F IsBuhid
#x1760–#x177F IsTagbanwa
#x1780–#x17FF IsKhmer
#x1800–#x18AF IsMongolian
#x18B0–#x18FF IsUnifiedCanadianAboriginalSyllabicsExtended
#x1900–#x194F IsLimbu
#x1950–#x197F IsTaiLe
#x1980–#x19DF IsNewTaiLue
#x19E0–#x19FF IsKhmerSymbols
#x1A00–#x1A1F IsBuginese
#x1A20–#x1AAF IsTaiTham
#x1B00–#x1B7F IsBalinese
#x1B80–#x1BBF IsSundanese
#x1BC0–#x1BFF IsBatak
#x1C00–#x1C4F IsLepcha
#x1C50–#x1C7F IsOlChiki
#x1CD0–#x1CFF IsVedicExtensions
#x1D00–#x1D7F IsPhoneticExtensions
#x1D80–#x1DBF IsPhoneticExtensionsSupplement
#x1DC0–#x1DFF IsCombiningDiacriticalMarksSupplement
#x1E00–#x1EFF IsLatinExtendedAdditional
#x1F00–#x1FFF IsGreekExtended
#x2000–#x206F IsGeneralPunctuation
#x2070–#x209F IsSuperscriptsandSubscripts
#x20A0–#x20CF IsCurrencySymbols
#x20D0–#x20FF IsCombiningMarksforSymbols
#x20D0–#x20FF IsCombiningDiacriticalMarksforSymbols
#x2100–#x214F IsLetterlikeSymbols
#x2150–#x218F IsNumberForms
#x2190–#x21FF IsArrows
#x2200–#x22FF IsMathematicalOperators
#x2300–#x23FF IsMiscellaneousTechnical
#x2400–#x243F IsControlPictures
#x2440–#x245F IsOpticalCharacterRecognition
#x2460–#x24FF IsEnclosedAlphanumerics
#x2500–#x257F IsBoxDrawing
#x2580–#x259F IsBlockElements
#x25A0–#x25FF IsGeometricShapes
#x2600–#x26FF IsMiscellaneousSymbols
#x2700–#x27BF IsDingbats
#x27C0–#x27EF IsMiscellaneousMathematicalSymbols-A
#x27F0–#x27FF IsSupplementalArrows-A
#x2800–#x28FF IsBraillePatterns
#x2900–#x297F IsSupplementalArrows-B
#x2980–#x29FF IsMiscellaneousMathematicalSymbols-B
#x2A00–#x2AFF IsSupplementalMathematicalOperators
#x2B00–#x2BFF IsMiscellaneousSymbolsandArrows
#x2C00–#x2C5F IsGlagolitic
#x2C60–#x2C7F IsLatinExtended-C
#x2C80–#x2CFF IsCoptic
#x2D00–#x2D2F IsGeorgianSupplement
#x2D30–#x2D7F IsTifinagh
#x2D80–#x2DDF IsEthiopicExtended
#x2DE0–#x2DFF IsCyrillicExtended-A
#x2E00–#x2E7F IsSupplementalPunctuation
#x2E80–#x2EFF IsCJKRadicalsSupplement
#x2F00–#x2FDF IsKangxiRadicals
#x2FF0–#x2FFF IsIdeographicDescriptionCharacters
#x3000–#x303F IsCJKSymbolsandPunctuation
#x3040–#x309F IsHiragana
#x30A0–#x30FF IsKatakana
#x3100–#x312F IsBopomofo
#x3130–#x318F IsHangulCompatibilityJamo
#x3190–#x319F IsKanbun
#x31A0–#x31BF IsBopomofoExtended
#x31C0–#x31EF IsCJKStrokes
#x31F0–#x31FF IsKatakanaPhoneticExtensions
#x3200–#x32FF IsEnclosedCJKLettersandMonths
#x3300–#x33FF IsCJKCompatibility
#x3400–#x4DB5 IsCJKUnifiedIdeographsExtensionA
#x3400–#x4DBF IsCJKUnifiedIdeographsExtensionA
#x4DC0–#x4DFF IsYijingHexagramSymbols
#x4E00–#x9FFF IsCJKUnifiedIdeographs
#xA000–#xA48F IsYiSyllables
#xA490–#xA4CF IsYiRadicals
#xA4D0–#xA4FF IsLisu
#xA500–#xA63F IsVai
#xA640–#xA69F IsCyrillicExtended-B
#xA6A0–#xA6FF IsBamum
#xA700–#xA71F IsModifierToneLetters
#xA720–#xA7FF IsLatinExtended-D
#xA800–#xA82F IsSylotiNagri
#xA830–#xA83F IsCommonIndicNumberForms
#xA840–#xA87F IsPhags-pa
#xA880–#xA8DF IsSaurashtra
#xA8E0–#xA8FF IsDevanagariExtended
#xA900–#xA92F IsKayahLi
#xA930–#xA95F IsRejang
#xA960–#xA97F IsHangulJamoExtended-A
#xA980–#xA9DF IsJavanese
#xAA00–#xAA5F IsCham
#xAA60–#xAA7F IsMyanmarExtended-A
#xAA80–#xAADF IsTaiViet
#xAB00–#xAB2F IsEthiopicExtended-A
#xABC0–#xABFF IsMeeteiMayek
#xAC00–#xD7A3 IsHangulSyllables
#xAC00–#xD7AF IsHangulSyllables
#xD7B0–#xD7FF IsHangulJamoExtended-B
#xD800–#xDB7F IsHighSurrogates
#xDB80–#xDBFF IsHighPrivateUseSurrogates
#xDC00–#xDFFF IsLowSurrogates
#xE000–#xF8FF IsPrivateUse
#xE000–#xF8FF IsPrivateUseArea
#xF900–#xFAFF IsCJKCompatibilityIdeographs
#xFB00–#xFB4F IsAlphabeticPresentationForms
#xFB50–#xFDFF IsArabicPresentationForms-A
#xFE00–#xFE0F IsVariationSelectors
#xFE10–#xFE1F IsVerticalForms
#xFE20–#xFE2F IsCombiningHalfMarks
#xFE30–#xFE4F IsCJKCompatibilityForms
#xFE50–#xFE6F IsSmallFormVariants
#xFE70–#xFEFE IsArabicPresentationForms-B
#xFE70–#xFEFF IsArabicPresentationForms-B
#xFEFF–#xFEFF IsSpecials
#xFF00–#xFFEF IsHalfwidthandFullwidthForms
#xFFF0–#xFFFD IsSpecials
#xFFF0–#xFFFF IsSpecials
#x10000–#x1007F IsLinearBSyllabary
#x10080–#x100FF IsLinearBIdeograms
#x10100–#x1013F IsAegeanNumbers
#x10140–#x1018F IsAncientGreekNumbers
#x10190–#x101CF IsAncientSymbols
#x101D0–#x101FF IsPhaistosDisc
#x10280–#x1029F IsLycian
#x102A0–#x102DF IsCarian
#x10300–#x1032F IsOldItalic
#x10330–#x1034F IsGothic
#x10380–#x1039F IsUgaritic
#x103A0–#x103DF IsOldPersian
#x10400–#x1044F IsDeseret
#x10450–#x1047F IsShavian
#x10480–#x104AF IsOsmanya
#x10800–#x1083F IsCypriotSyllabary
#x10840–#x1085F IsImperialAramaic
#x10900–#x1091F IsPhoenician
#x10920–#x1093F IsLydian
#x10A00–#x10A5F IsKharoshthi
#x10A60–#x10A7F IsOldSouthArabian
#x10B00–#x10B3F IsAvestan
#x10B40–#x10B5F IsInscriptionalParthian
#x10B60–#x10B7F IsInscriptionalPahlavi
#x10C00–#x10C4F IsOldTurkic
#x10E60–#x10E7F IsRumiNumeralSymbols
#x11000–#x1107F IsBrahmi
#x11080–#x110CF IsKaithi
#x12000–#x123FF IsCuneiform
#x12400–#x1247F IsCuneiformNumbersandPunctuation
#x13000–#x1342F IsEgyptianHieroglyphs
#x16800–#x16A3F IsBamumSupplement
#x1B000–#x1B0FF IsKanaSupplement
#x1D000–#x1D0FF IsByzantineMusicalSymbols
#x1D100–#x1D1FF IsMusicalSymbols
#x1D200–#x1D24F IsAncientGreekMusicalNotation
#x1D300–#x1D35F IsTaiXuanJingSymbols
#x1D360–#x1D37F IsCountingRodNumerals
#x1D400–#x1D7FF IsMathematicalAlphanumericSymbols
#x1F000–#x1F02F IsMahjongTiles
#x1F030–#x1F09F IsDominoTiles
#x1F0A0–#x1F0FF IsPlayingCards
#x1F100–#x1F1FF IsEnclosedAlphanumericSupplement
#x1F200–#x1F2FF IsEnclosedIdeographicSupplement
#x1F300–#x1F5FF IsMiscellaneousSymbolsAndPictographs
#x1F600–#x1F64F IsEmoticons
#x1F680–#x1F6FF IsTransportAndMapSymbols
#x1F700–#x1F77F IsAlchemicalSymbols
#x20000–#x2A6D6 IsCJKUnifiedIdeographsExtensionB
#x20000–#x2A6DF IsCJKUnifiedIdeographsExtensionB
#x2A700–#x2B73F IsCJKUnifiedIdeographsExtensionC
#x2B740–#x2B81F IsCJKUnifiedIdeographsExtensionD
#x2F800–#x2FA1F IsCJKCompatibilityIdeographsSupplement
#xE0000–#xE007F IsTags
#xE0100–#xE01EF IsVariationSelectorsSupplement
#xF0000–#xFFFFD IsPrivateUse
#xF0000–#xFFFFF IsSupplementaryPrivateUseArea-A
#x100000–#x10FFFD IsPrivateUse
#x100000–#x10FFFF IsSupplementaryPrivateUseArea-B
-->
