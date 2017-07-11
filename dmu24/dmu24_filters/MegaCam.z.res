<?xml version="1.0"?>
<VOTABLE version="1.1" xsi:schemaLocation="http://www.ivoa.net/xml/VOTable/v1.1" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">
  <INFO name="QUERY_STATUS" value="OK"/>
  <RESOURCE type="results">
    <TABLE utype="photdm:PhotometryFilter.transmissionCurve.spectrum">
    <PARAM name="FilterProfileService" value="ivo://svo/fps" ucd="meta.ref.ivorn" utype="PhotometryFilter.fpsIdentifier" datatype="char" arraysize="*"/>
    <PARAM name="filterID" value="CFHT/MegaCam.z" ucd="meta.id" utype="photdm:PhotometryFilter.identifier" datatype="char" arraysize="*"/>
    <PARAM name="WavelengthUnit" value="Angstrom" ucd="meta.unit" utype="PhotometryFilter.SpectralAxis.unit" datatype="char" arraysize="*"/>
    <PARAM name="WavelengthUCD" value="em.wl" ucd="meta.ucd" utype="PhotometryFilter.SpectralAxis.UCD" datatype="char" arraysize="*"/>
    <PARAM name="Description" value="MegaCam z  (includes CCD, mirror, optics)" ucd="meta.note" utype="photdm:PhotometryFilter.description" datatype="char" arraysize="*"/>
    <PARAM name="PhotSystem" value="Megaprime" utype="photdm:PhotometricSystem.description" datatype="char" arraysize="*">
       <DESCRIPTION>Photometric system</DESCRIPTION>
    </PARAM>
    <PARAM name="Band" value="z" utype="photdm:PhotometryFilter.bandName" datatype="char" arraysize="*"/>
    <PARAM name="Instrument" value="Megaprime" ucd="instr" datatype="char" arraysize="*">
       <DESCRIPTION>Instrument</DESCRIPTION>
    </PARAM>
    <PARAM name="Facility" value="CFHT" ucd="instr.obsty" datatype="char" arraysize="*">
       <DESCRIPTION>Observational facility</DESCRIPTION>
    </PARAM>
    <PARAM name="ProfileReference" value="http://www2.cadc-ccda.hia-iha.nrc-cnrc.gc.ca/megapipe/docs/filters.html" datatype="char" arraysize="*"/>
    <PARAM name="Description" value="MegaCam z  (includes CCD, mirror, optics)" ucd="meta.note" utype="photdm:PhotometryFilter.description" datatype="char" arraysize="*"/>
    <PARAM name="WavelengthMean" value="8871.2621304736" unit="Angstrom" ucd="em.wl" utype="photdm:PhotometryFilter.SpectralAxis.Coverage.Location.Value" datatype="float" >
       <DESCRIPTION>Mean wavelength. Defined as integ[x*filter(x) dx]/integ[filter(x) dx]</DESCRIPTION>
    </PARAM>
    <PARAM name="WavelengthEff" value="8823.9560297655" unit="Angstrom" ucd="em.wl.effective" datatype="float" >
       <DESCRIPTION>Effective wavelength. Defined as integ[x*filter(x)*vega(x) dx]/integ[filter(x)*vega(x) dx]</DESCRIPTION>
    </PARAM>
    <PARAM name="WavelengthMin" value="8009.1635305891" unit="Angstrom" ucd="em.wl;stat.min" utype="photdm:PhotometryFilter.SpectralAxis.Coverage.Bounds.Start" datatype="float" >
       <DESCRIPTION>Minimum filter wavelength. Defined as the first lambda value with a transmission at least 1% of maximum transmission</DESCRIPTION>
    </PARAM>
    <PARAM name="WavelengthMax" value="10225.865445799" unit="Angstrom" ucd="em.wl;stat.max" utype="photdm:PhotometryFilter.SpectralAxis.Coverage.Bounds.Stop" datatype="float" >
       <DESCRIPTION>Maximum filter wavelength. Defined as the last lambda value with a transmission at least 1% of maximum transmission</DESCRIPTION>
    </PARAM>
    <PARAM name="WidthEff" value="998.38717381059" unit="Angstrom" ucd="instr.bandwidth" utype="photdm:PhotometryFilter.SpectralAxis.Coverage.Bounds.Extent" datatype="float" >
       <DESCRIPTION>Effective width. Defined as integ[x*filter(x) dx].\nEquivalent to the horizontal size of a rectangle with height equal to maximum transmission and with the same area that the one covered by the filter transmission curve.</DESCRIPTION>
    </PARAM>
    <PARAM name="WavelengthCen" value="8728.1553176671" unit="Angstrom" ucd="em.wl" datatype="float" >
       <DESCRIPTION>Central wavelength. Defined as the central wavelength between the two points defining FWMH</DESCRIPTION>
    </PARAM>
    <PARAM name="WavelengthPivot" value="8859.9290802557" unit="Angstrom" ucd="em.wl" datatype="float" >
       <DESCRIPTION>Peak wavelength. Defined as sqrt{integ[x*filter(x) dx]/integ[filter(x) dx/x]}</DESCRIPTION>
    </PARAM>
    <PARAM name="WavelengthPeak" value="8400" unit="Angstrom" ucd="em.wl" datatype="float" >
       <DESCRIPTION>Peak wavelength. Defined as the lambda value with larger transmission</DESCRIPTION>
    </PARAM>
    <PARAM name="WavelengthPhot" value="8845.7021134256" unit="Angstrom" ucd="em.wl" datatype="float" >
       <DESCRIPTION>Photon distribution based effective wavelength. Defined as integ[x^2*filter(x)*vega(x) dx]/integ[x*filter(x)*vega(x) dx]</DESCRIPTION>
    </PARAM>
    <PARAM name="FWHM" value="935.52073324707" unit="Angstrom" ucd="instr.bandwidth" datatype="float" >
       <DESCRIPTION>Full width at half maximum. Defined as the difference between the two wavelengths for which filter transmission is half maximum</DESCRIPTION>
    </PARAM>
    <PARAM name="PhotCalID" value="CFHT/MegaCam.z/AB" ucd="meta.id" utype="photdm:PhotCal.identifier" datatype="char" arraysize="*"/>
    <PARAM name="MagSys" value="AB" ucd="meta.code" utype="photdm:PhotCal.MagnitudeSystem.type" datatype="char" arraysize="*"/>
    <PARAM name="ZeroPoint" value="3631" unit="Jy" ucd="phot.flux.density" utype="photdm:PhotCal.ZeroPoint.Flux.value" datatype="float" />
    <PARAM name="ZeroPointUnit" value="Jy" ucd="meta.unit" utype="photdm:PhotCal.ZeroPoint.Flux.unit" datatype="char" arraysize="*"/>
    <PARAM name="ZeroPointType" value="Pogson" ucd="meta.code" utype="photdm:PhotCal.ZeroPoint.type" datatype="char" arraysize="*"/>
      <FIELD name="Wavelength" utype="spec:Data.SpectralAxis.Value" ucd="em.wl" unit="Angstrom" datatype="float"/>
      <FIELD name="Transmission" utype="spec:Data.FluxAxis.Value" ucd="phys.transmission" unit="" datatype="float"/>
      <DATA>
        <TABLEDATA>
          <TR>
            <TD>7780.</TD>
            <TD>0</TD>
          </TR>
          <TR>
            <TD>7800.</TD>
            <TD>0.000298154482</TD>
          </TR>
          <TR>
            <TD>7840.</TD>
            <TD>0.000421382632</TD>
          </TR>
          <TR>
            <TD>7880.</TD>
            <TD>0.000617844751</TD>
          </TR>
          <TR>
            <TD>7920.</TD>
            <TD>0.00092385977</TD>
          </TR>
          <TR>
            <TD>7960.</TD>
            <TD>0.00145464682</TD>
          </TR>
          <TR>
            <TD>8000.</TD>
            <TD>0.00238681608</TD>
          </TR>
          <TR>
            <TD>8040.</TD>
            <TD>0.00405334588</TD>
          </TR>
          <TR>
            <TD>8080.</TD>
            <TD>0.00732962461</TD>
          </TR>
          <TR>
            <TD>8120.</TD>
            <TD>0.0139800701</TD>
          </TR>
          <TR>
            <TD>8160.</TD>
            <TD>0.027856743</TD>
          </TR>
          <TR>
            <TD>8200.</TD>
            <TD>0.0554090403</TD>
          </TR>
          <TR>
            <TD>8240.</TD>
            <TD>0.104835406</TD>
          </TR>
          <TR>
            <TD>8280.</TD>
            <TD>0.170723319</TD>
          </TR>
          <TR>
            <TD>8320.</TD>
            <TD>0.228108868</TD>
          </TR>
          <TR>
            <TD>8360.</TD>
            <TD>0.263207048</TD>
          </TR>
          <TR>
            <TD>8400.</TD>
            <TD>0.27685985</TD>
          </TR>
          <TR>
            <TD>8440.</TD>
            <TD>0.275680244</TD>
          </TR>
          <TR>
            <TD>8480.</TD>
            <TD>0.270607293</TD>
          </TR>
          <TR>
            <TD>8520.</TD>
            <TD>0.26625064</TD>
          </TR>
          <TR>
            <TD>8560.</TD>
            <TD>0.260749757</TD>
          </TR>
          <TR>
            <TD>8600.</TD>
            <TD>0.254382074</TD>
          </TR>
          <TR>
            <TD>8640.</TD>
            <TD>0.24816823</TD>
          </TR>
          <TR>
            <TD>8680.</TD>
            <TD>0.241476133</TD>
          </TR>
          <TR>
            <TD>8720.</TD>
            <TD>0.232566237</TD>
          </TR>
          <TR>
            <TD>8760.</TD>
            <TD>0.222295702</TD>
          </TR>
          <TR>
            <TD>8800.</TD>
            <TD>0.213475764</TD>
          </TR>
          <TR>
            <TD>8840.</TD>
            <TD>0.205972061</TD>
          </TR>
          <TR>
            <TD>8880.</TD>
            <TD>0.198679447</TD>
          </TR>
          <TR>
            <TD>8920.</TD>
            <TD>0.191328526</TD>
          </TR>
          <TR>
            <TD>8960.</TD>
            <TD>0.184844181</TD>
          </TR>
          <TR>
            <TD>9000.</TD>
            <TD>0.178206459</TD>
          </TR>
          <TR>
            <TD>9040.</TD>
            <TD>0.170237139</TD>
          </TR>
          <TR>
            <TD>9080.</TD>
            <TD>0.162276417</TD>
          </TR>
          <TR>
            <TD>9120.</TD>
            <TD>0.154366419</TD>
          </TR>
          <TR>
            <TD>9160.</TD>
            <TD>0.145774528</TD>
          </TR>
          <TR>
            <TD>9200.</TD>
            <TD>0.1375947</TD>
          </TR>
          <TR>
            <TD>9240.</TD>
            <TD>0.129395068</TD>
          </TR>
          <TR>
            <TD>9280.</TD>
            <TD>0.121231318</TD>
          </TR>
          <TR>
            <TD>9320.</TD>
            <TD>0.113395788</TD>
          </TR>
          <TR>
            <TD>9360.</TD>
            <TD>0.10594935</TD>
          </TR>
          <TR>
            <TD>9400.</TD>
            <TD>0.0990467966</TD>
          </TR>
          <TR>
            <TD>9440.</TD>
            <TD>0.0919484496</TD>
          </TR>
          <TR>
            <TD>9480.</TD>
            <TD>0.0850069225</TD>
          </TR>
          <TR>
            <TD>9520.</TD>
            <TD>0.0798064619</TD>
          </TR>
          <TR>
            <TD>9560.</TD>
            <TD>0.0759239644</TD>
          </TR>
          <TR>
            <TD>9600.</TD>
            <TD>0.0719882026</TD>
          </TR>
          <TR>
            <TD>9640.</TD>
            <TD>0.0680272728</TD>
          </TR>
          <TR>
            <TD>9680.</TD>
            <TD>0.0638097227</TD>
          </TR>
          <TR>
            <TD>9720.</TD>
            <TD>0.0594895855</TD>
          </TR>
          <TR>
            <TD>9760.</TD>
            <TD>0.0550764836</TD>
          </TR>
          <TR>
            <TD>9800.</TD>
            <TD>0.0506376214</TD>
          </TR>
          <TR>
            <TD>9840.</TD>
            <TD>0.046213109</TD>
          </TR>
          <TR>
            <TD>9880.</TD>
            <TD>0.0417242795</TD>
          </TR>
          <TR>
            <TD>9920.</TD>
            <TD>0.037232168</TD>
          </TR>
          <TR>
            <TD>9960.</TD>
            <TD>0.0328233689</TD>
          </TR>
          <TR>
            <TD>10000.</TD>
            <TD>0.0284879077</TD>
          </TR>
          <TR>
            <TD>10040.</TD>
            <TD>0.0242324527</TD>
          </TR>
          <TR>
            <TD>10080.</TD>
            <TD>0.0200234875</TD>
          </TR>
          <TR>
            <TD>10120.</TD>
            <TD>0.0158770978</TD>
          </TR>
          <TR>
            <TD>10160.</TD>
            <TD>0.0118273003</TD>
          </TR>
          <TR>
            <TD>10200.</TD>
            <TD>0.00783497933</TD>
          </TR>
          <TR>
            <TD>10240.</TD>
            <TD>0.</TD>
          </TR>
        </TABLEDATA>
      </DATA>
    </TABLE>
  </RESOURCE>
</VOTABLE>
