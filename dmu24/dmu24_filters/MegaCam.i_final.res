<?xml version="1.0" encoding="utf-8"?>
<!-- Produced with astropy.io.votable version 1.3.3
     http://www.astropy.org/ -->
<VOTABLE version="1.1" xmlns="http://www.ivoa.net/xml/VOTable/v1.1" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:noNamespaceSchemaLocation="http://www.ivoa.net/xml/VOTable/v1.1">
 <PARAM ID="ForegroundExtinction" arraysize="*" datatype="float" name="ForegroundExtinction" unit="" value="1.8979999999999999">
  <DESCRIPTION>
        Wavelength dependent extinction factor assuming Fitzpatrick
   1999 MW extinction curve and a flat input spectrum.      Magnitudes
   should be foreground corrected according to:           M_int,i =
   M_obs,i - E(B-V)*Ai          where M_int,i and M_obs,i are the
   intrinsic and observed magnitudes in the filter, i, and Ai is the
   filter specific extinction value (A/E(B-V)).
  </DESCRIPTION>
 </PARAM>
 <INFO ID="QUERY_STATUS" name="QUERY_STATUS" value="OK"/>
 <RESOURCE type="results">
  <TABLE nrows="38" utype="photdm:PhotometryFilter.transmissionCurve.spectrum">
   <FIELD ID="Wavelength" datatype="float" name="Wavelength" ucd="em.wl" unit="AA" utype="spec:Data.SpectralAxis.Value"/>
   <FIELD ID="Transmission" datatype="float" name="Transmission" ucd="phys.transmission" utype="spec:Data.FluxAxis.Value"/>
   <PARAM ID="FilterProfileService" arraysize="*" datatype="char" name="FilterProfileService" ucd="meta.ref.ivorn" utype="PhotometryFilter.fpsIdentifier" value="ivo://svo/fps"/>
   <PARAM ID="filterID" arraysize="*" datatype="char" name="filterID" ucd="meta.id" utype="photdm:PhotometryFilter.identifier" value="CFHT/MegaCam.i"/>
   <PARAM ID="WavelengthUnit" arraysize="*" datatype="char" name="WavelengthUnit" ucd="meta.unit" utype="PhotometryFilter.SpectralAxis.unit" value="Angstrom"/>
   <PARAM ID="WavelengthUCD" arraysize="*" datatype="char" name="WavelengthUCD" ucd="meta.ucd" utype="PhotometryFilter.SpectralAxis.UCD" value="em.wl"/>
   <PARAM ID="Description" arraysize="*" datatype="char" name="Description" ucd="meta.note" utype="photdm:PhotometryFilter.description" value="MegaCam i (includes CCD, mirror, optics)  valid after after October 2007"/>
   <PARAM ID="PhotSystem" arraysize="*" datatype="char" name="PhotSystem" utype="photdm:PhotometricSystem.description" value="Megaprime">
    <DESCRIPTION>
     Photometric system
    </DESCRIPTION>
   </PARAM>
   <PARAM ID="Band" arraysize="*" datatype="char" name="Band" utype="photdm:PhotometryFilter.bandName" value="i"/>
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
   <PARAM ID="Description" arraysize="*" datatype="char" name="Description" ucd="meta.note" utype="photdm:PhotometryFilter.description" value="MegaCam i (includes CCD, mirror, optics)  valid after after October 2007"/>
   <PARAM ID="WavelengthMean" datatype="float" name="WavelengthMean" ucd="em.wl" unit="AA" utype="photdm:PhotometryFilter.SpectralAxis.Coverage.Location.Value" value="7552.4411307877">
    <DESCRIPTION>
     Mean wavelength. Defined as integ[x*filter(x) dx]/integ[filter(x)
     dx]
    </DESCRIPTION>
   </PARAM>
   <PARAM ID="WavelengthEff" datatype="float" name="WavelengthEff" ucd="em.wl.effective" unit="AA" value="7467.3585141177">
    <DESCRIPTION>
     Effective wavelength. Defined as integ[x*filter(x)*vega(x)
     dx]/integ[filter(x)*vega(x) dx]
    </DESCRIPTION>
   </PARAM>
   <PARAM ID="WavelengthMin" datatype="float" name="WavelengthMin" ucd="em.wl;stat.min" unit="AA" utype="photdm:PhotometryFilter.SpectralAxis.Coverage.Bounds.Start" value="6696.3290285735">
    <DESCRIPTION>
     Minimum filter wavelength. Defined as the first lambda value with
     a transmission at least 1% of maximum transmission
    </DESCRIPTION>
   </PARAM>
   <PARAM ID="WavelengthMax" datatype="float" name="WavelengthMax" ucd="em.wl;stat.max" unit="AA" utype="photdm:PhotometryFilter.SpectralAxis.Coverage.Bounds.Stop" value="8593.528573525">
    <DESCRIPTION>
     Maximum filter wavelength. Defined as the last lambda value with
     a transmission at least 1% of maximum transmission
    </DESCRIPTION>
   </PARAM>
   <PARAM ID="WidthEff" datatype="float" name="WidthEff" ucd="instr.bandwidth" unit="AA" utype="photdm:PhotometryFilter.SpectralAxis.Coverage.Bounds.Extent" value="1316.139729283">
    <DESCRIPTION>
     Effective width. Defined as integ[x*filter(x) dx].\nEquivalent to
     the horizontal size of a rectangle with height equal to maximum
     transmission and with the same area that the one covered by the
     filter transmission curve.
    </DESCRIPTION>
   </PARAM>
   <PARAM ID="WavelengthCen" datatype="float" name="WavelengthCen" ucd="em.wl" unit="AA" value="7614.9469144089">
    <DESCRIPTION>
     Central wavelength. Defined as the central wavelength between the
     two points defining FWMH
    </DESCRIPTION>
   </PARAM>
   <PARAM ID="WavelengthPivot" datatype="float" name="WavelengthPivot" ucd="em.wl" unit="AA" value="7538.4276849391">
    <DESCRIPTION>
     Peak wavelength. Defined as sqrt{integ[x*filter(x)
     dx]/integ[filter(x) dx/x]}
    </DESCRIPTION>
   </PARAM>
   <PARAM ID="WavelengthPeak" datatype="float" name="WavelengthPeak" ucd="em.wl" unit="AA" value="6933.40039">
    <DESCRIPTION>
     Peak wavelength. Defined as the lambda value with larger
     transmission
    </DESCRIPTION>
   </PARAM>
   <PARAM ID="WavelengthPhot" datatype="float" name="WavelengthPhot" ucd="em.wl" unit="AA" value="7494.1778188756">
    <DESCRIPTION>
     Photon distribution based effective wavelength. Defined as
     integ[x^2*filter(x)*vega(x) dx]/integ[x*filter(x)*vega(x) dx]
    </DESCRIPTION>
   </PARAM>
   <PARAM ID="FWHM" datatype="float" name="FWHM" ucd="instr.bandwidth" unit="AA" value="1570.9432235895">
    <DESCRIPTION>
     Full width at half maximum. Defined as the difference between the
     two wavelengths for which filter transmission is half maximum
    </DESCRIPTION>
   </PARAM>
   <PARAM ID="PhotCalID" arraysize="*" datatype="char" name="PhotCalID" ucd="meta.id" utype="photdm:PhotCal.identifier" value="CFHT/MegaCam.i/AB"/>
   <PARAM ID="MagSys" arraysize="*" datatype="char" name="MagSys" ucd="meta.code" utype="photdm:PhotCal.MagnitudeSystem.type" value="AB"/>
   <PARAM ID="ZeroPoint" datatype="float" name="ZeroPoint" ucd="phot.flux.density" unit="Jy" utype="photdm:PhotCal.ZeroPoint.Flux.value" value="3631"/>
   <PARAM ID="ZeroPointUnit" arraysize="*" datatype="char" name="ZeroPointUnit" ucd="meta.unit" utype="photdm:PhotCal.ZeroPoint.Flux.unit" value="Jy"/>
   <PARAM ID="ZeroPointType" arraysize="*" datatype="char" name="ZeroPointType" ucd="meta.code" utype="photdm:PhotCal.ZeroPoint.type" value="Pogson"/>
   <DATA>
    <TABLEDATA>
     <TR>
      <TD>6685.5791</TD>
      <TD>0</TD>
     </TR>
     <TR>
      <TD>6733.2373</TD>
      <TD>0.021895254</TD>
     </TR>
     <TR>
      <TD>6765.0093</TD>
      <TD>0.054707881</TD>
     </TR>
     <TR>
      <TD>6787.2495</TD>
      <TD>0.089786232</TD>
     </TR>
     <TR>
      <TD>6803.1357</TD>
      <TD>0.13207337</TD>
     </TR>
     <TR>
      <TD>6815.8442</TD>
      <TD>0.19967395</TD>
     </TR>
     <TR>
      <TD>6831.7305</TD>
      <TD>0.25475752</TD>
     </TR>
     <TR>
      <TD>6844.439</TD>
      <TD>0.29887429</TD>
     </TR>
     <TR>
      <TD>6847.6162</TD>
      <TD>0.3674117</TD>
     </TR>
     <TR>
      <TD>6866.6792</TD>
      <TD>0.40606239</TD>
     </TR>
     <TR>
      <TD>6907.9829</TD>
      <TD>0.47776446</TD>
     </TR>
     <TR>
      <TD>6933.4004</TD>
      <TD>0.49387601</TD>
     </TR>
     <TR>
      <TD>7050.9565</TD>
      <TD>0.49102134</TD>
     </TR>
     <TR>
      <TD>7200.2847</TD>
      <TD>0.47445458</TD>
     </TR>
     <TR>
      <TD>7324.1953</TD>
      <TD>0.461236</TD>
     </TR>
     <TR>
      <TD>7432.2197</TD>
      <TD>0.44344744</TD>
     </TR>
     <TR>
      <TD>7521.1812</TD>
      <TD>0.42427596</TD>
     </TR>
     <TR>
      <TD>7622.8516</TD>
      <TD>0.41287747</TD>
     </TR>
     <TR>
      <TD>7708.6357</TD>
      <TD>0.39199394</TD>
     </TR>
     <TR>
      <TD>7769.0024</TD>
      <TD>0.38044825</TD>
     </TR>
     <TR>
      <TD>7819.8374</TD>
      <TD>0.37008274</TD>
     </TR>
     <TR>
      <TD>7905.6216</TD>
      <TD>0.3566542</TD>
     </TR>
     <TR>
      <TD>7988.229</TD>
      <TD>0.34513289</TD>
     </TR>
     <TR>
      <TD>8064.4814</TD>
      <TD>0.33302355</TD>
     </TR>
     <TR>
      <TD>8131.2026</TD>
      <TD>0.32093957</TD>
     </TR>
     <TR>
      <TD>8185.2148</TD>
      <TD>0.30834275</TD>
     </TR>
     <TR>
      <TD>8264.6445</TD>
      <TD>0.29454881</TD>
     </TR>
     <TR>
      <TD>8350.4287</TD>
      <TD>0.27208689</TD>
     </TR>
     <TR>
      <TD>8388.5557</TD>
      <TD>0.26330522</TD>
     </TR>
     <TR>
      <TD>8401.2637</TD>
      <TD>0.24577196</TD>
     </TR>
     <TR>
      <TD>8423.5039</TD>
      <TD>0.20552045</TD>
     </TR>
     <TR>
      <TD>8433.0361</TD>
      <TD>0.17473701</TD>
     </TR>
     <TR>
      <TD>8455.2764</TD>
      <TD>0.12925221</TD>
     </TR>
     <TR>
      <TD>8471.1621</TD>
      <TD>0.081192635</TD>
     </TR>
     <TR>
      <TD>8490.2256</TD>
      <TD>0.043709613</TD>
     </TR>
     <TR>
      <TD>8537.8828</TD>
      <TD>0.013866081</TD>
     </TR>
     <TR>
      <TD>8598.25</TD>
      <TD>0.0041812956</TD>
     </TR>
     <TR>
      <TD>8712.6289</TD>
      <TD>0</TD>
     </TR>
    </TABLEDATA>
   </DATA>
  </TABLE>
 </RESOURCE>
</VOTABLE>
