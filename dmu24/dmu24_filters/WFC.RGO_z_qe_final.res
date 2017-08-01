<?xml version="1.0" encoding="utf-8"?>
<!-- Produced with astropy.io.votable version 1.3.3
     http://www.astropy.org/ -->
<VOTABLE version="1.1" xmlns="http://www.ivoa.net/xml/VOTable/v1.1" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:noNamespaceSchemaLocation="http://www.ivoa.net/xml/VOTable/v1.1">
 <PARAM ID="AdditionalProcessing" arraysize="*" datatype="boolean" name="AdditionalProcessing" ucd="meta.note" value="T">
  <DESCRIPTION>
   Filter convolved with INT QE and INT airmass (assuming
   airmass=1.2)  QE information:
   http://www.ing.iac.es/Engineering/detectors/4280qe.htm ATM
   information:
   http://www.ing.iac.es/astronomy/observing/conditions/wlext.dat
  </DESCRIPTION>
 </PARAM>
 <PARAM ID="ForegroundExtinction" arraysize="*" datatype="float" name="ForegroundExtinction" unit="" value="1.4770000000000001">
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
  <TABLE nrows="79" utype="photdm:PhotometryFilter.transmissionCurve.spectrum">
   <FIELD ID="Wavelength" datatype="float" name="Wavelength" ucd="em.wl" unit="AA" utype="spec:Data.SpectralAxis.Value"/>
   <FIELD ID="Transmission" datatype="float" name="Transmission" ucd="phys.transmission" utype="spec:Data.FluxAxis.Value"/>
   <PARAM ID="FilterProfileService" arraysize="*" datatype="char" name="FilterProfileService" ucd="meta.ref.ivorn" utype="PhotometryFilter.fpsIdentifier" value="ivo://svo/fps"/>
   <PARAM ID="filterID" arraysize="*" datatype="char" name="filterID" ucd="meta.id" utype="photdm:PhotometryFilter.identifier" value="INT/WFC.RGO_z"/>
   <PARAM ID="WavelengthUnit" arraysize="*" datatype="char" name="WavelengthUnit" ucd="meta.unit" utype="PhotometryFilter.SpectralAxis.unit" value="Angstrom"/>
   <PARAM ID="WavelengthUCD" arraysize="*" datatype="char" name="WavelengthUCD" ucd="meta.ucd" utype="PhotometryFilter.SpectralAxis.UCD" value="em.wl"/>
   <PARAM ID="Description" arraysize="*" datatype="char" name="Description" ucd="meta.note" utype="photdm:PhotometryFilter.description" value="RGO Z"/>
   <PARAM ID="PhotSystem" arraysize="*" datatype="char" name="PhotSystem" utype="photdm:PhotometricSystem.description" value="WFC">
    <DESCRIPTION>
     Photometric system
    </DESCRIPTION>
   </PARAM>
   <PARAM ID="Instrument" arraysize="*" datatype="char" name="Instrument" ucd="instr" value="WFC">
    <DESCRIPTION>
     Instrument
    </DESCRIPTION>
   </PARAM>
   <PARAM ID="Facility" arraysize="*" datatype="char" name="Facility" ucd="instr.obsty" value="INT">
    <DESCRIPTION>
     Observational facility
    </DESCRIPTION>
   </PARAM>
   <PARAM ID="ProfileReference" arraysize="*" datatype="char" name="ProfileReference" value="http://catserver.ing.iac.es/filter/list.php?instrument=WFC"/>
   <PARAM ID="Description" arraysize="*" datatype="char" name="Description" ucd="meta.note" utype="photdm:PhotometryFilter.description" value="RGO Z"/>
   <PARAM ID="Comments" arraysize="*" datatype="char" name="Comments" ucd="meta.note" value="WFCRGOZ"/>
   <PARAM ID="WavelengthMean" datatype="float" name="WavelengthMean" ucd="em.wl" unit="AA" utype="photdm:PhotometryFilter.SpectralAxis.Coverage.Location.Value" value="8746.77071173">
    <DESCRIPTION>
     Mean wavelength. Defined as integ[x*filter(x) dx]/integ[filter(x)
     dx]
    </DESCRIPTION>
   </PARAM>
   <PARAM ID="WavelengthEff" datatype="float" name="WavelengthEff" ucd="em.wl.effective" unit="AA" value="8744.27264693">
    <DESCRIPTION>
     Effective wavelength. Defined as integ[x*filter(x)*vega(x)
     dx]/integ[filter(x)*vega(x) dx]
    </DESCRIPTION>
   </PARAM>
   <PARAM ID="WavelengthMin" datatype="float" name="WavelengthMin" ucd="em.wl;stat.min" unit="AA" utype="photdm:PhotometryFilter.SpectralAxis.Coverage.Bounds.Start" value="8253.25906375">
    <DESCRIPTION>
     Minimum filter wavelength. Defined as the first lambda value with
     a transmission at least 1% of maximum transmission
    </DESCRIPTION>
   </PARAM>
   <PARAM ID="WavelengthMax" datatype="float" name="WavelengthMax" ucd="em.wl;stat.max" unit="AA" utype="photdm:PhotometryFilter.SpectralAxis.Coverage.Bounds.Stop" value="9000">
    <DESCRIPTION>
     Maximum filter wavelength. Defined as the last lambda value with
     a transmission at least 1% of maximum transmission
    </DESCRIPTION>
   </PARAM>
   <PARAM ID="WidthEff" datatype="float" name="WidthEff" ucd="instr.bandwidth" unit="AA" utype="photdm:PhotometryFilter.SpectralAxis.Coverage.Bounds.Extent" value="421.154784027">
    <DESCRIPTION>
     Effective width. Defined as integ[x*filter(x) dx].\nEquivalent to
     the horizontal size of a rectangle with height equal to maximum
     transmission and with the same area that the one covered by the
     filter transmission curve.
    </DESCRIPTION>
   </PARAM>
   <PARAM ID="WavelengthCen" datatype="float" name="WavelengthCen" ucd="em.wl" unit="AA" value="8768.3299389">
    <DESCRIPTION>
     Central wavelength. Defined as the central wavelength between the
     two points defining FWMH
    </DESCRIPTION>
   </PARAM>
   <PARAM ID="WavelengthPivot" datatype="float" name="WavelengthPivot" ucd="em.wl" unit="AA" value="8745.23531733">
    <DESCRIPTION>
     Peak wavelength. Defined as sqrt{integ[x*filter(x)
     dx]/integ[filter(x) dx/x]}
    </DESCRIPTION>
   </PARAM>
   <PARAM ID="WavelengthPeak" datatype="float" name="WavelengthPeak" ucd="em.wl" unit="AA" value="8990">
    <DESCRIPTION>
     Peak wavelength. Defined as the lambda value with larger
     transmission
    </DESCRIPTION>
   </PARAM>
   <PARAM ID="WavelengthPhot" datatype="float" name="WavelengthPhot" ucd="em.wl" unit="AA" value="8747.40449876">
    <DESCRIPTION>
     Photon distribution based effective wavelength. Defined as
     integ[x^2*filter(x)*vega(x) dx]/integ[x*filter(x)*vega(x) dx]
    </DESCRIPTION>
   </PARAM>
   <PARAM ID="FWHM" datatype="float" name="FWHM" ucd="instr.bandwidth" unit="AA" value="463.3401222">
    <DESCRIPTION>
     Full width at half maximum. Defined as the difference between the
     two wavelengths for which filter transmission is half maximum
    </DESCRIPTION>
   </PARAM>
   <PARAM ID="PhotCalID" arraysize="*" datatype="char" name="PhotCalID" ucd="meta.id" utype="photdm:PhotCal.identifier" value="INT/WFC.RGO_z/AB"/>
   <PARAM ID="MagSys" arraysize="*" datatype="char" name="MagSys" ucd="meta.code" utype="photdm:PhotCal.MagnitudeSystem.type" value="AB"/>
   <PARAM ID="ZeroPoint" datatype="float" name="ZeroPoint" ucd="phot.flux.density" unit="Jy" utype="photdm:PhotCal.ZeroPoint.Flux.value" value="3631"/>
   <PARAM ID="ZeroPointUnit" arraysize="*" datatype="char" name="ZeroPointUnit" ucd="meta.unit" utype="photdm:PhotCal.ZeroPoint.Flux.unit" value="Jy"/>
   <PARAM ID="ZeroPointType" arraysize="*" datatype="char" name="ZeroPointType" ucd="meta.code" utype="photdm:PhotCal.ZeroPoint.type" value="Pogson"/>
   <DATA>
    <TABLEDATA>
     <TR>
      <TD>8220</TD>
      <TD>0.0025144138</TD>
     </TR>
     <TR>
      <TD>8230</TD>
      <TD>0.0032359525</TD>
     </TR>
     <TR>
      <TD>8240</TD>
      <TD>0.0039631901</TD>
     </TR>
     <TR>
      <TD>8250</TD>
      <TD>0.0049399352</TD>
     </TR>
     <TR>
      <TD>8260</TD>
      <TD>0.006025726</TD>
     </TR>
     <TR>
      <TD>8270</TD>
      <TD>0.0074007777</TD>
     </TR>
     <TR>
      <TD>8280</TD>
      <TD>0.0091094337</TD>
     </TR>
     <TR>
      <TD>8290</TD>
      <TD>0.011168028</TD>
     </TR>
     <TR>
      <TD>8300</TD>
      <TD>0.013523205</TD>
     </TR>
     <TR>
      <TD>8310</TD>
      <TD>0.016407087</TD>
     </TR>
     <TR>
      <TD>8320</TD>
      <TD>0.019807646</TD>
     </TR>
     <TR>
      <TD>8330</TD>
      <TD>0.023838349</TD>
     </TR>
     <TR>
      <TD>8340</TD>
      <TD>0.028434834</TD>
     </TR>
     <TR>
      <TD>8350</TD>
      <TD>0.033679556</TD>
     </TR>
     <TR>
      <TD>8360</TD>
      <TD>0.039958291</TD>
     </TR>
     <TR>
      <TD>8370</TD>
      <TD>0.046771761</TD>
     </TR>
     <TR>
      <TD>8380</TD>
      <TD>0.05456141</TD>
     </TR>
     <TR>
      <TD>8390</TD>
      <TD>0.062931575</TD>
     </TR>
     <TR>
      <TD>8400</TD>
      <TD>0.072429411</TD>
     </TR>
     <TR>
      <TD>8410</TD>
      <TD>0.082175665</TD>
     </TR>
     <TR>
      <TD>8420</TD>
      <TD>0.093342379</TD>
     </TR>
     <TR>
      <TD>8430</TD>
      <TD>0.10397007</TD>
     </TR>
     <TR>
      <TD>8440</TD>
      <TD>0.11546364</TD>
     </TR>
     <TR>
      <TD>8450</TD>
      <TD>0.12802503</TD>
     </TR>
     <TR>
      <TD>8460</TD>
      <TD>0.14047724</TD>
     </TR>
     <TR>
      <TD>8470</TD>
      <TD>0.15244156</TD>
     </TR>
     <TR>
      <TD>8480</TD>
      <TD>0.16589652</TD>
     </TR>
     <TR>
      <TD>8490</TD>
      <TD>0.17765017</TD>
     </TR>
     <TR>
      <TD>8500</TD>
      <TD>0.18997183</TD>
     </TR>
     <TR>
      <TD>8510</TD>
      <TD>0.20215447</TD>
     </TR>
     <TR>
      <TD>8520</TD>
      <TD>0.21450068</TD>
     </TR>
     <TR>
      <TD>8530</TD>
      <TD>0.22563793</TD>
     </TR>
     <TR>
      <TD>8540</TD>
      <TD>0.23851793</TD>
     </TR>
     <TR>
      <TD>8550</TD>
      <TD>0.24899182</TD>
     </TR>
     <TR>
      <TD>8560</TD>
      <TD>0.25719762</TD>
     </TR>
     <TR>
      <TD>8570</TD>
      <TD>0.26817867</TD>
     </TR>
     <TR>
      <TD>8580</TD>
      <TD>0.27734619</TD>
     </TR>
     <TR>
      <TD>8590</TD>
      <TD>0.28357619</TD>
     </TR>
     <TR>
      <TD>8600</TD>
      <TD>0.29005671</TD>
     </TR>
     <TR>
      <TD>8610</TD>
      <TD>0.30002996</TD>
     </TR>
     <TR>
      <TD>8620</TD>
      <TD>0.30363557</TD>
     </TR>
     <TR>
      <TD>8630</TD>
      <TD>0.31026042</TD>
     </TR>
     <TR>
      <TD>8640</TD>
      <TD>0.31726104</TD>
     </TR>
     <TR>
      <TD>8650</TD>
      <TD>0.32285902</TD>
     </TR>
     <TR>
      <TD>8660</TD>
      <TD>0.32219958</TD>
     </TR>
     <TR>
      <TD>8670</TD>
      <TD>0.32613778</TD>
     </TR>
     <TR>
      <TD>8680</TD>
      <TD>0.33398306</TD>
     </TR>
     <TR>
      <TD>8690</TD>
      <TD>0.33259302</TD>
     </TR>
     <TR>
      <TD>8700</TD>
      <TD>0.33812281</TD>
     </TR>
     <TR>
      <TD>8710</TD>
      <TD>0.33557189</TD>
     </TR>
     <TR>
      <TD>8720</TD>
      <TD>0.34086114</TD>
     </TR>
     <TR>
      <TD>8730</TD>
      <TD>0.34471101</TD>
     </TR>
     <TR>
      <TD>8740</TD>
      <TD>0.34501794</TD>
     </TR>
     <TR>
      <TD>8750</TD>
      <TD>0.3457385</TD>
     </TR>
     <TR>
      <TD>8760</TD>
      <TD>0.35182008</TD>
     </TR>
     <TR>
      <TD>8770</TD>
      <TD>0.34686172</TD>
     </TR>
     <TR>
      <TD>8780</TD>
      <TD>0.34296787</TD>
     </TR>
     <TR>
      <TD>8790</TD>
      <TD>0.34703079</TD>
     </TR>
     <TR>
      <TD>8800</TD>
      <TD>0.34788913</TD>
     </TR>
     <TR>
      <TD>8810</TD>
      <TD>0.35010242</TD>
     </TR>
     <TR>
      <TD>8820</TD>
      <TD>0.34088543</TD>
     </TR>
     <TR>
      <TD>8830</TD>
      <TD>0.3452771</TD>
     </TR>
     <TR>
      <TD>8840</TD>
      <TD>0.34842062</TD>
     </TR>
     <TR>
      <TD>8850</TD>
      <TD>0.35014841</TD>
     </TR>
     <TR>
      <TD>8860</TD>
      <TD>0.34344813</TD>
     </TR>
     <TR>
      <TD>8870</TD>
      <TD>0.34792179</TD>
     </TR>
     <TR>
      <TD>8880</TD>
      <TD>0.34425479</TD>
     </TR>
     <TR>
      <TD>8890</TD>
      <TD>0.35226393</TD>
     </TR>
     <TR>
      <TD>8900</TD>
      <TD>0.33353341</TD>
     </TR>
     <TR>
      <TD>8910</TD>
      <TD>0.33594239</TD>
     </TR>
     <TR>
      <TD>8920</TD>
      <TD>0.33356827</TD>
     </TR>
     <TR>
      <TD>8930</TD>
      <TD>0.33235142</TD>
     </TR>
     <TR>
      <TD>8940</TD>
      <TD>0.34118092</TD>
     </TR>
     <TR>
      <TD>8950</TD>
      <TD>0.33027077</TD>
     </TR>
     <TR>
      <TD>8960</TD>
      <TD>0.33249229</TD>
     </TR>
     <TR>
      <TD>8970</TD>
      <TD>0.31890374</TD>
     </TR>
     <TR>
      <TD>8980</TD>
      <TD>0.33743513</TD>
     </TR>
     <TR>
      <TD>8990</TD>
      <TD>0.36046109</TD>
     </TR>
     <TR>
      <TD>9000</TD>
      <TD>0.34158012</TD>
     </TR>
    </TABLEDATA>
   </DATA>
  </TABLE>
 </RESOURCE>
</VOTABLE>
