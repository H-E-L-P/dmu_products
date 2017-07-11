<?xml version="1.0"?>
<VOTABLE version="1.1" xsi:schemaLocation="http://www.ivoa.net/xml/VOTable/v1.1" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">
  <INFO name="QUERY_STATUS" value="OK"/>
  <RESOURCE type="results">
    <TABLE utype="photdm:PhotometryFilter.transmissionCurve.spectrum">
    <PARAM name="FilterProfileService" value="ivo://svo/fps" ucd="meta.ref.ivorn" utype="PhotometryFilter.fpsIdentifier" datatype="char" arraysize="*"/>
    <PARAM name="filterID" value="CFHT/MegaCam.u" ucd="meta.id" utype="photdm:PhotometryFilter.identifier" datatype="char" arraysize="*"/>
    <PARAM name="WavelengthUnit" value="Angstrom" ucd="meta.unit" utype="PhotometryFilter.SpectralAxis.unit" datatype="char" arraysize="*"/>
    <PARAM name="WavelengthUCD" value="em.wl" ucd="meta.ucd" utype="PhotometryFilter.SpectralAxis.UCD" datatype="char" arraysize="*"/>
    <PARAM name="Description" value="MegaCam u  (includes CCD, mirror, optics)" ucd="meta.note" utype="photdm:PhotometryFilter.description" datatype="char" arraysize="*"/>
    <PARAM name="PhotSystem" value="Megaprime" utype="photdm:PhotometricSystem.description" datatype="char" arraysize="*">
       <DESCRIPTION>Photometric system</DESCRIPTION>
    </PARAM>
    <PARAM name="Band" value="u" utype="photdm:PhotometryFilter.bandName" datatype="char" arraysize="*"/>
    <PARAM name="Instrument" value="Megaprime" ucd="instr" datatype="char" arraysize="*">
       <DESCRIPTION>Instrument</DESCRIPTION>
    </PARAM>
    <PARAM name="Facility" value="CFHT" ucd="instr.obsty" datatype="char" arraysize="*">
       <DESCRIPTION>Observational facility</DESCRIPTION>
    </PARAM>
    <PARAM name="ProfileReference" value="http://www2.cadc-ccda.hia-iha.nrc-cnrc.gc.ca/megapipe/docs/filters.html" datatype="char" arraysize="*"/>
    <PARAM name="Description" value="MegaCam u  (includes CCD, mirror, optics)" ucd="meta.note" utype="photdm:PhotometryFilter.description" datatype="char" arraysize="*"/>
    <PARAM name="WavelengthMean" value="3811.3145690964" unit="Angstrom" ucd="em.wl" utype="photdm:PhotometryFilter.SpectralAxis.Coverage.Location.Value" datatype="float" >
       <DESCRIPTION>Mean wavelength. Defined as integ[x*filter(x) dx]/integ[filter(x) dx]</DESCRIPTION>
    </PARAM>
    <PARAM name="WavelengthEff" value="3881.5755299418" unit="Angstrom" ucd="em.wl.effective" datatype="float" >
       <DESCRIPTION>Effective wavelength. Defined as integ[x*filter(x)*vega(x) dx]/integ[filter(x)*vega(x) dx]</DESCRIPTION>
    </PARAM>
    <PARAM name="WavelengthMin" value="3265.7996615881" unit="Angstrom" ucd="em.wl;stat.min" utype="photdm:PhotometryFilter.SpectralAxis.Coverage.Bounds.Start" datatype="float" >
       <DESCRIPTION>Minimum filter wavelength. Defined as the first lambda value with a transmission at least 1% of maximum transmission</DESCRIPTION>
    </PARAM>
    <PARAM name="WavelengthMax" value="5169.2286415694" unit="Angstrom" ucd="em.wl;stat.max" utype="photdm:PhotometryFilter.SpectralAxis.Coverage.Bounds.Stop" datatype="float" >
       <DESCRIPTION>Maximum filter wavelength. Defined as the last lambda value with a transmission at least 1% of maximum transmission</DESCRIPTION>
    </PARAM>
    <PARAM name="WidthEff" value="574.78110828839" unit="Angstrom" ucd="instr.bandwidth" utype="photdm:PhotometryFilter.SpectralAxis.Coverage.Bounds.Extent" datatype="float" >
       <DESCRIPTION>Effective width. Defined as integ[x*filter(x) dx].\nEquivalent to the horizontal size of a rectangle with height equal to maximum transmission and with the same area that the one covered by the filter transmission curve.</DESCRIPTION>
    </PARAM>
    <PARAM name="WavelengthCen" value="3792.8113148998" unit="Angstrom" ucd="em.wl" datatype="float" >
       <DESCRIPTION>Central wavelength. Defined as the central wavelength between the two points defining FWMH</DESCRIPTION>
    </PARAM>
    <PARAM name="WavelengthPivot" value="3802.9371116595" unit="Angstrom" ucd="em.wl" datatype="float" >
       <DESCRIPTION>Peak wavelength. Defined as sqrt{integ[x*filter(x) dx]/integ[filter(x) dx/x]}</DESCRIPTION>
    </PARAM>
    <PARAM name="WavelengthPeak" value="4020" unit="Angstrom" ucd="em.wl" datatype="float" >
       <DESCRIPTION>Peak wavelength. Defined as the lambda value with larger transmission</DESCRIPTION>
    </PARAM>
    <PARAM name="WavelengthPhot" value="3895.715449145" unit="Angstrom" ucd="em.wl" datatype="float" >
       <DESCRIPTION>Photon distribution based effective wavelength. Defined as integ[x^2*filter(x)*vega(x) dx]/integ[x*filter(x)*vega(x) dx]</DESCRIPTION>
    </PARAM>
    <PARAM name="FWHM" value="653.73658608555" unit="Angstrom" ucd="instr.bandwidth" datatype="float" >
       <DESCRIPTION>Full width at half maximum. Defined as the difference between the two wavelengths for which filter transmission is half maximum</DESCRIPTION>
    </PARAM>
    <PARAM name="PhotCalID" value="CFHT/MegaCam.u/AB" ucd="meta.id" utype="photdm:PhotCal.identifier" datatype="char" arraysize="*"/>
    <PARAM name="MagSys" value="AB" ucd="meta.code" utype="photdm:PhotCal.MagnitudeSystem.type" datatype="char" arraysize="*"/>
    <PARAM name="ZeroPoint" value="3631" unit="Jy" ucd="phot.flux.density" utype="photdm:PhotCal.ZeroPoint.Flux.value" datatype="float" />
    <PARAM name="ZeroPointUnit" value="Jy" ucd="meta.unit" utype="photdm:PhotCal.ZeroPoint.Flux.unit" datatype="char" arraysize="*"/>
    <PARAM name="ZeroPointType" value="Pogson" ucd="meta.code" utype="photdm:PhotCal.ZeroPoint.type" datatype="char" arraysize="*"/>
      <FIELD name="Wavelength" utype="spec:Data.SpectralAxis.Value" ucd="em.wl" unit="Angstrom" datatype="float"/>
      <FIELD name="Transmission" utype="spec:Data.FluxAxis.Value" ucd="phys.transmission" unit="" datatype="float"/>
      <DATA>
        <TABLEDATA>
          <TR>
            <TD>3000.</TD>
            <TD>0</TD>
          </TR>
          <TR>
            <TD>3180.</TD>
            <TD>0.000119374185</TD>
          </TR>
          <TR>
            <TD>3220.</TD>
            <TD>0.000555103819</TD>
          </TR>
          <TR>
            <TD>3260.</TD>
            <TD>0.00224317308</TD>
          </TR>
          <TR>
            <TD>3300.</TD>
            <TD>0.0160973426</TD>
          </TR>
          <TR>
            <TD>3340.</TD>
            <TD>0.0648551956</TD>
          </TR>
          <TR>
            <TD>3380.</TD>
            <TD>0.135956392</TD>
          </TR>
          <TR>
            <TD>3420.</TD>
            <TD>0.179929361</TD>
          </TR>
          <TR>
            <TD>3460.</TD>
            <TD>0.207123712</TD>
          </TR>
          <TR>
            <TD>3500.</TD>
            <TD>0.243952185</TD>
          </TR>
          <TR>
            <TD>3540.</TD>
            <TD>0.270075917</TD>
          </TR>
          <TR>
            <TD>3580.</TD>
            <TD>0.277276397</TD>
          </TR>
          <TR>
            <TD>3620.</TD>
            <TD>0.283456177</TD>
          </TR>
          <TR>
            <TD>3660.</TD>
            <TD>0.295061022</TD>
          </TR>
          <TR>
            <TD>3700.</TD>
            <TD>0.279397458</TD>
          </TR>
          <TR>
            <TD>3740.</TD>
            <TD>0.261833906</TD>
          </TR>
          <TR>
            <TD>3780.</TD>
            <TD>0.281388253</TD>
          </TR>
          <TR>
            <TD>3820.</TD>
            <TD>0.336556375</TD>
          </TR>
          <TR>
            <TD>3860.</TD>
            <TD>0.383069575</TD>
          </TR>
          <TR>
            <TD>3900.</TD>
            <TD>0.387663811</TD>
          </TR>
          <TR>
            <TD>3940.</TD>
            <TD>0.39384523</TD>
          </TR>
          <TR>
            <TD>3980.</TD>
            <TD>0.41868186</TD>
          </TR>
          <TR>
            <TD>4020.</TD>
            <TD>0.425191045</TD>
          </TR>
          <TR>
            <TD>4060.</TD>
            <TD>0.388191819</TD>
          </TR>
          <TR>
            <TD>4100.</TD>
            <TD>0.28170982</TD>
          </TR>
          <TR>
            <TD>4140.</TD>
            <TD>0.141230807</TD>
          </TR>
          <TR>
            <TD>4180.</TD>
            <TD>0.0499474704</TD>
          </TR>
          <TR>
            <TD>4220.</TD>
            <TD>0.0168965608</TD>
          </TR>
          <TR>
            <TD>4260.</TD>
            <TD>0.00676131854</TD>
          </TR>
          <TR>
            <TD>4300.</TD>
            <TD>0.00325661013</TD>
          </TR>
          <TR>
            <TD>4340.</TD>
            <TD>0.00188939588</TD>
          </TR>
          <TR>
            <TD>4380.</TD>
            <TD>0.00127769657</TD>
          </TR>
          <TR>
            <TD>4420.</TD>
            <TD>0.000963628117</TD>
          </TR>
          <TR>
            <TD>4460.</TD>
            <TD>0.000788327889</TD>
          </TR>
          <TR>
            <TD>4500.</TD>
            <TD>0.000688685104</TD>
          </TR>
          <TR>
            <TD>4540.</TD>
            <TD>0.00060211838</TD>
          </TR>
          <TR>
            <TD>4580.</TD>
            <TD>0.000534449122</TD>
          </TR>
          <TR>
            <TD>4620.</TD>
            <TD>0.000506343669</TD>
          </TR>
          <TR>
            <TD>4660.</TD>
            <TD>0.000528468285</TD>
          </TR>
          <TR>
            <TD>4700.</TD>
            <TD>0.000581911125</TD>
          </TR>
          <TR>
            <TD>4740.</TD>
            <TD>0.000696175033</TD>
          </TR>
          <TR>
            <TD>4780.</TD>
            <TD>0.000872161414</TD>
          </TR>
          <TR>
            <TD>4820.</TD>
            <TD>0.00115230726</TD>
          </TR>
          <TR>
            <TD>4860.</TD>
            <TD>0.00171151944</TD>
          </TR>
          <TR>
            <TD>4900.</TD>
            <TD>0.00274659414</TD>
          </TR>
          <TR>
            <TD>4940.</TD>
            <TD>0.00481579918</TD>
          </TR>
          <TR>
            <TD>4980.</TD>
            <TD>0.00796410535</TD>
          </TR>
          <TR>
            <TD>5020.</TD>
            <TD>0.0100412732</TD>
          </TR>
          <TR>
            <TD>5060.</TD>
            <TD>0.0094757285</TD>
          </TR>
          <TR>
            <TD>5100.</TD>
            <TD>0.0076275412</TD>
          </TR>
          <TR>
            <TD>5140.</TD>
            <TD>0.00568695087</TD>
          </TR>
          <TR>
            <TD>5180.</TD>
            <TD>0.0037230684</TD>
          </TR>
          <TR>
            <TD>5220.</TD>
            <TD>0.00208977424</TD>
          </TR>
          <TR>
            <TD>5260.</TD>
            <TD>0.00127485732</TD>
          </TR>
          <TR>
            <TD>5300.</TD>
            <TD>0.00130769971</TD>
          </TR>
          <TR>
            <TD>5340.</TD>
            <TD>0.0016671276</TD>
          </TR>
          <TR>
            <TD>5380.</TD>
            <TD>0.00176649203</TD>
          </TR>
          <TR>
            <TD>5420.</TD>
            <TD>0.00150029722</TD>
          </TR>
          <TR>
            <TD>5460.</TD>
            <TD>0.0012288026</TD>
          </TR>
          <TR>
            <TD>5500.</TD>
            <TD>0.00133760099</TD>
          </TR>
          <TR>
            <TD>5540.</TD>
            <TD>0</TD>
          </TR>
        </TABLEDATA>
      </DATA>
    </TABLE>
  </RESOURCE>
</VOTABLE>
