<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:tei="http://www.tei-c.org/ns/1.0" xmlns:n="www.example.com"
    xpath-default-namespace="http://www.tei-c.org/ns/1.0" 
    exclude-result-prefixes="xs"
    version="2.0">
    
    
    <xsl:template name="diagnose">
        <xsl:param name="content"/>
        
        <!--<xsl:sequence select="tei:range($content,'IsBasicLatin','BasicLatin')"/>-->
        <xsl:sequence select="tei:range($content,'IsLatin-1Supplement','Latin-1 Supplement')"/>
        <xsl:sequence select="tei:range($content,'IsLatinExtended-A','Latin Extended-A')"/>
        <xsl:sequence select="tei:range($content,'IsLatinExtended-B','Latin Extended-B')"/>
        <xsl:sequence select="tei:range($content,'IsIPAExtensions','IPA  Extensions')"/>
        <xsl:sequence select="tei:range($content,'IsSpacingModifierLetters','Spacing
            Modifier Letters')"/>
        <xsl:sequence
            select="tei:range($content,'IsCombiningDiacriticalMarks','Combining
            Diacritical Marks')"/>
        <xsl:sequence select="tei:range($content,'IsGreek','Greek')"/>
        <xsl:sequence select="tei:range($content,'IsGreekandCoptic','GreekandCoptic')"/>
        <xsl:sequence select="tei:range($content,'IsCyrillic','Cyrillic')"/>
        <xsl:sequence select="tei:range($content,'IsCyrillicSupplementary','Cyrillic Supplementary')"/>
        <xsl:sequence select="tei:range($content,'IsCyrillicSupplement','Cyrillic Supplement')"/>
        <xsl:sequence select="tei:range($content,'IsArmenian','Armenian')"/>
        <xsl:sequence select="tei:range($content,'IsHebrew','Hebrew')"/>
        <xsl:sequence select="tei:range($content,'IsArabic','Arabic')"/>
        <xsl:sequence select="tei:range($content,'IsSyriac','Syriac')"/>
        <xsl:sequence select="tei:range($content,'IsArabicSupplement','ArabicSupplement')"/>
        <xsl:sequence select="tei:range($content,'IsThaana','Thaana')"/>
        <xsl:sequence select="tei:range($content,'IsNKo','NKo')"/>
        <xsl:sequence select="tei:range($content,'IsSamaritan','Samaritan')"/>
        <xsl:sequence select="tei:range($content,'IsMandaic','Mandaic')"/>
        <xsl:sequence select="tei:range($content,'IsDevanagari','Devanagari')"/>
        <xsl:sequence select="tei:range($content,'IsBengali','Bengali')"/>
        <xsl:sequence select="tei:range($content,'IsGurmukhi','Gurmukhi')"/>
        <xsl:sequence select="tei:range($content,'IsGujarati','Gujarati')"/>
        <xsl:sequence select="tei:range($content,'IsOriya','Oriya')"/>
        <xsl:sequence select="tei:range($content,'IsTamil','Tamil')"/>
        <xsl:sequence select="tei:range($content,'IsTelugu','Telugu')"/>
        <xsl:sequence select="tei:range($content,'IsKannada','Kannada')"/>
        <xsl:sequence select="tei:range($content,'IsMalayalam','Malayalam')"/>
        <xsl:sequence select="tei:range($content,'IsSinhala','Sinhala')"/>
        <xsl:sequence select="tei:range($content,'IsThai','Thai')"/>
        <xsl:sequence select="tei:range($content,'IsLao','Lao')"/>
        <xsl:sequence select="tei:range($content,'IsTibetan','Tibetan')"/>
        <xsl:sequence select="tei:range($content,'IsMyanmar','Myanmar')"/>
        <xsl:sequence select="tei:range($content,'IsGeorgian','Georgian')"/>
        <xsl:sequence select="tei:range($content,'IsHangulJamo','HangulJamo')"/>
        <xsl:sequence select="tei:range($content,'IsEthiopic','Ethiopic')"/>
        <xsl:sequence select="tei:range($content,'IsEthiopicSupplement','EthiopicSupplement')"/>
        <xsl:sequence select="tei:range($content,'IsCherokee','Cherokee')"/>
        <xsl:sequence select="tei:range($content,'IsUnifiedCanadianAboriginalSyllabics','UnifiedCanadianAboriginalSyllabics')"/>
        <xsl:sequence select="tei:range($content,'IsOgham','Ogham')"/>
        <xsl:sequence select="tei:range($content,'IsRunic','Runic')"/>
        <xsl:sequence select="tei:range($content,'IsTagalog','Tagalog')"/>
        <xsl:sequence select="tei:range($content,'IsHanunoo','Hanunoo')"/>
        <xsl:sequence select="tei:range($content,'IsBuhid','Buhid')"/>
        <xsl:sequence select="tei:range($content,'IsTagbanwa','Tagbanwa')"/>
        <xsl:sequence select="tei:range($content,'IsKhmer','Khmer')"/>
        <xsl:sequence select="tei:range($content,'IsMongolian','Mongolian')"/>
        <xsl:sequence select="tei:range($content,'IsUnifiedCanadianAboriginalSyllabicsExtended','UnifiedCanadianAboriginalSyllabicsExtended')"/>
        <xsl:sequence select="tei:range($content,'IsLimbu','Limbu')"/>
        <xsl:sequence select="tei:range($content,'IsTaiLe','TaiLe')"/>
        <xsl:sequence select="tei:range($content,'IsNewTaiLue','NewTaiLue')"/>
        <xsl:sequence select="tei:range($content,'IsKhmerSymbols','KhmerSymbols')"/>
        <xsl:sequence select="tei:range($content,'IsBuginese','Buginese')"/>
        <xsl:sequence select="tei:range($content,'IsTaiTham','TaiTham')"/>
        <xsl:sequence select="tei:range($content,'IsBalinese','Balinese')"/>
        <xsl:sequence select="tei:range($content,'IsSundanese','Sundanese')"/>
        <xsl:sequence select="tei:range($content,'IsBatak','Batak')"/>
        <xsl:sequence select="tei:range($content,'IsLepcha','Lepcha')"/>
        <xsl:sequence select="tei:range($content,'IsOlChiki','OlChiki')"/>
        <xsl:sequence select="tei:range($content,'IsVedicExtensions','VedicExtensions')"/>
        <xsl:sequence select="tei:range($content,'IsPhoneticExtensions','PhoneticExtensions')"/>
        <xsl:sequence
            select="tei:range($content,'IsPhoneticExtensionsSupplement','Phonetic
            Extensions Supplement')"/>
        <xsl:sequence
            select="tei:range($content,'IsCombiningDiacriticalMarksSupplement','Combining
            DiacriticalMarks Supplement')"/>
        <xsl:sequence select="tei:range($content,'IsLatinExtendedAdditional','Latin ExtendedAdditional')"/>
        <xsl:sequence select="tei:range($content,'IsGreekExtended','GreekExtended')"/>
        <xsl:sequence select="tei:range($content,'IsGeneralPunctuation','General Punctuation')"/>
        <xsl:sequence
            select="tei:range($content,'IsSuperscriptsandSubscripts','Superscripts
            and Subscripts')"/>
        <xsl:sequence select="tei:range($content,'IsCurrencySymbols','CurrencySymbols')"/>
        <xsl:sequence
            select="tei:range($content,'IsCombiningMarksforSymbols','Combining MarksforSymbols')"/>
        <xsl:sequence
            select="tei:range($content,'IsCombiningDiacriticalMarksforSymbols','Combining
            Diacritical Marks for Symbols')"/>
        <xsl:sequence select="tei:range($content,'IsLetterlikeSymbols','Letterlike Symbols')"/>
        <xsl:sequence select="tei:range($content,'IsNumberForms','Number Forms')"/>
        <xsl:sequence select="tei:range($content,'IsArrows','Arrows')"/>
        <xsl:sequence
            select="tei:range($content,'IsMathematicalOperators','Mathematical Operators')"/>
        <xsl:sequence
            select="tei:range($content,'IsMiscellaneousTechnical','Miscellaneous Technical')"/>
        <xsl:sequence select="tei:range($content,'IsControlPictures','ControlPictures')"/>
        <xsl:sequence
            select="tei:range($content,'IsOpticalCharacterRecognition','Optical
            Character Recognition')"/>
        <xsl:sequence select="tei:range($content,'IsEnclosedAlphanumerics','Enclosed Alphanumerics')"/>
        <xsl:sequence select="tei:range($content,'IsBoxDrawing','Box Drawing')"/>
        <xsl:sequence select="tei:range($content,'IsBlockElements','Block Elements')"/>
        <xsl:sequence select="tei:range($content,'IsGeometricShapes','Geometric Shapes')"/>
        <xsl:sequence
            select="tei:range($content,'IsMiscellaneousSymbols','Miscellaneous Symbols')"/>
        <xsl:sequence select="tei:range($content,'IsDingbats','Dingbats')"/>
        <xsl:sequence select="tei:range($content,'IsMiscellaneousMathematicalSymbols-A','MiscellaneousMathematicalSymbols-A')"/>
        <xsl:sequence select="tei:range($content,'IsSupplementalArrows-A','SupplementalArrows-A')"/>
        <xsl:sequence select="tei:range($content,'IsBraillePatterns','BraillePatterns')"/>
        <xsl:sequence select="tei:range($content,'IsSupplementalArrows-B','SupplementalArrows-B')"/>
        <xsl:sequence select="tei:range($content,'IsMiscellaneousMathematicalSymbols-B','MiscellaneousMathematicalSymbols-B')"/>
        <xsl:sequence
            select="tei:range($content,'IsSupplementalMathematicalOperators','Supplemental
            MathematicalOperators')"/>
        <xsl:sequence
            select="tei:range($content,'IsMiscellaneousSymbolsandArrows','Miscellaneous
            Symbols and Arrows')"/>
        <xsl:sequence select="tei:range($content,'IsGlagolitic','Glagolitic')"/>
        <xsl:sequence select="tei:range($content,'IsLatinExtended-C','Latin Extended-C')"/>
        <xsl:sequence select="tei:range($content,'IsCoptic','Coptic')"/>
        <xsl:sequence select="tei:range($content,'IsGeorgianSupplement','GeorgianSupplement')"/>
        <xsl:sequence select="tei:range($content,'IsTifinagh','Tifinagh')"/>
        <xsl:sequence select="tei:range($content,'IsEthiopicExtended','Ethiopic Extended')"/>
        <xsl:sequence select="tei:range($content,'IsCyrillicExtended-A','Cyrillic Extended-A')"/>
        <xsl:sequence select="tei:range($content,'IsSupplementalPunctuation','SupplementalPunctuation')"/>
        <xsl:sequence select="tei:range($content,'IsCJKRadicalsSupplement','CJKRadicalsSupplement')"/>
        <xsl:sequence select="tei:range($content,'IsKangxiRadicals','KangxiRadicals')"/>
        <xsl:sequence select="tei:range($content,'IsIdeographicDescriptionCharacters','IdeographicDescriptionCharacters')"/>
        <xsl:sequence select="tei:range($content,'IsCJKSymbolsandPunctuation','CJKSymbolsandPunctuation')"/>
        <xsl:sequence select="tei:range($content,'IsHiragana','Hiragana')"/>
        <xsl:sequence select="tei:range($content,'IsKatakana','Katakana')"/>
        <xsl:sequence select="tei:range($content,'IsBopomofo','Bopomofo')"/>
        <xsl:sequence select="tei:range($content,'IsHangulCompatibilityJamo','HangulCompatibilityJamo')"/>
        <xsl:sequence select="tei:range($content,'IsKanbun','Kanbun')"/>
        <xsl:sequence select="tei:range($content,'IsBopomofoExtended','BopomofoExtended')"/>
        <xsl:sequence select="tei:range($content,'IsCJKStrokes','CJKStrokes')"/>
        <xsl:sequence select="tei:range($content,'IsKatakanaPhoneticExtensions','KatakanaPhoneticExtensions')"/>
        <xsl:sequence select="tei:range($content,'IsEnclosedCJKLettersandMonths','EnclosedCJKLettersandMonths')"/>
        <xsl:sequence select="tei:range($content,'IsCJKCompatibility','CJKCompatibility')"/>
        <xsl:sequence select="tei:range($content,'IsCJKUnifiedIdeographsExtensionA','CJKUnifiedIdeographsExtensionA')"/>
        <xsl:sequence select="tei:range($content,'IsCJKUnifiedIdeographsExtensionA','CJKUnifiedIdeographsExtensionA')"/>
        <xsl:sequence select="tei:range($content,'IsYijingHexagramSymbols','YijingHexagramSymbols')"/>
        <xsl:sequence select="tei:range($content,'IsCJKUnifiedIdeographs','CJKUnifiedIdeographs')"/>
        <xsl:sequence select="tei:range($content,'IsYiSyllables','YiSyllables')"/>
        <xsl:sequence select="tei:range($content,'IsYiRadicals','YiRadicals')"/>
        <xsl:sequence select="tei:range($content,'IsLisu','Lisu')"/>
        <xsl:sequence select="tei:range($content,'IsVai','Vai')"/>
        <xsl:sequence select="tei:range($content,'IsCyrillicExtended-B','CyrillicExtended-B')"/>
        <xsl:sequence select="tei:range($content,'IsBamum','Bamum')"/>
        <xsl:sequence select="tei:range($content,'IsModifierToneLetters','ModifierToneLetters')"/>
        <xsl:sequence select="tei:range($content,'IsLatinExtended-D','LatinExtended-D')"/>
        <xsl:sequence select="tei:range($content,'IsSylotiNagri','SylotiNagri')"/>
        <xsl:sequence select="tei:range($content,'IsCommonIndicNumberForms','CommonIndicNumberForms')"/>
        <xsl:sequence select="tei:range($content,'IsPhags-pa','Phags-pa')"/>
        <xsl:sequence select="tei:range($content,'IsSaurashtra','Saurashtra')"/>
        <xsl:sequence select="tei:range($content,'IsDevanagariExtended','DevanagariExtended')"/>
        <xsl:sequence select="tei:range($content,'IsKayahLi','KayahLi')"/>
        <xsl:sequence select="tei:range($content,'IsRejang','Rejang')"/>
        <xsl:sequence select="tei:range($content,'IsHangulJamoExtended-A','HangulJamoExtended-A')"/>
        <xsl:sequence select="tei:range($content,'IsJavanese','Javanese')"/>
        <xsl:sequence select="tei:range($content,'IsCham','Cham')"/>
        <xsl:sequence select="tei:range($content,'IsMyanmarExtended-A','MyanmarExtended-A')"/>
        <xsl:sequence select="tei:range($content,'IsTaiViet','TaiViet')"/>
        <xsl:sequence select="tei:range($content,'IsEthiopicExtended-A','EthiopicExtended-A')"/>
        <xsl:sequence select="tei:range($content,'IsMeeteiMayek','MeeteiMayek')"/>
        <xsl:sequence select="tei:range($content,'IsHangulSyllables','HangulSyllables')"/>
        <xsl:sequence select="tei:range($content,'IsHangulSyllables','HangulSyllables')"/>
        <xsl:sequence select="tei:range($content,'IsHangulJamoExtended-B','HangulJamoExtended-B')"/>
        <xsl:sequence select="tei:range($content,'IsHighSurrogates','HighSurrogates')"/>
        <xsl:sequence select="tei:range($content,'IsHighPrivateUseSurrogates','HighPrivateUseSurrogates')"/>
        <xsl:sequence select="tei:range($content,'IsLowSurrogates','LowSurrogates')"/>
        <xsl:sequence select="tei:range($content,'IsPrivateUse','PrivateUse')"/>
        <xsl:sequence select="tei:range($content,'IsPrivateUseArea','PrivateUseArea')"/>
        <xsl:sequence select="tei:range($content,'IsCJKCompatibilityIdeographs','CJKCompatibilityIdeographs')"/>
        <xsl:sequence select="tei:range($content,'IsAlphabeticPresentationForms','AlphabeticPresentationForms')"/>
        <xsl:sequence select="tei:range($content,'IsArabicPresentationForms-A','ArabicPresentationForms-A')"/>
        <xsl:sequence select="tei:range($content,'IsVariationSelectors','VariationSelectors')"/>
        <xsl:sequence select="tei:range($content,'IsVerticalForms','VerticalForms')"/>
        <xsl:sequence select="tei:range($content,'IsCombiningHalfMarks','CombiningHalfMarks')"/>
        <xsl:sequence select="tei:range($content,'IsCJKCompatibilityForms','CJKCompatibilityForms')"/>
        <xsl:sequence select="tei:range($content,'IsSmallFormVariants','SmallFormVariants')"/>
        <xsl:sequence select="tei:range($content,'IsArabicPresentationForms-B','ArabicPresentationForms-B')"/>
        <xsl:sequence select="tei:range($content,'IsArabicPresentationForms-B','ArabicPresentationForms-B')"/>
        <xsl:sequence select="tei:range($content,'IsSpecials','Specials')"/>
        <xsl:sequence select="tei:range($content,'IsHalfwidthandFullwidthForms','HalfwidthandFullwidthForms')"/>
        <xsl:sequence select="tei:range($content,'IsSpecials','Specials')"/>
        <xsl:sequence select="tei:range($content,'IsSpecials','Specials')"/>
        <xsl:sequence select="tei:range($content,'IsLinearBSyllabary','LinearBSyllabary')"/>
        <xsl:sequence select="tei:range($content,'IsLinearBIdeograms','LinearBIdeograms')"/>
        <xsl:sequence select="tei:range($content,'IsAegeanNumbers','AegeanNumbers')"/>
        <xsl:sequence select="tei:range($content,'IsAncientGreekNumbers','AncientGreekNumbers')"/>
        <xsl:sequence select="tei:range($content,'IsAncientSymbols','AncientSymbols')"/>
        <xsl:sequence select="tei:range($content,'IsPhaistosDisc','PhaistosDisc')"/>
        <xsl:sequence select="tei:range($content,'IsLycian','Lycian')"/>
        <xsl:sequence select="tei:range($content,'IsCarian','Carian')"/>
        <xsl:sequence select="tei:range($content,'IsOldItalic','OldItalic')"/>
        <xsl:sequence select="tei:range($content,'IsGothic','Gothic')"/>
        <xsl:sequence select="tei:range($content,'IsUgaritic','Ugaritic')"/>
        <xsl:sequence select="tei:range($content,'IsOldPersian','OldPersian')"/>
        <xsl:sequence select="tei:range($content,'IsDeseret','Deseret')"/>
        <xsl:sequence select="tei:range($content,'IsShavian','Shavian')"/>
        <xsl:sequence select="tei:range($content,'IsOsmanya','Osmanya')"/>
        <xsl:sequence select="tei:range($content,'IsCypriotSyllabary','CypriotSyllabary')"/>
        <xsl:sequence select="tei:range($content,'IsImperialAramaic','ImperialAramaic')"/>
        <xsl:sequence select="tei:range($content,'IsPhoenician','Phoenician')"/>
        <xsl:sequence select="tei:range($content,'IsLydian','Lydian')"/>
        <xsl:sequence select="tei:range($content,'IsKharoshthi','Kharoshthi')"/>
        <xsl:sequence select="tei:range($content,'IsOldSouthArabian','OldSouthArabian')"/>
        <xsl:sequence select="tei:range($content,'IsAvestan','Avestan')"/>
        <xsl:sequence select="tei:range($content,'IsInscriptionalParthian','InscriptionalParthian')"/>
        <xsl:sequence select="tei:range($content,'IsInscriptionalPahlavi','InscriptionalPahlavi')"/>
        <xsl:sequence select="tei:range($content,'IsOldTurkic','OldTurkic')"/>
        <xsl:sequence select="tei:range($content,'IsRumiNumeralSymbols','RumiNumeralSymbols')"/>
        <xsl:sequence select="tei:range($content,'IsBrahmi','Brahmi')"/>
        <xsl:sequence select="tei:range($content,'IsKaithi','Kaithi')"/>
        <xsl:sequence select="tei:range($content,'IsCuneiform','Cuneiform')"/>
        <xsl:sequence select="tei:range($content,'IsCuneiformNumbersandPunctuation','CuneiformNumbersandPunctuation')"/>
        <xsl:sequence select="tei:range($content,'IsEgyptianHieroglyphs','EgyptianHieroglyphs')"/>
        <xsl:sequence select="tei:range($content,'IsBamumSupplement','BamumSupplement')"/>
        <xsl:sequence select="tei:range($content,'IsKanaSupplement','KanaSupplement')"/>
        <xsl:sequence select="tei:range($content,'IsByzantineMusicalSymbols','ByzantineMusicalSymbols')"/>
        <xsl:sequence select="tei:range($content,'IsMusicalSymbols','MusicalSymbols')"/>
        <xsl:sequence select="tei:range($content,'IsAncientGreekMusicalNotation','AncientGreekMusicalNotation')"/>
        <xsl:sequence select="tei:range($content,'IsTaiXuanJingSymbols','TaiXuanJingSymbols')"/>
        <xsl:sequence select="tei:range($content,'IsCountingRodNumerals','CountingRodNumerals')"/>
        <xsl:sequence select="tei:range($content,'IsMathematicalAlphanumericSymbols','MathematicalAlphanumericSymbols')"/>
        <xsl:sequence select="tei:range($content,'IsMahjongTiles','MahjongTiles')"/>
        <xsl:sequence select="tei:range($content,'IsDominoTiles','DominoTiles')"/>
        <xsl:sequence select="tei:range($content,'IsPlayingCards','PlayingCards')"/>
        <xsl:sequence select="tei:range($content,'IsEnclosedAlphanumericSupplement','EnclosedAlphanumericSupplement')"/>
        <xsl:sequence select="tei:range($content,'IsEnclosedIdeographicSupplement','EnclosedIdeographicSupplement')"/>
        <xsl:sequence select="tei:range($content,'IsMiscellaneousSymbolsAndPictographs','MiscellaneousSymbolsAndPictographs')"/>
        <xsl:sequence select="tei:range($content,'IsEmoticons','Emoticons')"/>
        <xsl:sequence select="tei:range($content,'IsTransportAndMapSymbols','TransportAndMapSymbols')"/>
        <xsl:sequence select="tei:range($content,'IsAlchemicalSymbols','AlchemicalSymbols')"/>
        <xsl:sequence select="tei:range($content,'IsCJKUnifiedIdeographsExtensionB','CJKUnifiedIdeographsExtensionB')"/>
        <xsl:sequence select="tei:range($content,'IsCJKUnifiedIdeographsExtensionB','CJKUnifiedIdeographsExtensionB')"/>
        <xsl:sequence select="tei:range($content,'IsCJKUnifiedIdeographsExtensionC','CJKUnifiedIdeographsExtensionC')"/>
        <xsl:sequence select="tei:range($content,'IsCJKUnifiedIdeographsExtensionD','CJKUnifiedIdeographsExtensionD')"/>
        <xsl:sequence select="tei:range($content,'IsCJKCompatibilityIdeographsSupplement','CJKCompatibilityIdeographsSupplement')"/>
        <xsl:sequence select="tei:range($content,'IsTags','Tags')"/>
        <xsl:sequence select="tei:range($content,'IsVariationSelectorsSupplement','VariationSelectorsSupplement')"/>
        <xsl:sequence select="tei:range($content,'IsPrivateUse','PrivateUse')"/>
        <xsl:sequence select="tei:range($content,'IsSupplementaryPrivateUseArea-A','SupplementaryPrivateUseArea-A')"/>
        <xsl:sequence select="tei:range($content,'IsPrivateUse','PrivateUse')"/>
        <xsl:sequence select="tei:range($content,'IsSupplementaryPrivateUseArea-B','SupplementaryPrivateUseArea-B')"/>
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
            <tei:range n="{$name}">
                <xsl:value-of select="replace($text,concat('[^',$r,']'),'')"/>
            </tei:range>
        </xsl:if>
    </xsl:function>
    
    
</xsl:stylesheet>