<?xml version="1.0" encoding="utf-8"?>
<!-- Produced with astropy.io.votable version 1.3.3
     http://www.astropy.org/ -->
<VOTABLE version="1.1" xmlns="http://www.ivoa.net/xml/VOTable/v1.1" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:noNamespaceSchemaLocation="http://www.ivoa.net/xml/VOTable/v1.1">
 <PARAM ID="ForegroundExtinction" arraysize="*" datatype="float" name="ForegroundExtinction" unit="" value="3.6190000000000002">
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
  <TABLE nrows="61" utype="photdm:PhotometryFilter.transmissionCurve.spectrum">
   <FIELD ID="Wavelength" datatype="float" name="Wavelength" ucd="em.wl" unit="AA" utype="spec:Data.SpectralAxis.Value"/>
   <FIELD ID="Transmission" datatype="float" name="Transmission" ucd="phys.transmission" utype="spec:Data.FluxAxis.Value"/>
   <PARAM ID="FilterProfileService" arraysize="*" datatype="char" name="FilterProfileService" ucd="meta.ref.ivorn" utype="PhotometryFilter.fpsIdentifier" value="ivo://svo/fps"/>
   <PARAM ID="filterID" arraysize="*" datatype="char" name="filterID" ucd="meta.id" utype="photdm:PhotometryFilter.identifier" value="CFHT/MegaCam.g"/>
   <PARAM ID="WavelengthUnit" arraysize="*" datatype="char" name="WavelengthUnit" ucd="meta.unit" utype="PhotometryFilter.SpectralAxis.unit" value="Angstrom"/>
   <PARAM ID="WavelengthUCD" arraysize="*" datatype="char" name="WavelengthUCD" ucd="meta.ucd" utype="PhotometryFilter.SpectralAxis.UCD" value="em.wl"/>
   <PARAM ID="Description" arraysize="*" datatype="char" name="Description" ucd="meta.note" utype="photdm:PhotometryFilter.description" value="MegaCam g  (includes CCD, mirror, optics)"/>
   <PARAM ID="PhotSystem" arraysize="*" datatype="char" name="PhotSystem" utype="photdm:PhotometricSystem.description" value="Megaprime">
    <DESCRIPTION>
     Photometric system
    </DESCRIPTION>
   </PARAM>
   <PARAM ID="Band" arraysize="*" datatype="char" name="Band" utype="photdm:PhotometryFilter.bandName" value="g"/>
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
   <PARAM ID="Description" arraysize="*" datatype="char" name="Description" ucd="meta.note" utype="photdm:PhotometryFilter.description" value="MegaCam g  (includes CCD, mirror, optics)"/>
   <PARAM ID="WavelengthMean" datatype="float" name="WavelengthMean" ucd="em.wl" unit="AA" utype="photdm:PhotometryFilter.SpectralAxis.Coverage.Location.Value" value="4862.4971878688">
    <DESCRIPTION>
     Mean wavelength. Defined as integ[x*filter(x) dx]/integ[filter(x)
     dx]
    </DESCRIPTION>
   </PARAM>
   <PARAM ID="WavelengthEff" datatype="float" name="WavelengthEff" ucd="em.wl.effective" unit="AA" value="4766.9931751047">
    <DESCRIPTION>
     Effective wavelength. Defined as integ[x*filter(x)*vega(x)
     dx]/integ[filter(x)*vega(x) dx]
    </DESCRIPTION>
   </PARAM>
   <PARAM ID="WavelengthMin" datatype="float" name="WavelengthMin" ucd="em.wl;stat.min" unit="AA" utype="photdm:PhotometryFilter.SpectralAxis.Coverage.Bounds.Start" value="3973.4638624774">
    <DESCRIPTION>
     Minimum filter wavelength. Defined as the first lambda value with
     a transmission at least 1% of maximum transmission
    </DESCRIPTION>
   </PARAM>
   <PARAM ID="WavelengthMax" datatype="float" name="WavelengthMax" ucd="em.wl;stat.max" unit="AA" utype="photdm:PhotometryFilter.SpectralAxis.Coverage.Bounds.Stop" value="5794.9534791595">
    <DESCRIPTION>
     Maximum filter wavelength. Defined as the last lambda value with
     a transmission at least 1% of maximum transmission
    </DESCRIPTION>
   </PARAM>
   <PARAM ID="WidthEff" datatype="float" name="WidthEff" ucd="instr.bandwidth" unit="AA" utype="photdm:PhotometryFilter.SpectralAxis.Coverage.Bounds.Extent" value="1322.4368776241">
    <DESCRIPTION>
     Effective width. Defined as integ[x*filter(x) dx].\nEquivalent to
     the horizontal size of a rectangle with height equal to maximum
     transmission and with the same area that the one covered by the
     filter transmission curve.
    </DESCRIPTION>
   </PARAM>
   <PARAM ID="WavelengthCen" datatype="float" name="WavelengthCen" ucd="em.wl" unit="AA" value="4871.8048332753">
    <DESCRIPTION>
     Central wavelength. Defined as the central wavelength between the
     two points defining FWMH
    </DESCRIPTION>
   </PARAM>
   <PARAM ID="WavelengthPivot" datatype="float" name="WavelengthPivot" ucd="em.wl" unit="AA" value="4844.4286479918">
    <DESCRIPTION>
     Peak wavelength. Defined as sqrt{integ[x*filter(x)
     dx]/integ[filter(x) dx/x]}
    </DESCRIPTION>
   </PARAM>
   <PARAM ID="WavelengthPeak" datatype="float" name="WavelengthPeak" ucd="em.wl" unit="AA" value="4860">
    <DESCRIPTION>
     Peak wavelength. Defined as the lambda value with larger
     transmission
    </DESCRIPTION>
   </PARAM>
   <PARAM ID="WavelengthPhot" datatype="float" name="WavelengthPhot" ucd="em.wl" unit="AA" value="4802.3539081916">
    <DESCRIPTION>
     Photon distribution based effective wavelength. Defined as
     integ[x^2*filter(x)*vega(x) dx]/integ[x*filter(x)*vega(x) dx]
    </DESCRIPTION>
   </PARAM>
   <PARAM ID="FWHM" datatype="float" name="FWHM" ucd="instr.bandwidth" unit="AA" value="1433.7647413282">
    <DESCRIPTION>
     Full width at half maximum. Defined as the difference between the
     two wavelengths for which filter transmission is half maximum
    </DESCRIPTION>
   </PARAM>
   <PARAM ID="PhotCalID" arraysize="*" datatype="char" name="PhotCalID" ucd="meta.id" utype="photdm:PhotCal.identifier" value="CFHT/MegaCam.g/AB"/>
   <PARAM ID="MagSys" arraysize="*" datatype="char" name="MagSys" ucd="meta.code" utype="photdm:PhotCal.MagnitudeSystem.type" value="AB"/>
   <PARAM ID="ZeroPoint" datatype="float" name="ZeroPoint" ucd="phot.flux.density" unit="Jy" utype="photdm:PhotCal.ZeroPoint.Flux.value" value="3631"/>
   <PARAM ID="ZeroPointUnit" arraysize="*" datatype="char" name="ZeroPointUnit" ucd="meta.unit" utype="photdm:PhotCal.ZeroPoint.Flux.unit" value="Jy"/>
   <PARAM ID="ZeroPointType" arraysize="*" datatype="char" name="ZeroPointType" ucd="meta.code" utype="photdm:PhotCal.ZeroPoint.type" value="Pogson"/>
   <DATA>
    <TABLEDATA>
     <TR>
      <TD>3720</TD>
      <TD>0</TD>
     </TR>
     <TR>
      <TD>3740</TD>
      <TD>0.00035535562</TD>
     </TR>
     <TR>
      <TD>3780</TD>
      <TD>0.00082995708</TD>
     </TR>
     <TR>
      <TD>3820</TD>
      <TD>0.0014160768</TD>
     </TR>
     <TR>
      <TD>3860</TD>
      <TD>0.0020965019</TD>
     </TR>
     <TR>
      <TD>3900</TD>
      <TD>0.003040117</TD>
     </TR>
     <TR>
      <TD>3940</TD>
      <TD>0.0044322661</TD>
     </TR>
     <TR>
      <TD>3980</TD>
      <TD>0.0067077554</TD>
     </TR>
     <TR>
      <TD>4020</TD>
      <TD>0.012051612</TD>
     </TR>
     <TR>
      <TD>4060</TD>
      <TD>0.031322341</TD>
     </TR>
     <TR>
      <TD>4100</TD>
      <TD>0.099813819</TD>
     </TR>
     <TR>
      <TD>4140</TD>
      <TD>0.25162286</TD>
     </TR>
     <TR>
      <TD>4180</TD>
      <TD>0.42632264</TD>
     </TR>
     <TR>
      <TD>4220</TD>
      <TD>0.51737809</TD>
     </TR>
     <TR>
      <TD>4260</TD>
      <TD>0.53682798</TD>
     </TR>
     <TR>
      <TD>4300</TD>
      <TD>0.55180937</TD>
     </TR>
     <TR>
      <TD>4340</TD>
      <TD>0.56177789</TD>
     </TR>
     <TR>
      <TD>4380</TD>
      <TD>0.5630303</TD>
     </TR>
     <TR>
      <TD>4420</TD>
      <TD>0.5746693</TD>
     </TR>
     <TR>
      <TD>4460</TD>
      <TD>0.58998692</TD>
     </TR>
     <TR>
      <TD>4500</TD>
      <TD>0.59705663</TD>
     </TR>
     <TR>
      <TD>4540</TD>
      <TD>0.60047507</TD>
     </TR>
     <TR>
      <TD>4580</TD>
      <TD>0.61405492</TD>
     </TR>
     <TR>
      <TD>4620</TD>
      <TD>0.62433571</TD>
     </TR>
     <TR>
      <TD>4660</TD>
      <TD>0.62103355</TD>
     </TR>
     <TR>
      <TD>4700</TD>
      <TD>0.61281264</TD>
     </TR>
     <TR>
      <TD>4740</TD>
      <TD>0.6136803</TD>
     </TR>
     <TR>
      <TD>4780</TD>
      <TD>0.6242981</TD>
     </TR>
     <TR>
      <TD>4820</TD>
      <TD>0.63306105</TD>
     </TR>
     <TR>
      <TD>4860</TD>
      <TD>0.63359326</TD>
     </TR>
     <TR>
      <TD>4900</TD>
      <TD>0.6318723</TD>
     </TR>
     <TR>
      <TD>4940</TD>
      <TD>0.62704939</TD>
     </TR>
     <TR>
      <TD>4980</TD>
      <TD>0.60651809</TD>
     </TR>
     <TR>
      <TD>5020</TD>
      <TD>0.58274519</TD>
     </TR>
     <TR>
      <TD>5060</TD>
      <TD>0.57426822</TD>
     </TR>
     <TR>
      <TD>5100</TD>
      <TD>0.5660615</TD>
     </TR>
     <TR>
      <TD>5140</TD>
      <TD>0.5490573</TD>
     </TR>
     <TR>
      <TD>5180</TD>
      <TD>0.5361219</TD>
     </TR>
     <TR>
      <TD>5220</TD>
      <TD>0.53927946</TD>
     </TR>
     <TR>
      <TD>5260</TD>
      <TD>0.55217505</TD>
     </TR>
     <TR>
      <TD>5300</TD>
      <TD>0.54787314</TD>
     </TR>
     <TR>
      <TD>5340</TD>
      <TD>0.53188074</TD>
     </TR>
     <TR>
      <TD>5380</TD>
      <TD>0.53195274</TD>
     </TR>
     <TR>
      <TD>5420</TD>
      <TD>0.52699947</TD>
     </TR>
     <TR>
      <TD>5460</TD>
      <TD>0.48487541</TD>
     </TR>
     <TR>
      <TD>5500</TD>
      <TD>0.42808315</TD>
     </TR>
     <TR>
      <TD>5540</TD>
      <TD>0.3874315</TD>
     </TR>
     <TR>
      <TD>5580</TD>
      <TD>0.33592144</TD>
     </TR>
     <TR>
      <TD>5620</TD>
      <TD>0.24786177</TD>
     </TR>
     <TR>
      <TD>5660</TD>
      <TD>0.1443879</TD>
     </TR>
     <TR>
      <TD>5700</TD>
      <TD>0.065575279</TD>
     </TR>
     <TR>
      <TD>5740</TD>
      <TD>0.024759173</TD>
     </TR>
     <TR>
      <TD>5780</TD>
      <TD>0.0084304269</TD>
     </TR>
     <TR>
      <TD>5820</TD>
      <TD>0.0028277326</TD>
     </TR>
     <TR>
      <TD>5860</TD>
      <TD>0.0010663539</TD>
     </TR>
     <TR>
      <TD>5900</TD>
      <TD>0.00063156598</TD>
     </TR>
     <TR>
      <TD>5940</TD>
      <TD>0.00058328261</TD>
     </TR>
     <TR>
      <TD>5980</TD>
      <TD>0.00052595051</TD>
     </TR>
     <TR>
      <TD>6020</TD>
      <TD>0.00036088334</TD>
     </TR>
     <TR>
      <TD>6060</TD>
      <TD>0.00016197572</TD>
     </TR>
     <TR>
      <TD>6100</TD>
      <TD>0</TD>
     </TR>
    </TABLEDATA>
   </DATA>
  </TABLE>
 </RESOURCE>
</VOTABLE>
