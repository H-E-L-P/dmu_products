<?xml version="1.0"?>
<VOTABLE version="1.1" xsi:schemaLocation="http://www.ivoa.net/xml/VOTable/v1.1" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">
  <INFO name="QUERY_STATUS" value="OK"/>
  <RESOURCE type="results">
    <TABLE utype="photdm:PhotometryFilter.transmissionCurve.spectrum">
    <PARAM name="FilterProfileService" value="ivo://svo/fps" ucd="meta.ref.ivorn" utype="PhotometryFilter.fpsIdentifier" datatype="char" arraysize="*"/>
    <PARAM name="filterID" value="CFHT/MegaCam.g" ucd="meta.id" utype="photdm:PhotometryFilter.identifier" datatype="char" arraysize="*"/>
    <PARAM name="WavelengthUnit" value="Angstrom" ucd="meta.unit" utype="PhotometryFilter.SpectralAxis.unit" datatype="char" arraysize="*"/>
    <PARAM name="WavelengthUCD" value="em.wl" ucd="meta.ucd" utype="PhotometryFilter.SpectralAxis.UCD" datatype="char" arraysize="*"/>
    <PARAM name="Description" value="MegaCam g  (includes CCD, mirror, optics)" ucd="meta.note" utype="photdm:PhotometryFilter.description" datatype="char" arraysize="*"/>
    <PARAM name="PhotSystem" value="Megaprime" utype="photdm:PhotometricSystem.description" datatype="char" arraysize="*">
       <DESCRIPTION>Photometric system</DESCRIPTION>
    </PARAM>
    <PARAM name="Band" value="g" utype="photdm:PhotometryFilter.bandName" datatype="char" arraysize="*"/>
    <PARAM name="Instrument" value="Megaprime" ucd="instr" datatype="char" arraysize="*">
       <DESCRIPTION>Instrument</DESCRIPTION>
    </PARAM>
    <PARAM name="Facility" value="CFHT" ucd="instr.obsty" datatype="char" arraysize="*">
       <DESCRIPTION>Observational facility</DESCRIPTION>
    </PARAM>
    <PARAM name="ProfileReference" value="http://www2.cadc-ccda.hia-iha.nrc-cnrc.gc.ca/megapipe/docs/filters.html" datatype="char" arraysize="*"/>
    <PARAM name="Description" value="MegaCam g  (includes CCD, mirror, optics)" ucd="meta.note" utype="photdm:PhotometryFilter.description" datatype="char" arraysize="*"/>
    <PARAM name="WavelengthMean" value="4862.4971878688" unit="Angstrom" ucd="em.wl" utype="photdm:PhotometryFilter.SpectralAxis.Coverage.Location.Value" datatype="float" >
       <DESCRIPTION>Mean wavelength. Defined as integ[x*filter(x) dx]/integ[filter(x) dx]</DESCRIPTION>
    </PARAM>
    <PARAM name="WavelengthEff" value="4766.9931751047" unit="Angstrom" ucd="em.wl.effective" datatype="float" >
       <DESCRIPTION>Effective wavelength. Defined as integ[x*filter(x)*vega(x) dx]/integ[filter(x)*vega(x) dx]</DESCRIPTION>
    </PARAM>
    <PARAM name="WavelengthMin" value="3973.4638624774" unit="Angstrom" ucd="em.wl;stat.min" utype="photdm:PhotometryFilter.SpectralAxis.Coverage.Bounds.Start" datatype="float" >
       <DESCRIPTION>Minimum filter wavelength. Defined as the first lambda value with a transmission at least 1% of maximum transmission</DESCRIPTION>
    </PARAM>
    <PARAM name="WavelengthMax" value="5794.9534791595" unit="Angstrom" ucd="em.wl;stat.max" utype="photdm:PhotometryFilter.SpectralAxis.Coverage.Bounds.Stop" datatype="float" >
       <DESCRIPTION>Maximum filter wavelength. Defined as the last lambda value with a transmission at least 1% of maximum transmission</DESCRIPTION>
    </PARAM>
    <PARAM name="WidthEff" value="1322.4368776241" unit="Angstrom" ucd="instr.bandwidth" utype="photdm:PhotometryFilter.SpectralAxis.Coverage.Bounds.Extent" datatype="float" >
       <DESCRIPTION>Effective width. Defined as integ[x*filter(x) dx].\nEquivalent to the horizontal size of a rectangle with height equal to maximum transmission and with the same area that the one covered by the filter transmission curve.</DESCRIPTION>
    </PARAM>
    <PARAM name="WavelengthCen" value="4871.8048332753" unit="Angstrom" ucd="em.wl" datatype="float" >
       <DESCRIPTION>Central wavelength. Defined as the central wavelength between the two points defining FWMH</DESCRIPTION>
    </PARAM>
    <PARAM name="WavelengthPivot" value="4844.4286479918" unit="Angstrom" ucd="em.wl" datatype="float" >
       <DESCRIPTION>Peak wavelength. Defined as sqrt{integ[x*filter(x) dx]/integ[filter(x) dx/x]}</DESCRIPTION>
    </PARAM>
    <PARAM name="WavelengthPeak" value="4860" unit="Angstrom" ucd="em.wl" datatype="float" >
       <DESCRIPTION>Peak wavelength. Defined as the lambda value with larger transmission</DESCRIPTION>
    </PARAM>
    <PARAM name="WavelengthPhot" value="4802.3539081916" unit="Angstrom" ucd="em.wl" datatype="float" >
       <DESCRIPTION>Photon distribution based effective wavelength. Defined as integ[x^2*filter(x)*vega(x) dx]/integ[x*filter(x)*vega(x) dx]</DESCRIPTION>
    </PARAM>
    <PARAM name="FWHM" value="1433.7647413282" unit="Angstrom" ucd="instr.bandwidth" datatype="float" >
       <DESCRIPTION>Full width at half maximum. Defined as the difference between the two wavelengths for which filter transmission is half maximum</DESCRIPTION>
    </PARAM>
    <PARAM name="PhotCalID" value="CFHT/MegaCam.g/AB" ucd="meta.id" utype="photdm:PhotCal.identifier" datatype="char" arraysize="*"/>
    <PARAM name="MagSys" value="AB" ucd="meta.code" utype="photdm:PhotCal.MagnitudeSystem.type" datatype="char" arraysize="*"/>
    <PARAM name="ZeroPoint" value="3631" unit="Jy" ucd="phot.flux.density" utype="photdm:PhotCal.ZeroPoint.Flux.value" datatype="float" />
    <PARAM name="ZeroPointUnit" value="Jy" ucd="meta.unit" utype="photdm:PhotCal.ZeroPoint.Flux.unit" datatype="char" arraysize="*"/>
    <PARAM name="ZeroPointType" value="Pogson" ucd="meta.code" utype="photdm:PhotCal.ZeroPoint.type" datatype="char" arraysize="*"/>
      <FIELD name="Wavelength" utype="spec:Data.SpectralAxis.Value" ucd="em.wl" unit="Angstrom" datatype="float"/>
      <FIELD name="Transmission" utype="spec:Data.FluxAxis.Value" ucd="phys.transmission" unit="" datatype="float"/>
      <DATA>
        <TABLEDATA>
          <TR>
            <TD>3720.</TD>
            <TD>0</TD>
          </TR>
          <TR>
            <TD>3740.</TD>
            <TD>0.000355355616</TD>
          </TR>
          <TR>
            <TD>3780.</TD>
            <TD>0.000829957076</TD>
          </TR>
          <TR>
            <TD>3820.</TD>
            <TD>0.00141607679</TD>
          </TR>
          <TR>
            <TD>3860.</TD>
            <TD>0.00209650188</TD>
          </TR>
          <TR>
            <TD>3900.</TD>
            <TD>0.00304011698</TD>
          </TR>
          <TR>
            <TD>3940.</TD>
            <TD>0.00443226611</TD>
          </TR>
          <TR>
            <TD>3980.</TD>
            <TD>0.00670775538</TD>
          </TR>
          <TR>
            <TD>4020.</TD>
            <TD>0.0120516121</TD>
          </TR>
          <TR>
            <TD>4060.</TD>
            <TD>0.0313223414</TD>
          </TR>
          <TR>
            <TD>4100.</TD>
            <TD>0.0998138189</TD>
          </TR>
          <TR>
            <TD>4140.</TD>
            <TD>0.251622856</TD>
          </TR>
          <TR>
            <TD>4180.</TD>
            <TD>0.426322639</TD>
          </TR>
          <TR>
            <TD>4220.</TD>
            <TD>0.517378092</TD>
          </TR>
          <TR>
            <TD>4260.</TD>
            <TD>0.536827981</TD>
          </TR>
          <TR>
            <TD>4300.</TD>
            <TD>0.551809371</TD>
          </TR>
          <TR>
            <TD>4340.</TD>
            <TD>0.56177789</TD>
          </TR>
          <TR>
            <TD>4380.</TD>
            <TD>0.563030303</TD>
          </TR>
          <TR>
            <TD>4420.</TD>
            <TD>0.574669302</TD>
          </TR>
          <TR>
            <TD>4460.</TD>
            <TD>0.58998692</TD>
          </TR>
          <TR>
            <TD>4500.</TD>
            <TD>0.597056627</TD>
          </TR>
          <TR>
            <TD>4540.</TD>
            <TD>0.600475073</TD>
          </TR>
          <TR>
            <TD>4580.</TD>
            <TD>0.614054918</TD>
          </TR>
          <TR>
            <TD>4620.</TD>
            <TD>0.624335706</TD>
          </TR>
          <TR>
            <TD>4660.</TD>
            <TD>0.621033549</TD>
          </TR>
          <TR>
            <TD>4700.</TD>
            <TD>0.612812638</TD>
          </TR>
          <TR>
            <TD>4740.</TD>
            <TD>0.613680303</TD>
          </TR>
          <TR>
            <TD>4780.</TD>
            <TD>0.624298096</TD>
          </TR>
          <TR>
            <TD>4820.</TD>
            <TD>0.633061051</TD>
          </TR>
          <TR>
            <TD>4860.</TD>
            <TD>0.633593261</TD>
          </TR>
          <TR>
            <TD>4900.</TD>
            <TD>0.631872296</TD>
          </TR>
          <TR>
            <TD>4940.</TD>
            <TD>0.627049387</TD>
          </TR>
          <TR>
            <TD>4980.</TD>
            <TD>0.60651809</TD>
          </TR>
          <TR>
            <TD>5020.</TD>
            <TD>0.582745194</TD>
          </TR>
          <TR>
            <TD>5060.</TD>
            <TD>0.574268222</TD>
          </TR>
          <TR>
            <TD>5100.</TD>
            <TD>0.566061497</TD>
          </TR>
          <TR>
            <TD>5140.</TD>
            <TD>0.549057305</TD>
          </TR>
          <TR>
            <TD>5180.</TD>
            <TD>0.536121905</TD>
          </TR>
          <TR>
            <TD>5220.</TD>
            <TD>0.539279461</TD>
          </TR>
          <TR>
            <TD>5260.</TD>
            <TD>0.552175045</TD>
          </TR>
          <TR>
            <TD>5300.</TD>
            <TD>0.547873139</TD>
          </TR>
          <TR>
            <TD>5340.</TD>
            <TD>0.531880736</TD>
          </TR>
          <TR>
            <TD>5380.</TD>
            <TD>0.531952739</TD>
          </TR>
          <TR>
            <TD>5420.</TD>
            <TD>0.526999474</TD>
          </TR>
          <TR>
            <TD>5460.</TD>
            <TD>0.484875411</TD>
          </TR>
          <TR>
            <TD>5500.</TD>
            <TD>0.428083152</TD>
          </TR>
          <TR>
            <TD>5540.</TD>
            <TD>0.387431502</TD>
          </TR>
          <TR>
            <TD>5580.</TD>
            <TD>0.335921437</TD>
          </TR>
          <TR>
            <TD>5620.</TD>
            <TD>0.247861773</TD>
          </TR>
          <TR>
            <TD>5660.</TD>
            <TD>0.144387901</TD>
          </TR>
          <TR>
            <TD>5700.</TD>
            <TD>0.0655752793</TD>
          </TR>
          <TR>
            <TD>5740.</TD>
            <TD>0.0247591734</TD>
          </TR>
          <TR>
            <TD>5780.</TD>
            <TD>0.00843042694</TD>
          </TR>
          <TR>
            <TD>5820.</TD>
            <TD>0.00282773259</TD>
          </TR>
          <TR>
            <TD>5860.</TD>
            <TD>0.00106635387</TD>
          </TR>
          <TR>
            <TD>5900.</TD>
            <TD>0.000631565985</TD>
          </TR>
          <TR>
            <TD>5940.</TD>
            <TD>0.000583282614</TD>
          </TR>
          <TR>
            <TD>5980.</TD>
            <TD>0.000525950512</TD>
          </TR>
          <TR>
            <TD>6020.</TD>
            <TD>0.000360883336</TD>
          </TR>
          <TR>
            <TD>6060.</TD>
            <TD>0.000161975724</TD>
          </TR>
          <TR>
            <TD>6100.</TD>
            <TD>0</TD>
          </TR>
        </TABLEDATA>
      </DATA>
    </TABLE>
  </RESOURCE>
</VOTABLE>
