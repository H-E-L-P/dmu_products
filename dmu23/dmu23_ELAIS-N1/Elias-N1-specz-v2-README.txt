CDFS Spectroscopic Merged Catalogue README - version 1.0

Description of columns:

Column 0, "RA":
The RA coordinates of the object targeted in degrees.

Column 1, "DEC":
The DEC coordinates of the object targeted in degrees.

Column 2, "Z_SPEC":
The spectroscopic redshift.

Column 3, "Z_SOURCE":
The source of the spectroscopic redshift, as the source of the redshift can be multiple surveys the source number can be a combination of the following values:
; Berta et al. (2007)						- 1
; SDSS DR13							- 2
; Trichas et al. (2010)						- 4
; Swinbank et al. (2007)					- 8
; Rowan-Robinson et al. (2013), WIYN/Keck/Gemini (Smith)	- 16
; Rowan-Robinson et al. (2013), NED Source*			- 32
; UZC catalogue							- 64

See below for more infomation on the different sources and any overlap. (* see info about these catalogues in other info)

* Only added unique sources from NED as it was possible that some of the other sources were present in the NED database.

Column 4, "Z_QUAL":

The quality flag (Q) is designated using the method from Colless et al. (2001) method (same as for the GAMA database which covers many Help fields). The quality flag (Q), is ranked on a five-point scale, with the interpretation: Q = 1 means no redshift could be estimated; Q = 2 means a possible, but doubtful, redshift estimate; Q = 3 means a probable redshift (notionally 90 per cent confidence), Q = 4 means a reliable redshift (notionally 99 per cent confidence); Q = 5 means a reliable redshift and a high-quality spectrum. Note that this quality parameter is determined entirely by the subjective judgement of the user.

For Source 1 (Berta et al., 2007) a discussion of the reliability of the redshifts is not made. We have decided mark all redshifts from only one emission/absorbtion line as Q = 2, if two or more lines are detected we set Q = 3. For Trichas et al. (2010) a flag is provided for spectra with one bright emission line, we have chosen to list this as Q = 2. For the two Rowan-Robinson sources used in this catalogue no information is available so we have assumed they are reliable (at time of writing the source of the large set of redshifts from WIYN/Keck/Gemini cannoth be located).


Column 5, "OBJID"

Object ID where the name depends on the source of the spectroscopic measurement. 

Information on selection functions/completness can be found in the seperate pdf document.


Other info:

To make this the redshifts have been prioritised in order of quality flags and the highest priority redshift is used. For catalogues which included redshifts for stars have been removed. Catalogues are typically matched given a 2" positional accuracy, however we check all matches up to 5" and assess which are real associations. Given the large number of redshifts we have very few conflicts, any conflicts where it was not obvious what was causing the problem are listed below and the choice made.

Conflicts:

This is a record of any conflicting sources when merging the catalohues (only for sources considered reliable Q >= 3) and don't have an obvious solution. 

SDSS 1237651540335788202 and Trichas 256 appear to be for the same object (0.6" seperation), but disagree. After viewing SDSS spectra have chosen its value. 
SDSS 1237662700789039725 and Trichas 236 appear to be for the same object (0.6" seperation), but disagree. After viewing SDSS spectra have chosen Trichas value. 
SDSS 1237665569290781211 and Trichas 173 appear to be for the same object (0.6" seperation), but disagree. After viewing SDSS spectra have chosen its value. 
SDSS 1237654950524682541 and Trichas 255 appear to be for the same object (0.4" seperation), but disagree. After viewing SDSS spectra have chosen its value. 
SDSS 1237662700789039361 and Trichas 269 appear to be for the same object (0.5" seperation), but disagree. Unable to view SDSS spectra have chosen Trichas value. 
SDSS 1237662700789170844 and Trichas 217 appear to be for the same object (1.3" seperation), but disagree. After viewing SDSS spectra have chosen Trichas value. 
SDSS 1237665569290781806 and Trichas 71 appear to be for the same object (0.8" seperation), but disagree. After viewing SDSS spectra have chosen Trichas value. 
SDSS 1237665569290781129 and Trichas 174 appear to be for the same object (0.03" seperation), but disagree slightly. After viewing SDSS spectra have chosen its value. 
