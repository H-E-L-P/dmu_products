<?xml version="1.0" encoding="utf-8"?>
<!-- Produced with astropy.io.votable version 1.3.3
     http://www.astropy.org/ -->
<VOTABLE version="1.1" xmlns="http://www.ivoa.net/xml/VOTable/v1.1" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:noNamespaceSchemaLocation="http://www.ivoa.net/xml/VOTable/v1.1">
 <PARAM ID="ForegroundExtinction" arraysize="*" datatype="float" name="ForegroundExtinction" unit="" value="1.841">
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
  <TABLE nrows="65" utype="photdm:PhotometryFilter.transmissionCurve.spectrum">
   <FIELD ID="Wavelength" datatype="float" name="Wavelength" ucd="em.wl" unit="AA" utype="spec:Data.SpectralAxis.Value"/>
   <FIELD ID="Transmission" datatype="float" name="Transmission" ucd="phys.transmission" utype="spec:Data.FluxAxis.Value"/>
   <PARAM ID="FilterProfileService" arraysize="*" datatype="char" name="FilterProfileService" ucd="meta.ref.ivorn" utype="PhotometryFilter.fpsIdentifier" value="ivo://svo/fps"/>
   <PARAM ID="filterID" arraysize="*" datatype="char" name="filterID" ucd="meta.id" utype="photdm:PhotometryFilter.identifier" value="CFHT/MegaCam.i_0"/>
   <PARAM ID="WavelengthUnit" arraysize="*" datatype="char" name="WavelengthUnit" ucd="meta.unit" utype="PhotometryFilter.SpectralAxis.unit" value="Angstrom"/>
   <PARAM ID="WavelengthUCD" arraysize="*" datatype="char" name="WavelengthUCD" ucd="meta.ucd" utype="PhotometryFilter.SpectralAxis.UCD" value="em.wl"/>
   <PARAM ID="Description" arraysize="*" datatype="char" name="Description" ucd="meta.note" utype="photdm:PhotometryFilter.description" value="MegaCam i (includes CCD, mirror, optics)  valid before  June  2007"/>
   <PARAM ID="PhotSystem" arraysize="*" datatype="char" name="PhotSystem" utype="photdm:PhotometricSystem.description" value="Megaprime">
    <DESCRIPTION>
     Photometric system
    </DESCRIPTION>
   </PARAM>
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
   <PARAM ID="Description" arraysize="*" datatype="char" name="Description" ucd="meta.note" utype="photdm:PhotometryFilter.description" value="MegaCam i (includes CCD, mirror, optics)  valid before  June  2007"/>
   <PARAM ID="WavelengthMean" datatype="float" name="WavelengthMean" ucd="em.wl" unit="AA" utype="photdm:PhotometryFilter.SpectralAxis.Coverage.Location.Value" value="7690.4849059018">
    <DESCRIPTION>
     Mean wavelength. Defined as integ[x*filter(x) dx]/integ[filter(x)
     dx]
    </DESCRIPTION>
   </PARAM>
   <PARAM ID="WavelengthEff" datatype="float" name="WavelengthEff" ucd="em.wl.effective" unit="AA" value="7613.6812429222">
    <DESCRIPTION>
     Effective wavelength. Defined as integ[x*filter(x)*vega(x)
     dx]/integ[filter(x)*vega(x) dx]
    </DESCRIPTION>
   </PARAM>
   <PARAM ID="WavelengthMin" datatype="float" name="WavelengthMin" ucd="em.wl;stat.min" unit="AA" utype="photdm:PhotometryFilter.SpectralAxis.Coverage.Bounds.Start" value="6742.2542951532">
    <DESCRIPTION>
     Minimum filter wavelength. Defined as the first lambda value with
     a transmission at least 1% of maximum transmission
    </DESCRIPTION>
   </PARAM>
   <PARAM ID="WavelengthMax" datatype="float" name="WavelengthMax" ucd="em.wl;stat.max" unit="AA" utype="photdm:PhotometryFilter.SpectralAxis.Coverage.Bounds.Stop" value="8774.0984537252">
    <DESCRIPTION>
     Maximum filter wavelength. Defined as the last lambda value with
     a transmission at least 1% of maximum transmission
    </DESCRIPTION>
   </PARAM>
   <PARAM ID="WidthEff" datatype="float" name="WidthEff" ucd="instr.bandwidth" unit="AA" utype="photdm:PhotometryFilter.SpectralAxis.Coverage.Bounds.Extent" value="1220.8316678313">
    <DESCRIPTION>
     Effective width. Defined as integ[x*filter(x) dx].\nEquivalent to
     the horizontal size of a rectangle with height equal to maximum
     transmission and with the same area that the one covered by the
     filter transmission curve.
    </DESCRIPTION>
   </PARAM>
   <PARAM ID="WavelengthCen" datatype="float" name="WavelengthCen" ucd="em.wl" unit="AA" value="7704.1251350225">
    <DESCRIPTION>
     Central wavelength. Defined as the central wavelength between the
     two points defining FWMH
    </DESCRIPTION>
   </PARAM>
   <PARAM ID="WavelengthPivot" datatype="float" name="WavelengthPivot" ucd="em.wl" unit="AA" value="7678.1065343478">
    <DESCRIPTION>
     Peak wavelength. Defined as sqrt{integ[x*filter(x)
     dx]/integ[filter(x) dx/x]}
    </DESCRIPTION>
   </PARAM>
   <PARAM ID="WavelengthPeak" datatype="float" name="WavelengthPeak" ucd="em.wl" unit="AA" value="7200">
    <DESCRIPTION>
     Peak wavelength. Defined as the lambda value with larger
     transmission
    </DESCRIPTION>
   </PARAM>
   <PARAM ID="WavelengthPhot" datatype="float" name="WavelengthPhot" ucd="em.wl" unit="AA" value="7637.6482942879">
    <DESCRIPTION>
     Photon distribution based effective wavelength. Defined as
     integ[x^2*filter(x)*vega(x) dx]/integ[x*filter(x)*vega(x) dx]
    </DESCRIPTION>
   </PARAM>
   <PARAM ID="FWHM" datatype="float" name="FWHM" ucd="instr.bandwidth" unit="AA" value="1366.5980936628">
    <DESCRIPTION>
     Full width at half maximum. Defined as the difference between the
     two wavelengths for which filter transmission is half maximum
    </DESCRIPTION>
   </PARAM>
   <PARAM ID="PhotCalID" arraysize="*" datatype="char" name="PhotCalID" ucd="meta.id" utype="photdm:PhotCal.identifier" value="CFHT/MegaCam.i_0/AB"/>
   <PARAM ID="MagSys" arraysize="*" datatype="char" name="MagSys" ucd="meta.code" utype="photdm:PhotCal.MagnitudeSystem.type" value="AB"/>
   <PARAM ID="ZeroPoint" datatype="float" name="ZeroPoint" ucd="phot.flux.density" unit="Jy" utype="photdm:PhotCal.ZeroPoint.Flux.value" value="3631"/>
   <PARAM ID="ZeroPointUnit" arraysize="*" datatype="char" name="ZeroPointUnit" ucd="meta.unit" utype="photdm:PhotCal.ZeroPoint.Flux.unit" value="Jy"/>
   <PARAM ID="ZeroPointType" arraysize="*" datatype="char" name="ZeroPointType" ucd="meta.code" utype="photdm:PhotCal.ZeroPoint.type" value="Pogson"/>
   <DATA>
    <TABLEDATA>
     <TR>
      <TD>6580</TD>
      <TD>0</TD>
     </TR>
     <TR>
      <TD>6600</TD>
      <TD>0.0008598814</TD>
     </TR>
     <TR>
      <TD>6640</TD>
      <TD>0.0013460289</TD>
     </TR>
     <TR>
      <TD>6680</TD>
      <TD>0.0021375711</TD>
     </TR>
     <TR>
      <TD>6720</TD>
      <TD>0.0034779944</TD>
     </TR>
     <TR>
      <TD>6760</TD>
      <TD>0.0058738617</TD>
     </TR>
     <TR>
      <TD>6800</TD>
      <TD>0.01019999</TD>
     </TR>
     <TR>
      <TD>6840</TD>
      <TD>0.018210407</TD>
     </TR>
     <TR>
      <TD>6880</TD>
      <TD>0.033502329</TD>
     </TR>
     <TR>
      <TD>6920</TD>
      <TD>0.062256973</TD>
     </TR>
     <TR>
      <TD>6960</TD>
      <TD>0.11294354</TD>
     </TR>
     <TR>
      <TD>7000</TD>
      <TD>0.19056422</TD>
     </TR>
     <TR>
      <TD>7040</TD>
      <TD>0.28656578</TD>
     </TR>
     <TR>
      <TD>7080</TD>
      <TD>0.37939695</TD>
     </TR>
     <TR>
      <TD>7120</TD>
      <TD>0.4447346</TD>
     </TR>
     <TR>
      <TD>7160</TD>
      <TD>0.47479382</TD>
     </TR>
     <TR>
      <TD>7200</TD>
      <TD>0.48109528</TD>
     </TR>
     <TR>
      <TD>7240</TD>
      <TD>0.4764989</TD>
     </TR>
     <TR>
      <TD>7280</TD>
      <TD>0.46891987</TD>
     </TR>
     <TR>
      <TD>7320</TD>
      <TD>0.46203002</TD>
     </TR>
     <TR>
      <TD>7360</TD>
      <TD>0.45681342</TD>
     </TR>
     <TR>
      <TD>7400</TD>
      <TD>0.45223889</TD>
     </TR>
     <TR>
      <TD>7440</TD>
      <TD>0.44750109</TD>
     </TR>
     <TR>
      <TD>7480</TD>
      <TD>0.44220835</TD>
     </TR>
     <TR>
      <TD>7520</TD>
      <TD>0.43490517</TD>
     </TR>
     <TR>
      <TD>7560</TD>
      <TD>0.42614713</TD>
     </TR>
     <TR>
      <TD>7600</TD>
      <TD>0.41666034</TD>
     </TR>
     <TR>
      <TD>7640</TD>
      <TD>0.40837967</TD>
     </TR>
     <TR>
      <TD>7680</TD>
      <TD>0.40098107</TD>
     </TR>
     <TR>
      <TD>7720</TD>
      <TD>0.39538398</TD>
     </TR>
     <TR>
      <TD>7760</TD>
      <TD>0.39163163</TD>
     </TR>
     <TR>
      <TD>7800</TD>
      <TD>0.38874131</TD>
     </TR>
     <TR>
      <TD>7840</TD>
      <TD>0.38576719</TD>
     </TR>
     <TR>
      <TD>7880</TD>
      <TD>0.38135803</TD>
     </TR>
     <TR>
      <TD>7920</TD>
      <TD>0.37471074</TD>
     </TR>
     <TR>
      <TD>7960</TD>
      <TD>0.36606404</TD>
     </TR>
     <TR>
      <TD>8000</TD>
      <TD>0.35581687</TD>
     </TR>
     <TR>
      <TD>8040</TD>
      <TD>0.34748691</TD>
     </TR>
     <TR>
      <TD>8080</TD>
      <TD>0.34040123</TD>
     </TR>
     <TR>
      <TD>8120</TD>
      <TD>0.33470532</TD>
     </TR>
     <TR>
      <TD>8160</TD>
      <TD>0.32899299</TD>
     </TR>
     <TR>
      <TD>8200</TD>
      <TD>0.32028055</TD>
     </TR>
     <TR>
      <TD>8240</TD>
      <TD>0.30722228</TD>
     </TR>
     <TR>
      <TD>8280</TD>
      <TD>0.28819138</TD>
     </TR>
     <TR>
      <TD>8320</TD>
      <TD>0.26775637</TD>
     </TR>
     <TR>
      <TD>8360</TD>
      <TD>0.25181362</TD>
     </TR>
     <TR>
      <TD>8400</TD>
      <TD>0.23538144</TD>
     </TR>
     <TR>
      <TD>8440</TD>
      <TD>0.21647094</TD>
     </TR>
     <TR>
      <TD>8480</TD>
      <TD>0.19179507</TD>
     </TR>
     <TR>
      <TD>8520</TD>
      <TD>0.15407732</TD>
     </TR>
     <TR>
      <TD>8560</TD>
      <TD>0.10949147</TD>
     </TR>
     <TR>
      <TD>8600</TD>
      <TD>0.068066821</TD>
     </TR>
     <TR>
      <TD>8640</TD>
      <TD>0.037398104</TD>
     </TR>
     <TR>
      <TD>8680</TD>
      <TD>0.018336294</TD>
     </TR>
     <TR>
      <TD>8720</TD>
      <TD>0.0091818161</TD>
     </TR>
     <TR>
      <TD>8760</TD>
      <TD>0.0056501566</TD>
     </TR>
     <TR>
      <TD>8800</TD>
      <TD>0.0032691755</TD>
     </TR>
     <TR>
      <TD>8840</TD>
      <TD>0.0020556655</TD>
     </TR>
     <TR>
      <TD>8880</TD>
      <TD>0.00094187976</TD>
     </TR>
     <TR>
      <TD>8920</TD>
      <TD>0.00077976583</TD>
     </TR>
     <TR>
      <TD>8960</TD>
      <TD>0.00085716962</TD>
     </TR>
     <TR>
      <TD>9000</TD>
      <TD>0.00083486538</TD>
     </TR>
     <TR>
      <TD>9040</TD>
      <TD>0.00085350103</TD>
     </TR>
     <TR>
      <TD>9080</TD>
      <TD>0.00065611274</TD>
     </TR>
     <TR>
      <TD>9120</TD>
      <TD>0</TD>
     </TR>
    </TABLEDATA>
   </DATA>
  </TABLE>
 </RESOURCE>
</VOTABLE>
