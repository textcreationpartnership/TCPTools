EEBO
====

##Summary .md files generator for TEI files##

**Warning**: *Under construction. This file documents the intents, not necessarilly current output.*

###Sections###

1. General
1. Content Summary
1. Header Summary
1. Tag Usage Summary

####General#####
  * Expose availability element content so people know what licence it is under
  * If there is a particDesc/listPerson or settingDesc/listPlacethen list the number of people/places?

####Content Summary####

Content summary is a table of contents for the document. Where no internal hierarchy is present, the incipit is given.

Ideas for the content:
  * List _types_ of text content: I.e. is there drama? speech? prose? verse?
  * Is there a facsimile or sourceDoc?

####Header Summary####

*Currently off by default.* Header summary contains information harvested from teiHeader section of the document presented in human-readable form. High level elements eg fileDesc, profileDesc, encodingDesc are rendered as appropriate md headings using #

Some elements may get specific treatment to present data in traditional form (eg publicationStmt). Prose content is rendered as paragraphs. Structured content is rendered as lists.

Ideas for the header:
  * Expose availability element content so people know what licence it is under
  * List TitleStmt contents especially the respStmts
  * If there is a particDesc/listPerson or settingDesc/listPlacethen list the number of people/places?
  * Do something with it if there is a taxonomy?

####Tag Usage Summary####

  * element list (with frequency) plus nested attributes lists (with frequency and distinct attribute values listed as well)
  * special interest statistics
    - entities summary: listPerson, listPlace etc
    - transcriptional features summary (gaps, corrections, expansions, regularization etc)
    - critical apparatus summary (listWit, number of apparatus entries etc)
    - tbc
  * list distinct-values element/attribute name combinations inside //text
