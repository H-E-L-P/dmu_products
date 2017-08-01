<?xml version="1.0" encoding="utf-8"?>
<!-- Produced with astropy.io.votable version 1.3.3
     http://www.astropy.org/ -->
<VOTABLE version="1.1" xmlns="http://www.ivoa.net/xml/VOTable/v1.1" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:noNamespaceSchemaLocation="http://www.ivoa.net/xml/VOTable/v1.1">
 <PARAM ID="ForegroundExtinction" arraysize="*" datatype="float" name="ForegroundExtinction" unit="" value="1.444">
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
  <TABLE nrows="63" utype="photdm:PhotometryFilter.transmissionCurve.spectrum">
   <FIELD ID="Wavelength" datatype="float" name="Wavelength" ucd="em.wl" unit="AA" utype="spec:Data.SpectralAxis.Value"/>
   <FIELD ID="Transmission" datatype="float" name="Transmission" ucd="phys.transmission" utype="spec:Data.FluxAxis.Value"/>
   <PARAM ID="FilterProfileService" arraysize="*" datatype="char" name="FilterProfileService" ucd="meta.ref.ivorn" utype="PhotometryFilter.fpsIdentifier" value="ivo://svo/fps"/>
   <PARAM ID="filterID" arraysize="*" datatype="char" name="filterID" ucd="meta.id" utype="photdm:PhotometryFilter.identifier" value="CFHT/MegaCam.z"/>
   <PARAM ID="WavelengthUnit" arraysize="*" datatype="char" name="WavelengthUnit" ucd="meta.unit" utype="PhotometryFilter.SpectralAxis.unit" value="Angstrom"/>
   <PARAM ID="WavelengthUCD" arraysize="*" datatype="char" name="WavelengthUCD" ucd="meta.ucd" utype="PhotometryFilter.SpectralAxis.UCD" value="em.wl"/>
   <PARAM ID="Description" arraysize="*" datatype="char" name="Description" ucd="meta.note" utype="photdm:PhotometryFilter.description" value="MegaCam z  (includes CCD, mirror, optics)"/>
   <PARAM ID="PhotSystem" arraysize="*" datatype="char" name="PhotSystem" utype="photdm:PhotometricSystem.description" value="Megaprime">
    <DESCRIPTION>
     Photometric system
    </DESCRIPTION>
   </PARAM>
   <PARAM ID="Band" arraysize="*" datatype="char" name="Band" utype="photdm:PhotometryFilter.bandName" value="z"/>
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
   <PARAM ID="Description" arraysize="*" datatype="char" name="Description" ucd="meta.note" utype="photdm:PhotometryFilter.description" value="MegaCam z  (includes CCD, mirror, optics)"/>
   <PARAM ID="WavelengthMean" datatype="float" name="WavelengthMean" ucd="em.wl" unit="AA" utype="photdm:PhotometryFilter.SpectralAxis.Coverage.Location.Value" value="8871.2621304736">
    <DESCRIPTION>
     Mean wavelength. Defined as integ[x*filter(x) dx]/integ[filter(x)
     dx]
    </DESCRIPTION>
   </PARAM>
   <PARAM ID="WavelengthEff" datatype="float" name="WavelengthEff" ucd="em.wl.effective" unit="AA" value="8823.9560297655">
    <DESCRIPTION>
     Effective wavelength. Defined as integ[x*filter(x)*vega(x)
     dx]/integ[filter(x)*vega(x) dx]
    </DESCRIPTION>
   </PARAM>
   <PARAM ID="WavelengthMin" datatype="float" name="WavelengthMin" ucd="em.wl;stat.min" unit="AA" utype="photdm:PhotometryFilter.SpectralAxis.Coverage.Bounds.Start" value="8009.1635305891">
    <DESCRIPTION>
     Minimum filter wavelength. Defined as the first lambda value with
     a transmission at least 1% of maximum transmission
    </DESCRIPTION>
   </PARAM>
   <PARAM ID="WavelengthMax" datatype="float" name="WavelengthMax" ucd="em.wl;stat.max" unit="AA" utype="photdm:PhotometryFilter.SpectralAxis.Coverage.Bounds.Stop" value="10225.865445799">
    <DESCRIPTION>
     Maximum filter wavelength. Defined as the last lambda value with
     a transmission at least 1% of maximum transmission
    </DESCRIPTION>
   </PARAM>
   <PARAM ID="WidthEff" datatype="float" name="WidthEff" ucd="instr.bandwidth" unit="AA" utype="photdm:PhotometryFilter.SpectralAxis.Coverage.Bounds.Extent" value="998.38717381059">
    <DESCRIPTION>
     Effective width. Defined as integ[x*filter(x) dx].\nEquivalent to
     the horizontal size of a rectangle with height equal to maximum
     transmission and with the same area that the one covered by the
     filter transmission curve.
    </DESCRIPTION>
   </PARAM>
   <PARAM ID="WavelengthCen" datatype="float" name="WavelengthCen" ucd="em.wl" unit="AA" value="8728.1553176671">
    <DESCRIPTION>
     Central wavelength. Defined as the central wavelength between the
     two points defining FWMH
    </DESCRIPTION>
   </PARAM>
   <PARAM ID="WavelengthPivot" datatype="float" name="WavelengthPivot" ucd="em.wl" unit="AA" value="8859.9290802557">
    <DESCRIPTION>
     Peak wavelength. Defined as sqrt{integ[x*filter(x)
     dx]/integ[filter(x) dx/x]}
    </DESCRIPTION>
   </PARAM>
   <PARAM ID="WavelengthPeak" datatype="float" name="WavelengthPeak" ucd="em.wl" unit="AA" value="8400">
    <DESCRIPTION>
     Peak wavelength. Defined as the lambda value with larger
     transmission
    </DESCRIPTION>
   </PARAM>
   <PARAM ID="WavelengthPhot" datatype="float" name="WavelengthPhot" ucd="em.wl" unit="AA" value="8845.7021134256">
    <DESCRIPTION>
     Photon distribution based effective wavelength. Defined as
     integ[x^2*filter(x)*vega(x) dx]/integ[x*filter(x)*vega(x) dx]
    </DESCRIPTION>
   </PARAM>
   <PARAM ID="FWHM" datatype="float" name="FWHM" ucd="instr.bandwidth" unit="AA" value="935.52073324707">
    <DESCRIPTION>
     Full width at half maximum. Defined as the difference between the
     two wavelengths for which filter transmission is half maximum
    </DESCRIPTION>
   </PARAM>
   <PARAM ID="PhotCalID" arraysize="*" datatype="char" name="PhotCalID" ucd="meta.id" utype="photdm:PhotCal.identifier" value="CFHT/MegaCam.z/AB"/>
   <PARAM ID="MagSys" arraysize="*" datatype="char" name="MagSys" ucd="meta.code" utype="photdm:PhotCal.MagnitudeSystem.type" value="AB"/>
   <PARAM ID="ZeroPoint" datatype="float" name="ZeroPoint" ucd="phot.flux.density" unit="Jy" utype="photdm:PhotCal.ZeroPoint.Flux.value" value="3631"/>
   <PARAM ID="ZeroPointUnit" arraysize="*" datatype="char" name="ZeroPointUnit" ucd="meta.unit" utype="photdm:PhotCal.ZeroPoint.Flux.unit" value="Jy"/>
   <PARAM ID="ZeroPointType" arraysize="*" datatype="char" name="ZeroPointType" ucd="meta.code" utype="photdm:PhotCal.ZeroPoint.type" value="Pogson"/>
   <DATA>
    <TABLEDATA>
     <TR>
      <TD>7780</TD>
      <TD>0</TD>
     </TR>
     <TR>
      <TD>7800</TD>
      <TD>0.00029815448</TD>
     </TR>
     <TR>
      <TD>7840</TD>
      <TD>0.00042138263</TD>
     </TR>
     <TR>
      <TD>7880</TD>
      <TD>0.00061784475</TD>
     </TR>
     <TR>
      <TD>7920</TD>
      <TD>0.00092385977</TD>
     </TR>
     <TR>
      <TD>7960</TD>
      <TD>0.0014546468</TD>
     </TR>
     <TR>
      <TD>8000</TD>
      <TD>0.0023868161</TD>
     </TR>
     <TR>
      <TD>8040</TD>
      <TD>0.0040533459</TD>
     </TR>
     <TR>
      <TD>8080</TD>
      <TD>0.0073296246</TD>
     </TR>
     <TR>
      <TD>8120</TD>
      <TD>0.01398007</TD>
     </TR>
     <TR>
      <TD>8160</TD>
      <TD>0.027856743</TD>
     </TR>
     <TR>
      <TD>8200</TD>
      <TD>0.05540904</TD>
     </TR>
     <TR>
      <TD>8240</TD>
      <TD>0.10483541</TD>
     </TR>
     <TR>
      <TD>8280</TD>
      <TD>0.17072332</TD>
     </TR>
     <TR>
      <TD>8320</TD>
      <TD>0.22810887</TD>
     </TR>
     <TR>
      <TD>8360</TD>
      <TD>0.26320705</TD>
     </TR>
     <TR>
      <TD>8400</TD>
      <TD>0.27685985</TD>
     </TR>
     <TR>
      <TD>8440</TD>
      <TD>0.27568024</TD>
     </TR>
     <TR>
      <TD>8480</TD>
      <TD>0.27060729</TD>
     </TR>
     <TR>
      <TD>8520</TD>
      <TD>0.26625064</TD>
     </TR>
     <TR>
      <TD>8560</TD>
      <TD>0.26074976</TD>
     </TR>
     <TR>
      <TD>8600</TD>
      <TD>0.25438207</TD>
     </TR>
     <TR>
      <TD>8640</TD>
      <TD>0.24816823</TD>
     </TR>
     <TR>
      <TD>8680</TD>
      <TD>0.24147613</TD>
     </TR>
     <TR>
      <TD>8720</TD>
      <TD>0.23256624</TD>
     </TR>
     <TR>
      <TD>8760</TD>
      <TD>0.2222957</TD>
     </TR>
     <TR>
      <TD>8800</TD>
      <TD>0.21347576</TD>
     </TR>
     <TR>
      <TD>8840</TD>
      <TD>0.20597206</TD>
     </TR>
     <TR>
      <TD>8880</TD>
      <TD>0.19867945</TD>
     </TR>
     <TR>
      <TD>8920</TD>
      <TD>0.19132853</TD>
     </TR>
     <TR>
      <TD>8960</TD>
      <TD>0.18484418</TD>
     </TR>
     <TR>
      <TD>9000</TD>
      <TD>0.17820646</TD>
     </TR>
     <TR>
      <TD>9040</TD>
      <TD>0.17023714</TD>
     </TR>
     <TR>
      <TD>9080</TD>
      <TD>0.16227642</TD>
     </TR>
     <TR>
      <TD>9120</TD>
      <TD>0.15436642</TD>
     </TR>
     <TR>
      <TD>9160</TD>
      <TD>0.14577453</TD>
     </TR>
     <TR>
      <TD>9200</TD>
      <TD>0.1375947</TD>
     </TR>
     <TR>
      <TD>9240</TD>
      <TD>0.12939507</TD>
     </TR>
     <TR>
      <TD>9280</TD>
      <TD>0.12123132</TD>
     </TR>
     <TR>
      <TD>9320</TD>
      <TD>0.11339579</TD>
     </TR>
     <TR>
      <TD>9360</TD>
      <TD>0.10594935</TD>
     </TR>
     <TR>
      <TD>9400</TD>
      <TD>0.099046797</TD>
     </TR>
     <TR>
      <TD>9440</TD>
      <TD>0.09194845</TD>
     </TR>
     <TR>
      <TD>9480</TD>
      <TD>0.085006922</TD>
     </TR>
     <TR>
      <TD>9520</TD>
      <TD>0.079806462</TD>
     </TR>
     <TR>
      <TD>9560</TD>
      <TD>0.075923964</TD>
     </TR>
     <TR>
      <TD>9600</TD>
      <TD>0.071988203</TD>
     </TR>
     <TR>
      <TD>9640</TD>
      <TD>0.068027273</TD>
     </TR>
     <TR>
      <TD>9680</TD>
      <TD>0.063809723</TD>
     </TR>
     <TR>
      <TD>9720</TD>
      <TD>0.059489585</TD>
     </TR>
     <TR>
      <TD>9760</TD>
      <TD>0.055076484</TD>
     </TR>
     <TR>
      <TD>9800</TD>
      <TD>0.050637621</TD>
     </TR>
     <TR>
      <TD>9840</TD>
      <TD>0.046213109</TD>
     </TR>
     <TR>
      <TD>9880</TD>
      <TD>0.04172428</TD>
     </TR>
     <TR>
      <TD>9920</TD>
      <TD>0.037232168</TD>
     </TR>
     <TR>
      <TD>9960</TD>
      <TD>0.032823369</TD>
     </TR>
     <TR>
      <TD>10000</TD>
      <TD>0.028487908</TD>
     </TR>
     <TR>
      <TD>10040</TD>
      <TD>0.024232453</TD>
     </TR>
     <TR>
      <TD>10080</TD>
      <TD>0.020023488</TD>
     </TR>
     <TR>
      <TD>10120</TD>
      <TD>0.015877098</TD>
     </TR>
     <TR>
      <TD>10160</TD>
      <TD>0.0118273</TD>
     </TR>
     <TR>
      <TD>10200</TD>
      <TD>0.0078349793</TD>
     </TR>
     <TR>
      <TD>10240</TD>
      <TD>0</TD>
     </TR>
    </TABLEDATA>
   </DATA>
  </TABLE>
 </RESOURCE>
</VOTABLE>
