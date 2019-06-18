var aladin = A.aladin('#aladin-lite-div', {cooFrame: 'equatorial', target: '00 45 00 +00 00 00', fov: 60, realFullscreen: true});
        
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
        //'help': A.catalogHiPS('http://hedam.lam.fr/HELP/dataproducts/dmu31/dmu31_HiPS/data/help_dr1',    
        //                       {onClick: 'showTable', name: 'help_dr1', 
        //                       shape: 'circle', sourceSize: 8, color: '#d66bae'}),
    'gdr2': A.catalogHiPS('http://axel.u-strasbg.fr/HiPSCatService/I/345/gaia2',    
                               {onClick: 'showTable', name: 'Gaia DR2 sources'}),
    'simbad': A.catalogHiPS('http://axel.u-strasbg.fr/HiPSCatService/Simbad', 
                                {onClick: 'showTable', name: 'Simbad'})
};
//table:
//https://herschel-vos.phys.sussex.ac.uk/herschelhelp/q/cone/form?__nevow_form__=genForm&help_id=HELP_J161214.420%2B555305.791&_DBOPTIONS_ORDER=&_DBOPTIONS_DIR=ASC&MAXREC=100&_FORMAT=HTML&submit=Go
//sed:
//https://herschel-vos.phys.sussex.ac.uk/bestseds/q/sdl/dlmeta?ID=ivo%3A//x-unregistred/%7E%3Fbestseds/data/GAMA-09/HELP_J084426.228p012824.790_best_model.fits

//hipsCats['help'].hide();
hipsCats['gdr2'].hide();
hipsCats['simbad'].hide();

    
//aladin.addCatalog(hipsCats['help']);
aladin.addCatalog(hipsCats['gdr2']);
aladin.addCatalog(hipsCats['simbad']);
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
        if (String(object.data.help_id).startsWith('HELP')){
        img = '<div style = "background-color:white; "><img style="max-width:100%; max-height:90%" src="https://herschel-vos.phys.sussex.ac.uk/getproduct/bestseds/data/' + object.data.field.replace('HATLAS-', '') + '/' + object.data.help_id.replace('+', 'p') + '_best_model.fits?preview=True&width=null" alt="CIGALE SED">' + '<a href="https://herschel-vos.phys.sussex.ac.uk/herschelhelp/q/cone/form?__nevow_form__=genForm&help_id=' + object.data.help_id.replace('+', '%2B') +'&_DBOPTIONS_ORDER=&_DBOPTIONS_DIR=ASC&MAXREC=100&_FORMAT=HTML&submit=Go"> Full table.</a>' + '<a href="https://herschel-vos.phys.sussex.ac.uk/bestseds/q/sdl/dlmeta?ID=ivo%3A//x-unregistred/%7E%3Fbestseds/data/' + object.data.field.replace('HATLAS-', '') + '/' + object.data.help_id.replace('+', 'p') + '_best_model.fits"> Full CIGALE data.</a></div>';
        }
    }
    
    
    $('#cigale-div').html(img);
});

