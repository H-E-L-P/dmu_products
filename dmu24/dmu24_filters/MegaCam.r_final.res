<?xml version="1.0" encoding="utf-8"?>
<!-- Produced with astropy.io.votable version 1.3.3
     http://www.astropy.org/ -->
<VOTABLE version="1.1" xmlns="http://www.ivoa.net/xml/VOTable/v1.1" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:noNamespaceSchemaLocation="http://www.ivoa.net/xml/VOTable/v1.1">
 <PARAM ID="ForegroundExtinction" arraysize="*" datatype="float" name="ForegroundExtinction" unit="" value="2.54">
  <DESCRIPTION>
        Wavelength dependent extinction factor assuming Fitzpatrick
   1999 MW extinction curve and a flat input spectrum.      Magnitudes
   should be foreground corrected according to:           M_int,i =
   M_obs,i - E(B-V)*Ai          where M_int,i and M_obs,i are the
   intrinsic and observed magnitudes in the filter, i, and Ai is the
   filter specific extinction value.
  </DESCRIPTION>
 </PARAM>
 <INFO ID="QUERY_STATUS" name="QUERY_STATUS" value="OK"/>
 <RESOURCE type="results">
  <TABLE nrows="55" utype="photdm:PhotometryFilter.transmissionCurve.spectrum">
   <FIELD ID="Wavelength" datatype="float" name="Wavelength" ucd="em.wl" unit="AA" utype="spec:Data.SpectralAxis.Value"/>
   <FIELD ID="Transmission" datatype="float" name="Transmission" ucd="phys.transmission" utype="spec:Data.FluxAxis.Value"/>
   <PARAM ID="FilterProfileService" arraysize="*" datatype="char" name="FilterProfileService" ucd="meta.ref.ivorn" utype="PhotometryFilter.fpsIdentifier" value="ivo://svo/fps"/>
   <PARAM ID="filterID" arraysize="*" datatype="char" name="filterID" ucd="meta.id" utype="photdm:PhotometryFilter.identifier" value="CFHT/MegaCam.r"/>
   <PARAM ID="WavelengthUnit" arraysize="*" datatype="char" name="WavelengthUnit" ucd="meta.unit" utype="PhotometryFilter.SpectralAxis.unit" value="Angstrom"/>
   <PARAM ID="WavelengthUCD" arraysize="*" datatype="char" name="WavelengthUCD" ucd="meta.ucd" utype="PhotometryFilter.SpectralAxis.UCD" value="em.wl"/>
   <PARAM ID="Description" arraysize="*" datatype="char" name="Description" ucd="meta.note" utype="photdm:PhotometryFilter.description" value="MegaCam r  (includes CCD, mirror, optics)"/>
   <PARAM ID="PhotSystem" arraysize="*" datatype="char" name="PhotSystem" utype="photdm:PhotometricSystem.description" value="Megaprime">
    <DESCRIPTION>
     Photometric system
    </DESCRIPTION>
   </PARAM>
   <PARAM ID="Band" arraysize="*" datatype="char" name="Band" utype="photdm:PhotometryFilter.bandName" value="r"/>
   <PARAM ID="Instrument" arraysize="*" datatype="char" name="Instrument" ucd="instr" value="Megaprime">
    <DESCRIPTION>
     Instrument
    </DESCRIPTION>
   </PARAM>
   <PARAM ID="Facility" arraysize="*" datatype="char" name="Facility" ucd="instr.obsty" value="CFHT">
    <DESCRIPTION>
     Observational facility
    </DESCRIPTION>
   </PARAM>
   <PARAM ID="ProfileReference" arraysize="*" datatype="char" name="ProfileReference" value="http://www2.cadc-ccda.hia-iha.nrc-cnrc.gc.ca/megapipe/docs/filters.html"/>
   <PARAM ID="Description" arraysize="*" datatype="char" name="Description" ucd="meta.note" utype="photdm:PhotometryFilter.description" value="MegaCam r  (includes CCD, mirror, optics)"/>
   <PARAM ID="WavelengthMean" datatype="float" name="WavelengthMean" ucd="em.wl" unit="AA" utype="photdm:PhotometryFilter.SpectralAxis.Coverage.Location.Value" value="6257.9610055805">
    <DESCRIPTION>
     Mean wavelength. Defined as integ[x*filter(x) dx]/integ[filter(x)
     dx]
    </DESCRIPTION>
   </PARAM>
   <PARAM ID="WavelengthEff" datatype="float" name="WavelengthEff" ucd="em.wl.effective" unit="AA" value="6191.7200415029">
    <DESCRIPTION>
     Effective wavelength. Defined as integ[x*filter(x)*vega(x)
     dx]/integ[filter(x)*vega(x) dx]
    </DESCRIPTION>
   </PARAM>
   <PARAM ID="WavelengthMin" datatype="float" name="WavelengthMin" ucd="em.wl;stat.min" unit="AA" utype="photdm:PhotometryFilter.SpectralAxis.Coverage.Bounds.Start" value="5406.6642669887">
    <DESCRIPTION>
     Minimum filter wavelength. Defined as the first lambda value with
     a transmission at least 1% of maximum transmission
    </DESCRIPTION>
   </PARAM>
   <PARAM ID="WavelengthMax" datatype="float" name="WavelengthMax" ucd="em.wl;stat.max" unit="AA" utype="photdm:PhotometryFilter.SpectralAxis.Coverage.Bounds.Stop" value="7036.7065211981">
    <DESCRIPTION>
     Maximum filter wavelength. Defined as the last lambda value with
     a transmission at least 1% of maximum transmission
    </DESCRIPTION>
   </PARAM>
   <PARAM ID="WidthEff" datatype="float" name="WidthEff" ucd="instr.bandwidth" unit="AA" utype="photdm:PhotometryFilter.SpectralAxis.Coverage.Bounds.Extent" value="1099.1020793452">
    <DESCRIPTION>
     Effective width. Defined as integ[x*filter(x) dx].\nEquivalent to
     the horizontal size of a rectangle with height equal to maximum
     transmission and with the same area that the one covered by the
     filter transmission curve.
    </DESCRIPTION>
   </PARAM>
   <PARAM ID="WavelengthCen" datatype="float" name="WavelengthCen" ucd="em.wl" unit="AA" value="6275.726000817">
    <DESCRIPTION>
     Central wavelength. Defined as the central wavelength between the
     two points defining FWMH
    </DESCRIPTION>
   </PARAM>
   <PARAM ID="WavelengthPivot" datatype="float" name="WavelengthPivot" ucd="em.wl" unit="AA" value="6247.6459472934">
    <DESCRIPTION>
     Peak wavelength. Defined as sqrt{integ[x*filter(x)
     dx]/integ[filter(x) dx/x]}
    </DESCRIPTION>
   </PARAM>
   <PARAM ID="WavelengthPeak" datatype="float" name="WavelengthPeak" ucd="em.wl" unit="AA" value="6360">
    <DESCRIPTION>
     Peak wavelength. Defined as the lambda value with larger
     transmission
    </DESCRIPTION>
   </PARAM>
   <PARAM ID="WavelengthPhot" datatype="float" name="WavelengthPhot" ucd="em.wl" unit="AA" value="6212.3469941575">
    <DESCRIPTION>
     Photon distribution based effective wavelength. Defined as
     integ[x^2*filter(x)*vega(x) dx]/integ[x*filter(x)*vega(x) dx]
    </DESCRIPTION>
   </PARAM>
   <PARAM ID="FWHM" datatype="float" name="FWHM" ucd="instr.bandwidth" unit="AA" value="1218.7822097066">
    <DESCRIPTION>
     Full width at half maximum. Defined as the difference between the
     two wavelengths for which filter transmission is half maximum
    </DESCRIPTION>
   </PARAM>
   <PARAM ID="PhotCalID" arraysize="*" datatype="char" name="PhotCalID" ucd="meta.id" utype="photdm:PhotCal.identifier" value="CFHT/MegaCam.r/AB"/>
   <PARAM ID="MagSys" arraysize="*" datatype="char" name="MagSys" ucd="meta.code" utype="photdm:PhotCal.MagnitudeSystem.type" value="AB"/>
   <PARAM ID="ZeroPoint" datatype="float" name="ZeroPoint" ucd="phot.flux.density" unit="Jy" utype="photdm:PhotCal.ZeroPoint.Flux.value" value="3631"/>
   <PARAM ID="ZeroPointUnit" arraysize="*" datatype="char" name="ZeroPointUnit" ucd="meta.unit" utype="photdm:PhotCal.ZeroPoint.Flux.unit" value="Jy"/>
   <PARAM ID="ZeroPointType" arraysize="*" datatype="char" name="ZeroPointType" ucd="meta.code" utype="photdm:PhotCal.ZeroPoint.type" value="Pogson"/>
   <DATA>
    <TABLEDATA>
     <TR>
      <TD>5100</TD>
      <TD>0</TD>
     </TR>
     <TR>
      <TD>5120</TD>
      <TD>0.001317729</TD>
     </TR>
     <TR>
      <TD>5160</TD>
      <TD>0.0012103086</TD>
     </TR>
     <TR>
      <TD>5200</TD>
      <TD>0.0011836468</TD>
     </TR>
     <TR>
      <TD>5240</TD>
      <TD>0.0012984587</TD>
     </TR>
     <TR>
      <TD>5280</TD>
      <TD>0.0015719358</TD>
     </TR>
     <TR>
      <TD>5320</TD>
      <TD>0.0021002996</TD>
     </TR>
     <TR>
      <TD>5360</TD>
      <TD>0.0030494311</TD>
     </TR>
     <TR>
      <TD>5400</TD>
      <TD>0.0048685744</TD>
     </TR>
     <TR>
      <TD>5440</TD>
      <TD>0.0087133404</TD>
     </TR>
     <TR>
      <TD>5480</TD>
      <TD>0.017252447</TD>
     </TR>
     <TR>
      <TD>5520</TD>
      <TD>0.035320871</TD>
     </TR>
     <TR>
      <TD>5560</TD>
      <TD>0.069764487</TD>
     </TR>
     <TR>
      <TD>5600</TD>
      <TD>0.12702754</TD>
     </TR>
     <TR>
      <TD>5640</TD>
      <TD>0.20946379</TD>
     </TR>
     <TR>
      <TD>5680</TD>
      <TD>0.30970055</TD>
     </TR>
     <TR>
      <TD>5720</TD>
      <TD>0.40327838</TD>
     </TR>
     <TR>
      <TD>5760</TD>
      <TD>0.4597384</TD>
     </TR>
     <TR>
      <TD>5800</TD>
      <TD>0.47052756</TD>
     </TR>
     <TR>
      <TD>5840</TD>
      <TD>0.45888451</TD>
     </TR>
     <TR>
      <TD>5880</TD>
      <TD>0.45317721</TD>
     </TR>
     <TR>
      <TD>5920</TD>
      <TD>0.4593083</TD>
     </TR>
     <TR>
      <TD>5960</TD>
      <TD>0.46652606</TD>
     </TR>
     <TR>
      <TD>6000</TD>
      <TD>0.47141808</TD>
     </TR>
     <TR>
      <TD>6040</TD>
      <TD>0.48108947</TD>
     </TR>
     <TR>
      <TD>6080</TD>
      <TD>0.49787167</TD>
     </TR>
     <TR>
      <TD>6120</TD>
      <TD>0.51586825</TD>
     </TR>
     <TR>
      <TD>6160</TD>
      <TD>0.52795482</TD>
     </TR>
     <TR>
      <TD>6200</TD>
      <TD>0.53376943</TD>
     </TR>
     <TR>
      <TD>6240</TD>
      <TD>0.53955901</TD>
     </TR>
     <TR>
      <TD>6280</TD>
      <TD>0.54648083</TD>
     </TR>
     <TR>
      <TD>6320</TD>
      <TD>0.55073601</TD>
     </TR>
     <TR>
      <TD>6360</TD>
      <TD>0.55091381</TD>
     </TR>
     <TR>
      <TD>6400</TD>
      <TD>0.54724717</TD>
     </TR>
     <TR>
      <TD>6440</TD>
      <TD>0.53969824</TD>
     </TR>
     <TR>
      <TD>6480</TD>
      <TD>0.5305447</TD>
     </TR>
     <TR>
      <TD>6520</TD>
      <TD>0.51877415</TD>
     </TR>
     <TR>
      <TD>6560</TD>
      <TD>0.49860904</TD>
     </TR>
     <TR>
      <TD>6600</TD>
      <TD>0.46660143</TD>
     </TR>
     <TR>
      <TD>6640</TD>
      <TD>0.42578012</TD>
     </TR>
     <TR>
      <TD>6680</TD>
      <TD>0.38736585</TD>
     </TR>
     <TR>
      <TD>6720</TD>
      <TD>0.36626327</TD>
     </TR>
     <TR>
      <TD>6760</TD>
      <TD>0.37235603</TD>
     </TR>
     <TR>
      <TD>6800</TD>
      <TD>0.40193594</TD>
     </TR>
     <TR>
      <TD>6840</TD>
      <TD>0.3998431</TD>
     </TR>
     <TR>
      <TD>6880</TD>
      <TD>0.29521856</TD>
     </TR>
     <TR>
      <TD>6920</TD>
      <TD>0.14074333</TD>
     </TR>
     <TR>
      <TD>6960</TD>
      <TD>0.044400141</TD>
     </TR>
     <TR>
      <TD>7000</TD>
      <TD>0.012984651</TD>
     </TR>
     <TR>
      <TD>7040</TD>
      <TD>0.0048384005</TD>
     </TR>
     <TR>
      <TD>7080</TD>
      <TD>0.0021152035</TD>
     </TR>
     <TR>
      <TD>7120</TD>
      <TD>0.0010350614</TD>
     </TR>
     <TR>
      <TD>7160</TD>
      <TD>0.0005697122</TD>
     </TR>
     <TR>
      <TD>7200</TD>
      <TD>0.00035055933</TD>
     </TR>
     <TR>
      <TD>7220</TD>
      <TD>0</TD>
     </TR>
    </TABLEDATA>
   </DATA>
  </TABLE>
 </RESOURCE>
</VOTABLE>
