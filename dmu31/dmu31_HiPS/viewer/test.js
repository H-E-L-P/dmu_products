//$('#layersControl').show();

var aladin = A.aladin('#aladin-lite-div', {cooFrame: 'equatorial', target: '10 00 20 +02 13 00', fov: 7, realFullscreen: true});
        
aladin.createImageSurvey('help_pacs_green', 
                                 'help_pacs_green', 
                'http://hedam.lam.fr/HELP/dataproducts/dmu31/dmu31_HiPS/data/pacs_green', 
                                 'equatorial', 
                                 7, 
                                 {imgFormat: 'png'}
                                 );
aladin.createImageSurvey('help_pacs_red', 
                                 'help_pacs_red', 
                 'http://hedam.lam.fr/HELP/dataproducts/dmu31/dmu31_HiPS/data/pacs_red', 
                                 'equatorial', 
                                 7, 
                                 {imgFormat: 'png'}
                                 );
aladin.createImageSurvey('help_spire_250', 
                                 'help_spire_250', 
                 'http://hedam.lam.fr/HELP/dataproducts/dmu31/dmu31_HiPS/data/spire_250', 
                                 'equatorial', 
                                 7, 
                                 {imgFormat: 'png'}
                                 );
aladin.createImageSurvey('help_spire_350', 
                                 'help_spire_350', 
                 'http://hedam.lam.fr/HELP/dataproducts/dmu31/dmu31_HiPS/data/spire_350', 
                                 'equatorial', 
                                 6, 
                                 {imgFormat: 'png'}
                                 );
aladin.createImageSurvey('help_spire_500', 
                                 'help_spire_500', 
                 'http://hedam.lam.fr/HELP/dataproducts/dmu31/dmu31_HiPS/data/spire_500', 
                                 'equatorial', 
                                 6, 
                                 {imgFormat: 'png'}
                                 );
aladin.createImageSurvey('help_spire_rgb', 
                                 'help_spire_rgb', 
                 'http://hedam.lam.fr/HELP/dataproducts/dmu31/dmu31_HiPS/data/spire_rgb', 
                                 'equatorial', 
                                 7, 
                                 {imgFormat: 'png'}
                                 );
        //aladin.setBaseImageLayer('help_spire_rgb');
//aladin.setImageSurvey('http://hedam.lam.fr/HELP/dataproducts/dmu31/dmu31_HiPS/data/spire_250/');
aladin.setImageSurvey('help_spire_rgb');
                              
        //var moc = A.MOCFromURL(
        //              'http://hedam.lam.fr/HELP/dataproducts/dmu2/help_coverage_MOC.fits', 
        //              {color: '#84f', lineWidth: 1}
         //                     );
        //aladin.includeMOC(moc);
        //moc.hide();
        //aladin.gotoRaDec(15, 0);

        //http://hedam.lam.fr/HELP/dataproducts/dmu31/dmu31_HiPS/data/help_dr1_alist/
        //'showTable' 'showPopup'
        // need to add link to sed
var hipsCats = {
    'help_alist': A.catalogHiPS('http://hedam.lam.fr/HELP/dataproducts/dmu31/dmu31_HiPS/data/help_dr1_alist',    
                               {onClick: 'showTable', name: 'HELP DR1 A list'}),
                               
        'help': A.catalogHiPS('http://hedam.lam.fr/HELP/dataproducts/dmu31/dmu31_HiPS/data/help_dr1',    
                               {name: 'HELP DR1 Masterlist'}),
    'gdr2': A.catalogHiPS('http://axel.u-strasbg.fr/HiPSCatService/I/345/gaia2',    
                               {onClick: 'showTable', name: 'Gaia DR2 sources'}),
    'simbad': A.catalogHiPS('http://axel.u-strasbg.fr/HiPSCatService/Simbad', 
                                {onClick: 'showTable', name: 'Simbad'})
};
//table:
//https://herschel-vos.phys.sussex.ac.uk/herschelhelp/q/cone/form?__nevow_form__=genForm&help_id=HELP_J161214.420%2B555305.791&_DBOPTIONS_ORDER=&_DBOPTIONS_DIR=ASC&MAXREC=100&_FORMAT=HTML&submit=Go
//sed:
//https://herschel-vos.phys.sussex.ac.uk/bestseds/q/sdl/dlmeta?ID=ivo%3A//x-unregistred/%7E%3Fbestseds/data/GAMA-09/HELP_J084426.228p012824.790_best_model.fits

hipsCats['help'].hide();
hipsCats['gdr2'].hide();
hipsCats['simbad'].hide();

    

aladin.addCatalog(hipsCats['gdr2']);
aladin.addCatalog(hipsCats['simbad']);
aladin.addCatalog(hipsCats['help']);
aladin.addCatalog(hipsCats['help_alist']);

//aladin.setOverlayImageLayer(
//    aladin.createImageSurvey('help', 
//                             'help', 
//            'http://hedam.lam.fr/help/dataproducts/dmu31/dmu31_HiPS/spire_500/', 
//                             'equatorial', 
//                              3, 
//                           {imgFormat: 'png'}));
//aladin.getOverlayImageLayer().setAlpha(1.0);
//aladin.removeLayers();

$('input[name=survey]').change(function() {
    aladin.setImageSurvey($(this).val());
});




// define function triggered when an object is clicked
var objClicked;
aladin.on('objectClicked', function(object) {
    var msg;
    if (object) {
        objClicked = object;
      object.select();
        msg = 'You clicked object ' + object.data.help_id + ' located at ' + object.ra + ', ' + object.dec;
    }

    var img;
   //helpid field help id
    if (object) {
        objClicked = object;
      object.select(); 
      img = '';
        if (String(object.data.help_id).startsWith('HELP') && !isNaN(object.data.redshift)){
          img = '<div style = "background-color:white; "><img style="max-width:100%; max-height:90%" src="https://herschel-vos.phys.sussex.ac.uk/getproduct/bestseds/data/' + object.data.field.replace('HATLAS-', '') + '/' + object.data.help_id.replace('+', 'p') + '_best_model.fits?preview=True&width=null" alt="CIGALE SED">' + '<a href="https://herschel-vos.phys.sussex.ac.uk/herschelhelp/q/cone/form?__nevow_form__=genForm&help_id=' + object.data.help_id.replace('+', '%2B') +'&_DBOPTIONS_ORDER=&_DBOPTIONS_DIR=ASC&MAXREC=100&_FORMAT=HTML&submit=Go"> Full table</a>.' + '<a href="https://herschel-vos.phys.sussex.ac.uk/bestseds/q/sdl/dlmeta?ID=ivo%3A//x-unregistred/%7E%3Fbestseds/data/' + object.data.field.replace('HATLAS-', '') + '/' + object.data.help_id.replace('+', 'p') + '_best_model.fits"> Full CIGALE data</a>.</div>';
        } else if (String(object.data.help_id).startsWith('HELP') && isNaN(object.data.redshift)){
        $.getJSON('https://herschel-vos.phys.sussex.ac.uk/__system__/adql/query/form?__nevow_form__=genForm&query=SELECT%20f_decam_g%2C%0Af_decam_r%2C%0Af_decam_i%2C%0Af_decam_z%2C%0Af_decam_y%2C%0Af_gpc1_g%2C%0Af_gpc1_r%2C%0Af_gpc1_i%2C%0Af_gpc1_z%2C%0Af_gpc1_y%2C%0Af_megacam_u%2C%0Af_megacam_g%2C%0Af_megacam_r%2C%0Af_megacam_i%2C%0Af_megacam_z%2C%0Af_megacam_y%2C%0Af_omegacam_u%2C%0Af_omegacam_g%2C%0Af_omegacam_r%2C%0Af_omegacam_i%2C%0Af_omegacam_z%2C%0Af_suprime_g%2C%0Af_suprime_r%2C%0Af_suprime_i%2C%0Af_suprime_z%2C%0Af_suprime_y%2C%0Af_ukidss_y%2C%0Af_ukidss_j%2C%0Af_ukidss_h%2C%0Af_ukidss_k%2C%0Af_vista_z%2C%0Af_vista_y%2C%0Af_vista_j%2C%0Af_vista_h%2C%0Af_vista_ks%2C%0Af_wircam_y%2C%0Af_wircam_j%2C%0Af_wircam_h%2C%0Af_wircam_ks%2C%0Af_newfirm_h%2C%0Af_newfirm_j%2C%0Af_newfirm_k%2C%0Af_hawki_k%2C%0Af_isaac_k%2C%0Af_irac_i1%2C%0Af_irac_i2%2C%0Af_irac_i3%2C%0Af_irac_i4%2C%0Af_mips_24%2C%0Af_pacs_green%2C%0Af_pacs_red%2C%0Af_spire_250%2C%0Af_spire_350%2C%0Af_spire_500%20from%20herschelhelp.main%20WHERE%20herschelhelp.main.help_id%20%3D%20%27' + object.data.help_id.replace('+', '%2B') + '%27&_TIMEOUT=5&MAXREC=1&_FORMAT=JSON&_VERB=H&submit=Go', function(data) {
        
          var text = `flux: ${data.data}`
          var fluxes = data.data
        
          //$(".mypanel").html(text);
        


          var trace = {
  x: [482.71217397181, 641.37280834062, 782.16316055119, 922.65261456512, 984.1970727457499, 488.14666666667, 619.8409716758499, 754.93420121335, 870.13745098039, 950.97960069444, 379.28113148998, 487.18048332752994, 627.5726000817, 761.4946914408899, 872.81553176671, 770.41251350225, 355.9666829009, 473.33790398152996, 630.24252361175, 761.49088628139, 884.61150857536, 480.0, 620.0, 745.0, 880.0, 950.0, 1030.38945975, 1248.54875553, 1638.0523148099999, 2205.63301146, 878.0296597665799, 1020.2454054773, 1252.3903361602001, 1645.1873341695002, 2146.7610291507, 1025.3505635400002, 1254.0539652100001, 1630.84244171, 2150.03675632, 1632.570419245, 1249.333030303, 2145.2807104737, 2144.0350461999997, 2162.16767154, 3546.5616067, 4502.43077093, 5715.65543751, 7855.648757680001, 23471.506075228, 102338.21435593, 166069.81872365, 250762.14661902998, 349922.96233458, 510623.10042116],
  y: fluxes[0],
  mode: 'markers',
  type: 'scatter',
  name: 'Fluxes',
  text: ['f_decam_g', 'f_decam_r', 'f_decam_i', 'f_decam_z', 'f_decam_y', 'f_gpc1_g', 'f_gpc1_r', 'f_gpc1_i', 'f_gpc1_z', 'f_gpc1_y', 'f_megacam_u', 'f_megacam_g', 'f_megacam_r', 'f_megacam_i', 'f_megacam_z', 'f_megacam_y', 'f_omegacam_u', 'f_omegacam_g', 'f_omegacam_r', 'f_omegacam_i', 'f_omegacam_z', 'f_suprime_g', 'f_suprime_r', 'f_suprime_i', 'f_suprime_z', 'f_suprime_y', 'f_ukidss_y', 'f_ukidss_j', 'f_ukidss_h', 'f_ukidss_k', 'f_vista_z', 'f_vista_y', 'f_vista_j', 'f_vista_h', 'f_vista_ks', 'f_wircam_y', 'f_wircam_j', 'f_wircam_h', 'f_wircam_ks', 'f_newfirm_h', 'f_newfirm_j', 'f_newfirm_k', 'f_hawki_k', 'f_isaac_k', 'f_irac_i1', 'f_irac_i2', 'f_irac_i3', 'f_irac_i4', 'f_mips_24', 'f_pacs_green', 'f_pacs_red', 'f_spire_250', 'f_spire_350', 'f_spire_500'],
  marker: { size: 4 }
};



var traces = [ trace];

var layout = {
  xaxis: {
    title: {
      text: 'Wavelength [nm]',
      font: {
        family: 'Courier New, monospace',
        size: 10,
        color: '#7f7f7f'
      }
    },
    type: 'log',
    size: 10,
    autorange: true
  },
  yaxis: {
    title: {
      text: 'Flux [uJy]',
      font: {
        family: 'Courier New, monospace',
        size: 10,
        color: '#7f7f7f'
      }
    },
 
    type: 'log',
    size: 10,
    autorange: true
  },
    title: '<a href="https://herschel-vos.phys.sussex.ac.uk/herschelhelp/q/cone/form?__nevow_form__=genForm&help_id=' + object.data.help_id.replace('+', '%2B') +'&_DBOPTIONS_ORDER=&_DBOPTIONS_DIR=ASC&MAXREC=100&_FORMAT=HTML&submit=Go">' + object.data.help_id + '</a>'
};

Plotly.newPlot('cigale_div', traces, layout, {showSendToCloud: true});
        
        
        
    });
        }
    }
    
    
    $('#cigale-div').html(img);
});


    //https://herschel-vos.phys.sussex.ac.uk/__system__/adql/query/form?__nevow_form__=genForm&query=SELECT%20*%20FROM%20herschelhelp.main%20WHERE%20herschelhelp.main.help_id%3D%27HELP_J161214.420%2B555305.791%27&_TIMEOUT=5&_FORMAT=JSON&_VERB=H&submit=Go
    //http://dc.zah.uni-heidelberg.de/__system__/adql/query/form?__nevow_form__=genForm&query=SELECT%20TOP%201%20*%20FROM%20ivoa.obscore&_TIMEOUT=5&MAXREC=100&_FORMAT=JSON&_VERB=H&submit=Go
    
//http://vohedamtest.lam.fr/__system__/adql/query/form?__nevow_form__=genForm&query=SELECT%20*%20FROM%20herschelhelp.main%20WHERE%20herschelhelp.main.help_id%3D%27HELP_J161214.420%2B555305.791%27&_TIMEOUT=5&MAXREC=100&_FORMAT=JSON&_VERB=H&submit=Go
    

    
    
//' + object.data.help_id.replace('+', '%2B') +'

