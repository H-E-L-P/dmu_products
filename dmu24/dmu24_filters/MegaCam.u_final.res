<?xml version="1.0" encoding="utf-8"?>
<!-- Produced with astropy.io.votable version 1.3.3
     http://www.astropy.org/ -->
<VOTABLE version="1.1" xmlns="http://www.ivoa.net/xml/VOTable/v1.1" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:noNamespaceSchemaLocation="http://www.ivoa.net/xml/VOTable/v1.1">
 <PARAM ID="ForegroundExtinction" arraysize="*" datatype="float" name="ForegroundExtinction" unit="" value="4.5949999999999998">
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
   <PARAM ID="filterID" arraysize="*" datatype="char" name="filterID" ucd="meta.id" utype="photdm:PhotometryFilter.identifier" value="CFHT/MegaCam.u"/>
   <PARAM ID="WavelengthUnit" arraysize="*" datatype="char" name="WavelengthUnit" ucd="meta.unit" utype="PhotometryFilter.SpectralAxis.unit" value="Angstrom"/>
   <PARAM ID="WavelengthUCD" arraysize="*" datatype="char" name="WavelengthUCD" ucd="meta.ucd" utype="PhotometryFilter.SpectralAxis.UCD" value="em.wl"/>
   <PARAM ID="Description" arraysize="*" datatype="char" name="Description" ucd="meta.note" utype="photdm:PhotometryFilter.description" value="MegaCam u  (includes CCD, mirror, optics)"/>
   <PARAM ID="PhotSystem" arraysize="*" datatype="char" name="PhotSystem" utype="photdm:PhotometricSystem.description" value="Megaprime">
    <DESCRIPTION>
     Photometric system
    </DESCRIPTION>
   </PARAM>
   <PARAM ID="Band" arraysize="*" datatype="char" name="Band" utype="photdm:PhotometryFilter.bandName" value="u"/>
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
   <PARAM ID="Description" arraysize="*" datatype="char" name="Description" ucd="meta.note" utype="photdm:PhotometryFilter.description" value="MegaCam u  (includes CCD, mirror, optics)"/>
   <PARAM ID="WavelengthMean" datatype="float" name="WavelengthMean" ucd="em.wl" unit="AA" utype="photdm:PhotometryFilter.SpectralAxis.Coverage.Location.Value" value="3811.3145690964">
    <DESCRIPTION>
     Mean wavelength. Defined as integ[x*filter(x) dx]/integ[filter(x)
     dx]
    </DESCRIPTION>
   </PARAM>
   <PARAM ID="WavelengthEff" datatype="float" name="WavelengthEff" ucd="em.wl.effective" unit="AA" value="3881.5755299418">
    <DESCRIPTION>
     Effective wavelength. Defined as integ[x*filter(x)*vega(x)
     dx]/integ[filter(x)*vega(x) dx]
    </DESCRIPTION>
   </PARAM>
   <PARAM ID="WavelengthMin" datatype="float" name="WavelengthMin" ucd="em.wl;stat.min" unit="AA" utype="photdm:PhotometryFilter.SpectralAxis.Coverage.Bounds.Start" value="3265.7996615881">
    <DESCRIPTION>
     Minimum filter wavelength. Defined as the first lambda value with
     a transmission at least 1% of maximum transmission
    </DESCRIPTION>
   </PARAM>
   <PARAM ID="WavelengthMax" datatype="float" name="WavelengthMax" ucd="em.wl;stat.max" unit="AA" utype="photdm:PhotometryFilter.SpectralAxis.Coverage.Bounds.Stop" value="5169.2286415694">
    <DESCRIPTION>
     Maximum filter wavelength. Defined as the last lambda value with
     a transmission at least 1% of maximum transmission
    </DESCRIPTION>
   </PARAM>
   <PARAM ID="WidthEff" datatype="float" name="WidthEff" ucd="instr.bandwidth" unit="AA" utype="photdm:PhotometryFilter.SpectralAxis.Coverage.Bounds.Extent" value="574.78110828839">
    <DESCRIPTION>
     Effective width. Defined as integ[x*filter(x) dx].\nEquivalent to
     the horizontal size of a rectangle with height equal to maximum
     transmission and with the same area that the one covered by the
     filter transmission curve.
    </DESCRIPTION>
   </PARAM>
   <PARAM ID="WavelengthCen" datatype="float" name="WavelengthCen" ucd="em.wl" unit="AA" value="3792.8113148998">
    <DESCRIPTION>
     Central wavelength. Defined as the central wavelength between the
     two points defining FWMH
    </DESCRIPTION>
   </PARAM>
   <PARAM ID="WavelengthPivot" datatype="float" name="WavelengthPivot" ucd="em.wl" unit="AA" value="3802.9371116595">
    <DESCRIPTION>
     Peak wavelength. Defined as sqrt{integ[x*filter(x)
     dx]/integ[filter(x) dx/x]}
    </DESCRIPTION>
   </PARAM>
   <PARAM ID="WavelengthPeak" datatype="float" name="WavelengthPeak" ucd="em.wl" unit="AA" value="4020">
    <DESCRIPTION>
     Peak wavelength. Defined as the lambda value with larger
     transmission
    </DESCRIPTION>
   </PARAM>
   <PARAM ID="WavelengthPhot" datatype="float" name="WavelengthPhot" ucd="em.wl" unit="AA" value="3895.715449145">
    <DESCRIPTION>
     Photon distribution based effective wavelength. Defined as
     integ[x^2*filter(x)*vega(x) dx]/integ[x*filter(x)*vega(x) dx]
    </DESCRIPTION>
   </PARAM>
   <PARAM ID="FWHM" datatype="float" name="FWHM" ucd="instr.bandwidth" unit="AA" value="653.73658608555">
    <DESCRIPTION>
     Full width at half maximum. Defined as the difference between the
     two wavelengths for which filter transmission is half maximum
    </DESCRIPTION>
   </PARAM>
   <PARAM ID="PhotCalID" arraysize="*" datatype="char" name="PhotCalID" ucd="meta.id" utype="photdm:PhotCal.identifier" value="CFHT/MegaCam.u/AB"/>
   <PARAM ID="MagSys" arraysize="*" datatype="char" name="MagSys" ucd="meta.code" utype="photdm:PhotCal.MagnitudeSystem.type" value="AB"/>
   <PARAM ID="ZeroPoint" datatype="float" name="ZeroPoint" ucd="phot.flux.density" unit="Jy" utype="photdm:PhotCal.ZeroPoint.Flux.value" value="3631"/>
   <PARAM ID="ZeroPointUnit" arraysize="*" datatype="char" name="ZeroPointUnit" ucd="meta.unit" utype="photdm:PhotCal.ZeroPoint.Flux.unit" value="Jy"/>
   <PARAM ID="ZeroPointType" arraysize="*" datatype="char" name="ZeroPointType" ucd="meta.code" utype="photdm:PhotCal.ZeroPoint.type" value="Pogson"/>
   <DATA>
    <TABLEDATA>
     <TR>
      <TD>3000</TD>
      <TD>0</TD>
     </TR>
     <TR>
      <TD>3180</TD>
      <TD>0.00011937418</TD>
     </TR>
     <TR>
      <TD>3220</TD>
      <TD>0.00055510382</TD>
     </TR>
     <TR>
      <TD>3260</TD>
      <TD>0.0022431731</TD>
     </TR>
     <TR>
      <TD>3300</TD>
      <TD>0.016097343</TD>
     </TR>
     <TR>
      <TD>3340</TD>
      <TD>0.064855196</TD>
     </TR>
     <TR>
      <TD>3380</TD>
      <TD>0.13595639</TD>
     </TR>
     <TR>
      <TD>3420</TD>
      <TD>0.17992936</TD>
     </TR>
     <TR>
      <TD>3460</TD>
      <TD>0.20712371</TD>
     </TR>
     <TR>
      <TD>3500</TD>
      <TD>0.24395218</TD>
     </TR>
     <TR>
      <TD>3540</TD>
      <TD>0.27007592</TD>
     </TR>
     <TR>
      <TD>3580</TD>
      <TD>0.2772764</TD>
     </TR>
     <TR>
      <TD>3620</TD>
      <TD>0.28345618</TD>
     </TR>
     <TR>
      <TD>3660</TD>
      <TD>0.29506102</TD>
     </TR>
     <TR>
      <TD>3700</TD>
      <TD>0.27939746</TD>
     </TR>
     <TR>
      <TD>3740</TD>
      <TD>0.26183391</TD>
     </TR>
     <TR>
      <TD>3780</TD>
      <TD>0.28138825</TD>
     </TR>
     <TR>
      <TD>3820</TD>
      <TD>0.33655638</TD>
     </TR>
     <TR>
      <TD>3860</TD>
      <TD>0.38306957</TD>
     </TR>
     <TR>
      <TD>3900</TD>
      <TD>0.38766381</TD>
     </TR>
     <TR>
      <TD>3940</TD>
      <TD>0.39384523</TD>
     </TR>
     <TR>
      <TD>3980</TD>
      <TD>0.41868186</TD>
     </TR>
     <TR>
      <TD>4020</TD>
      <TD>0.42519104</TD>
     </TR>
     <TR>
      <TD>4060</TD>
      <TD>0.38819182</TD>
     </TR>
     <TR>
      <TD>4100</TD>
      <TD>0.28170982</TD>
     </TR>
     <TR>
      <TD>4140</TD>
      <TD>0.14123081</TD>
     </TR>
     <TR>
      <TD>4180</TD>
      <TD>0.04994747</TD>
     </TR>
     <TR>
      <TD>4220</TD>
      <TD>0.016896561</TD>
     </TR>
     <TR>
      <TD>4260</TD>
      <TD>0.0067613185</TD>
     </TR>
     <TR>
      <TD>4300</TD>
      <TD>0.0032566101</TD>
     </TR>
     <TR>
      <TD>4340</TD>
      <TD>0.0018893959</TD>
     </TR>
     <TR>
      <TD>4380</TD>
      <TD>0.0012776966</TD>
     </TR>
     <TR>
      <TD>4420</TD>
      <TD>0.00096362812</TD>
     </TR>
     <TR>
      <TD>4460</TD>
      <TD>0.00078832789</TD>
     </TR>
     <TR>
      <TD>4500</TD>
      <TD>0.0006886851</TD>
     </TR>
     <TR>
      <TD>4540</TD>
      <TD>0.00060211838</TD>
     </TR>
     <TR>
      <TD>4580</TD>
      <TD>0.00053444912</TD>
     </TR>
     <TR>
      <TD>4620</TD>
      <TD>0.00050634367</TD>
     </TR>
     <TR>
      <TD>4660</TD>
      <TD>0.00052846828</TD>
     </TR>
     <TR>
      <TD>4700</TD>
      <TD>0.00058191112</TD>
     </TR>
     <TR>
      <TD>4740</TD>
      <TD>0.00069617503</TD>
     </TR>
     <TR>
      <TD>4780</TD>
      <TD>0.00087216141</TD>
     </TR>
     <TR>
      <TD>4820</TD>
      <TD>0.0011523073</TD>
     </TR>
     <TR>
      <TD>4860</TD>
      <TD>0.0017115194</TD>
     </TR>
     <TR>
      <TD>4900</TD>
      <TD>0.0027465941</TD>
     </TR>
     <TR>
      <TD>4940</TD>
      <TD>0.0048157992</TD>
     </TR>
     <TR>
      <TD>4980</TD>
      <TD>0.0079641053</TD>
     </TR>
     <TR>
      <TD>5020</TD>
      <TD>0.010041273</TD>
     </TR>
     <TR>
      <TD>5060</TD>
      <TD>0.0094757285</TD>
     </TR>
     <TR>
      <TD>5100</TD>
      <TD>0.0076275412</TD>
     </TR>
     <TR>
      <TD>5140</TD>
      <TD>0.0056869509</TD>
     </TR>
     <TR>
      <TD>5180</TD>
      <TD>0.0037230684</TD>
     </TR>
     <TR>
      <TD>5220</TD>
      <TD>0.0020897742</TD>
     </TR>
     <TR>
      <TD>5260</TD>
      <TD>0.0012748573</TD>
     </TR>
     <TR>
      <TD>5300</TD>
      <TD>0.0013076997</TD>
     </TR>
     <TR>
      <TD>5340</TD>
      <TD>0.0016671276</TD>
     </TR>
     <TR>
      <TD>5380</TD>
      <TD>0.001766492</TD>
     </TR>
     <TR>
      <TD>5420</TD>
      <TD>0.0015002972</TD>
     </TR>
     <TR>
      <TD>5460</TD>
      <TD>0.0012288026</TD>
     </TR>
     <TR>
      <TD>5500</TD>
      <TD>0.001337601</TD>
     </TR>
     <TR>
      <TD>5540</TD>
      <TD>0</TD>
     </TR>
    </TABLEDATA>
   </DATA>
  </TABLE>
 </RESOURCE>
</VOTABLE>
