#!/usr/bin/perl

my ($SMID, $REGID) = @ARGV;

#$SMID = "70101860";  #get this from the table
#$REGID = "70101860-0";  #get this from the table
$instrument = "MIPS";  #get this from table if you also want IRAC
$ch = "1";  #get this from table if you also want MIPS 70/160

#$SMID = "40044260";  #get this from the table
#$REGID = "40044260-0";  #get this from the table
$instrument = "MIPS";  #get this from table if you also want IRAC
$ch = "1";  #get this from table if you also want MIPS 70/160


if($ch <=1){
    $URLbase="https://irsa.ipac.caltech.edu/data/SPITZER/Enhanced/SEIP/images/";
}else{
    $URLbase="https://irsa.ipac.caltech.edu/data/SPITZER/SAFIRES/images/";
}

@filetypes = ("mosaic","unc","cov","std","median_mosaic","median_mosaic_unc","brightmask","extmask");

foreach $file (@filetypes){
    $filename = $SMID . "." . $REGID . "." . $instrument . "." . $ch . "." . $file . ".fits";
    $url = $URLbase . outdir($REGID) . $filename;
    printf STDOUT "wget -a log -nc -P data %s\n",$url;
}

sub outdir {
    
    my ($d1,$d2,$d3,$d4,$dir,$rdir);
    
    $rdir=$_[0];
    $rdir=~ s/-short//g;
    
    $d1 = substr($rdir,0,1);
    $d2 = substr($rdir,1,4);
    $d3 = substr($rdir,0,8);
    $d4 = substr($rdir,-1,1);
    
    $dir = $d1 . "/" . $d2 . "/" . $d3 . "/" . $d4 . "/" . $rdir . "/";
    return($dir);
}
