<?xml version="1.0"?>
<VOTABLE version="1.1" xsi:schemaLocation="http://www.ivoa.net/xml/VOTable/v1.1" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">
  <INFO name="QUERY_STATUS" value="OK"/>
  <RESOURCE type="results">
    <TABLE utype="photdm:PhotometryFilter.transmissionCurve.spectrum">
    <PARAM name="FilterProfileService" value="ivo://svo/fps" ucd="meta.ref.ivorn" utype="PhotometryFilter.fpsIdentifier" datatype="char" arraysize="*"/>
    <PARAM name="filterID" value="CFHT/MegaCam.r" ucd="meta.id" utype="photdm:PhotometryFilter.identifier" datatype="char" arraysize="*"/>
    <PARAM name="WavelengthUnit" value="Angstrom" ucd="meta.unit" utype="PhotometryFilter.SpectralAxis.unit" datatype="char" arraysize="*"/>
    <PARAM name="WavelengthUCD" value="em.wl" ucd="meta.ucd" utype="PhotometryFilter.SpectralAxis.UCD" datatype="char" arraysize="*"/>
    <PARAM name="Description" value="MegaCam r  (includes CCD, mirror, optics)" ucd="meta.note" utype="photdm:PhotometryFilter.description" datatype="char" arraysize="*"/>
    <PARAM name="PhotSystem" value="Megaprime" utype="photdm:PhotometricSystem.description" datatype="char" arraysize="*">
       <DESCRIPTION>Photometric system</DESCRIPTION>
    </PARAM>
    <PARAM name="Band" value="r" utype="photdm:PhotometryFilter.bandName" datatype="char" arraysize="*"/>
    <PARAM name="Instrument" value="Megaprime" ucd="instr" datatype="char" arraysize="*">
       <DESCRIPTION>Instrument</DESCRIPTION>
    </PARAM>
    <PARAM name="Facility" value="CFHT" ucd="instr.obsty" datatype="char" arraysize="*">
       <DESCRIPTION>Observational facility</DESCRIPTION>
    </PARAM>
    <PARAM name="ProfileReference" value="http://www2.cadc-ccda.hia-iha.nrc-cnrc.gc.ca/megapipe/docs/filters.html" datatype="char" arraysize="*"/>
    <PARAM name="Description" value="MegaCam r  (includes CCD, mirror, optics)" ucd="meta.note" utype="photdm:PhotometryFilter.description" datatype="char" arraysize="*"/>
    <PARAM name="WavelengthMean" value="6257.9610055805" unit="Angstrom" ucd="em.wl" utype="photdm:PhotometryFilter.SpectralAxis.Coverage.Location.Value" datatype="float" >
       <DESCRIPTION>Mean wavelength. Defined as integ[x*filter(x) dx]/integ[filter(x) dx]</DESCRIPTION>
    </PARAM>
    <PARAM name="WavelengthEff" value="6191.7200415029" unit="Angstrom" ucd="em.wl.effective" datatype="float" >
       <DESCRIPTION>Effective wavelength. Defined as integ[x*filter(x)*vega(x) dx]/integ[filter(x)*vega(x) dx]</DESCRIPTION>
    </PARAM>
    <PARAM name="WavelengthMin" value="5406.6642669887" unit="Angstrom" ucd="em.wl;stat.min" utype="photdm:PhotometryFilter.SpectralAxis.Coverage.Bounds.Start" datatype="float" >
       <DESCRIPTION>Minimum filter wavelength. Defined as the first lambda value with a transmission at least 1% of maximum transmission</DESCRIPTION>
    </PARAM>
    <PARAM name="WavelengthMax" value="7036.7065211981" unit="Angstrom" ucd="em.wl;stat.max" utype="photdm:PhotometryFilter.SpectralAxis.Coverage.Bounds.Stop" datatype="float" >
       <DESCRIPTION>Maximum filter wavelength. Defined as the last lambda value with a transmission at least 1% of maximum transmission</DESCRIPTION>
    </PARAM>
    <PARAM name="WidthEff" value="1099.1020793452" unit="Angstrom" ucd="instr.bandwidth" utype="photdm:PhotometryFilter.SpectralAxis.Coverage.Bounds.Extent" datatype="float" >
       <DESCRIPTION>Effective width. Defined as integ[x*filter(x) dx].\nEquivalent to the horizontal size of a rectangle with height equal to maximum transmission and with the same area that the one covered by the filter transmission curve.</DESCRIPTION>
    </PARAM>
    <PARAM name="WavelengthCen" value="6275.726000817" unit="Angstrom" ucd="em.wl" datatype="float" >
       <DESCRIPTION>Central wavelength. Defined as the central wavelength between the two points defining FWMH</DESCRIPTION>
    </PARAM>
    <PARAM name="WavelengthPivot" value="6247.6459472934" unit="Angstrom" ucd="em.wl" datatype="float" >
       <DESCRIPTION>Peak wavelength. Defined as sqrt{integ[x*filter(x) dx]/integ[filter(x) dx/x]}</DESCRIPTION>
    </PARAM>
    <PARAM name="WavelengthPeak" value="6360" unit="Angstrom" ucd="em.wl" datatype="float" >
       <DESCRIPTION>Peak wavelength. Defined as the lambda value with larger transmission</DESCRIPTION>
    </PARAM>
    <PARAM name="WavelengthPhot" value="6212.3469941575" unit="Angstrom" ucd="em.wl" datatype="float" >
       <DESCRIPTION>Photon distribution based effective wavelength. Defined as integ[x^2*filter(x)*vega(x) dx]/integ[x*filter(x)*vega(x) dx]</DESCRIPTION>
    </PARAM>
    <PARAM name="FWHM" value="1218.7822097066" unit="Angstrom" ucd="instr.bandwidth" datatype="float" >
       <DESCRIPTION>Full width at half maximum. Defined as the difference between the two wavelengths for which filter transmission is half maximum</DESCRIPTION>
    </PARAM>
    <PARAM name="PhotCalID" value="CFHT/MegaCam.r/AB" ucd="meta.id" utype="photdm:PhotCal.identifier" datatype="char" arraysize="*"/>
    <PARAM name="MagSys" value="AB" ucd="meta.code" utype="photdm:PhotCal.MagnitudeSystem.type" datatype="char" arraysize="*"/>
    <PARAM name="ZeroPoint" value="3631" unit="Jy" ucd="phot.flux.density" utype="photdm:PhotCal.ZeroPoint.Flux.value" datatype="float" />
    <PARAM name="ZeroPointUnit" value="Jy" ucd="meta.unit" utype="photdm:PhotCal.ZeroPoint.Flux.unit" datatype="char" arraysize="*"/>
    <PARAM name="ZeroPointType" value="Pogson" ucd="meta.code" utype="photdm:PhotCal.ZeroPoint.type" datatype="char" arraysize="*"/>
      <FIELD name="Wavelength" utype="spec:Data.SpectralAxis.Value" ucd="em.wl" unit="Angstrom" datatype="float"/>
      <FIELD name="Transmission" utype="spec:Data.FluxAxis.Value" ucd="phys.transmission" unit="" datatype="float"/>
      <DATA>
        <TABLEDATA>
          <TR>
            <TD>5100.</TD>
            <TD>0</TD>
          </TR>
          <TR>
            <TD>5120.</TD>
            <TD>0.00131772901</TD>
          </TR>
          <TR>
            <TD>5160.</TD>
            <TD>0.00121030863</TD>
          </TR>
          <TR>
            <TD>5200.</TD>
            <TD>0.00118364685</TD>
          </TR>
          <TR>
            <TD>5240.</TD>
            <TD>0.00129845866</TD>
          </TR>
          <TR>
            <TD>5280.</TD>
            <TD>0.00157193583</TD>
          </TR>
          <TR>
            <TD>5320.</TD>
            <TD>0.00210029958</TD>
          </TR>
          <TR>
            <TD>5360.</TD>
            <TD>0.00304943114</TD>
          </TR>
          <TR>
            <TD>5400.</TD>
            <TD>0.00486857444</TD>
          </TR>
          <TR>
            <TD>5440.</TD>
            <TD>0.00871334039</TD>
          </TR>
          <TR>
            <TD>5480.</TD>
            <TD>0.0172524471</TD>
          </TR>
          <TR>
            <TD>5520.</TD>
            <TD>0.0353208706</TD>
          </TR>
          <TR>
            <TD>5560.</TD>
            <TD>0.0697644874</TD>
          </TR>
          <TR>
            <TD>5600.</TD>
            <TD>0.127027541</TD>
          </TR>
          <TR>
            <TD>5640.</TD>
            <TD>0.20946379</TD>
          </TR>
          <TR>
            <TD>5680.</TD>
            <TD>0.309700549</TD>
          </TR>
          <TR>
            <TD>5720.</TD>
            <TD>0.403278381</TD>
          </TR>
          <TR>
            <TD>5760.</TD>
            <TD>0.459738404</TD>
          </TR>
          <TR>
            <TD>5800.</TD>
            <TD>0.47052756</TD>
          </TR>
          <TR>
            <TD>5840.</TD>
            <TD>0.458884507</TD>
          </TR>
          <TR>
            <TD>5880.</TD>
            <TD>0.453177214</TD>
          </TR>
          <TR>
            <TD>5920.</TD>
            <TD>0.459308296</TD>
          </TR>
          <TR>
            <TD>5960.</TD>
            <TD>0.466526061</TD>
          </TR>
          <TR>
            <TD>6000.</TD>
            <TD>0.471418083</TD>
          </TR>
          <TR>
            <TD>6040.</TD>
            <TD>0.481089473</TD>
          </TR>
          <TR>
            <TD>6080.</TD>
            <TD>0.497871667</TD>
          </TR>
          <TR>
            <TD>6120.</TD>
            <TD>0.515868247</TD>
          </TR>
          <TR>
            <TD>6160.</TD>
            <TD>0.527954817</TD>
          </TR>
          <TR>
            <TD>6200.</TD>
            <TD>0.533769429</TD>
          </TR>
          <TR>
            <TD>6240.</TD>
            <TD>0.539559007</TD>
          </TR>
          <TR>
            <TD>6280.</TD>
            <TD>0.546480834</TD>
          </TR>
          <TR>
            <TD>6320.</TD>
            <TD>0.55073601</TD>
          </TR>
          <TR>
            <TD>6360.</TD>
            <TD>0.550913811</TD>
          </TR>
          <TR>
            <TD>6400.</TD>
            <TD>0.547247171</TD>
          </TR>
          <TR>
            <TD>6440.</TD>
            <TD>0.539698243</TD>
          </TR>
          <TR>
            <TD>6480.</TD>
            <TD>0.530544698</TD>
          </TR>
          <TR>
            <TD>6520.</TD>
            <TD>0.518774152</TD>
          </TR>
          <TR>
            <TD>6560.</TD>
            <TD>0.498609036</TD>
          </TR>
          <TR>
            <TD>6600.</TD>
            <TD>0.466601431</TD>
          </TR>
          <TR>
            <TD>6640.</TD>
            <TD>0.425780118</TD>
          </TR>
          <TR>
            <TD>6680.</TD>
            <TD>0.387365848</TD>
          </TR>
          <TR>
            <TD>6720.</TD>
            <TD>0.36626327</TD>
          </TR>
          <TR>
            <TD>6760.</TD>
            <TD>0.372356027</TD>
          </TR>
          <TR>
            <TD>6800.</TD>
            <TD>0.401935935</TD>
          </TR>
          <TR>
            <TD>6840.</TD>
            <TD>0.399843097</TD>
          </TR>
          <TR>
            <TD>6880.</TD>
            <TD>0.295218557</TD>
          </TR>
          <TR>
            <TD>6920.</TD>
            <TD>0.14074333</TD>
          </TR>
          <TR>
            <TD>6960.</TD>
            <TD>0.0444001406</TD>
          </TR>
          <TR>
            <TD>7000.</TD>
            <TD>0.0129846511</TD>
          </TR>
          <TR>
            <TD>7040.</TD>
            <TD>0.00483840052</TD>
          </TR>
          <TR>
            <TD>7080.</TD>
            <TD>0.00211520353</TD>
          </TR>
          <TR>
            <TD>7120.</TD>
            <TD>0.00103506143</TD>
          </TR>
          <TR>
            <TD>7160.</TD>
            <TD>0.000569712196</TD>
          </TR>
          <TR>
            <TD>7200.</TD>
            <TD>0.000350559334</TD>
          </TR>
          <TR>
            <TD>7220.</TD>
            <TD>0</TD>
          </TR>
        </TABLEDATA>
      </DATA>
    </TABLE>
  </RESOURCE>
</VOTABLE>
