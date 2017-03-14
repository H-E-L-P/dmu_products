Lockman-Hole Spectroscopic Merged Catalogue README - version 1.0

Description of columns:

Column 0, "RA":
The RA coordinates of the object targeted in degrees.

Column 1, "DEC":
The DEC coordinates of the object targeted in degrees.

Column 2, "Z_SPEC":
The spectroscopic redshift.

Column 3, "Z_SOURCE":
The source of the spectroscopic redshift, as the source of the redshift can be multiple surveys the source number can be a combination of the following values:
; Steffen et al. (2004)						- 1
; Berta et al. (2007)						- 2
; SDSS DR13							- 4
; Rowan-Robinson et al. (2013), NED Source 			- 8 
; Rowan-Robinson et al. (2013), WIYN/Keck/Gemini (Smith)	- 16
; 2MRS								- 32
; IRASpscz							- 64
; UZC								- 128

See below for more infomation on the different sources and any overlap. (* see info about these catalogues in other info)


Column 4, "Z_QUAL":

The quality flag (Q) is designated using the method from Colless et al. (2001) method (same as for the GAMA database which covers many Help fields). The quality flag (Q), is ranked on a five-point scale, with the interpretation: Q = 1 means no redshift could be estimated; Q = 2 means a possible, but doubtful, redshift estimate; Q = 3 means a probable redshift (notionally 90 per cent confidence), Q = 4 means a reliable redshift (notionally 99 per cent confidence); Q = 5 means a reliable redshift and a high-quality spectrum. Note that this quality parameter is determined entirely by the subjective judgement of the user.

In this catalogue, no reliability was given in the Steffen paper or any quality flags. We have assumed the redshifts that have been classified as successfull are reliable with Q = 3. For Source 2 (Berta et al., 2007) a discussion of the reliability of the redshifts is not made. We have decided mark all redshifts from only one emission/absorbtion line as Q = 2, if two or more lines are detected we set Q = 3. For the two Rowan-Robinson sources used in this catalogue no information is available so we have assumed they are reliable (at time of writing the source of the large set of redshifts from WIYN/Keck/Gemini cannoth be located).


Column 5, "OBJID"

Object ID where the name depends on the source of the spectroscopic measurement. 

Information on selection functions/completness can be found in the seperate pdf document.


Other info:

To make this the redshifts have been prioritised in order of quality flags and the highest priority redshift is used. For catalogues which included redshifts for stars have been removed. Catalogues are typically matched given a 2" positional accuracy, however we check all matches up to 5" and assess which are real associations. Given the large number of redshifts we have very few conflicts, any conflicts where it was not obvious what was causing the problem are listed below and the choice made.

Conflicts:

This is a record of any conflicting sources when merging the catalohues (only for sources considered reliable Q >= 3) and don't have an obvious solution. 

SDSS 1237658304890143322 from SDSS and SWIRE 413480 from source 16 disagree by 0.16 but are for the same galaxy. We went with the SDSS redshift.
SDSS 1237653616397582655 from SDSS and SWIRE 318707 from source 16 disagree by 0.16 but are for the same galaxy. We went with the SDSS redshift.
SDSS 1237655107299442915 from SDSS and SWIRE 574374 from source 16 disagree slightly but are for the same galaxy. We went with the SDSS redshift.
SDSS 1237658303816139433 from SDSS and SWIRE  297372 from source 16 disagree slightly but are for the same galaxy. We went with the SDSS redshift.
SDSS 1237658304890143107 from SDSS and SWIRE 377768 from source 16 disagree slightly but are for the same galaxy. We went with the SDSS redshift.
SDSS 1237658304353206466 from SDSS and SWIRE 380921 from source 16 disagree slightly but are for the same galaxy. We went with the SDSS redshift.
