### dmu26_XID+SPIRE_AKARI-SEP
Description:

  XID+ is developed using a probabilistic Bayesian framework which provides
  a natural framework in which to include prior information, and uses the
  Bayesian inference tool Stan to obtain the full posterior probability
  distribution on flux estimates (see Hurley et al. 2017 for more details).

## AKARI-SEP

### Prior
  This catalogue uses sources in the masterlist that have a `flag_optnir_det` flag >= 5 and have a
   MIPS 24 $\mathrm{\mu m}$ flux >= 10 $\mathrm{\mu Jy}$. For the full processing of the
   prior object list see the Jupyter notebook [XID+SPIRE_prior.ipynb](./XID+SPIRE_prior.ipynb) 
   

### Running on Apollo
To run on Apollo, first run the notebook [XID+SPIRE_prior.ipynb](./XID+SPIRE_prior.ipynb) to create the `Master_prior.pkl` and `Tiles.pkl` file. Then generate the
 hierarchical tiles, where $n_hier_tiles is the number of hierarchical tiles:
```bash
mkdir output
mv XID_plus_hier.sh
cd output
module load sge
qsub -t 1-$n_hier_tiles -q seb_node.q -jc seb_node.short XID_plus_hier.sh
```
Then fit all main tiles, where $n_tiles is the number of main tiles. Each tile requires 4 cores, 13GB memory and estimated to run for 6 hours:
```bash
cd ..
qsub -t 1-$n_tiles -pe openmp 4 -l h_rt=6:00:00 -l m_mem_free=13G -q seb_node.q XID_plus_tile.sh
```
Then combine the Bayesian maps into one:
 ```bash
 python make_combined_map.py
 ```
 This will also pick up any failed tiles and list them in a `failed_tiles.pkl` 
file, which you can then go back and fit by editing the `XIDp_run_script_spire_tile.py` file so it reads in
 `failed_tiles.pkl` rather than `Tiles.pkl`.
  
 To make the final catalogue, I make a list of all the catalogue files and combine them with stilts:
 ```bash
 ls *cat.fits > cat_files
module load stilts
stilts ifmt=fits in=@cat_files out=dmu26_XID+SPIRE_AKARI-SEP_cat.fits
```
 
#### Computation 
 Details on computational cost of fitting AKARI-NEP:
 
 

### Final data products
  Final stage requires examination and validation of catalogues using [XID+SPIRE_AKARI-NEP_final_processing.ipynb](XID+SPIRE_AKARI-NEP_final_processing.ipynb).
  This notebook checks at what flux level the Gaussian approximation to uncertainties is valid and can be treated as a detection. 
  We also add notebooks based on this flux level and the `Pval_res statistic`.

  The resulting marginalised flux probability distributions for each source, are
  described by the 50th, 84th and 16th percentiles. For those wanting to assume
  Gaussian uncertainties, take the maximum of (84th-50th percentile) and
  (50th-16th percentile).


  We note the Gaussian approximation to uncertainties is only valid for sources
  above ~ 4 mJy at 250, ~4 mJy at 350 and 4 at 500mJy:

    
    Column descriptions:

        * help_id                    -  ID
        * RA                   degrees  Right Ascension (J2000)
        * Dec                  degrees  Declination (J2000)
        * F_SPIRE_250              mJy  Flux density at 250 µm (Median)
        * FErr_SPIRE_250_u         mJy  Flux density at 250 µm (84th Percentile)
        * FErr_SPIRE_250_l         mJy  Flux density at 250 µm (16th Percentile)
        * F_SPIRE_350              mJy  Flux density at 350 µm (Median)
        * FErr_SPIRE_350_u         mJy  Flux density at 350 µm (84th Percentile)
        * FErr_SPIRE_350_l         mJy  Flux density at 350 µm (16th Percentile)
        * F_SPIRE_500              mJy  Flux density at 500 µm (Median)
        * FErr_SPIRE_500_u         mJy  Flux density at 500 µm (84th Percentile)
        * FErr_SPIRE_500_l         mJy  Flux density at 500 µm (16th Percentile)
        * Bkg_SPIRE_250       mJy/Beam  Fitted Background of 250 µm map (Median)
        * Bkg_SPIRE_350       mJy/Beam  Fitted Background of 350 µm map (Median)
        * Bkg_SPIRE_500       mJy/Beam  Fitted Background of 500 µm map (Median)
        * Sig_conf_SPIRE_250  mJy/Beam  Fitted residual noise component due to confusion (Median)
        * Sig_conf_SPIRE_350  mJy/Beam  Fitted residual noise component due to confusion (Median)
        * Sig_conf_SPIRE_500  mJy/Beam  Fitted residual noise component due to confusion (Median)
        * Rhat_SPIRE_250             -  Convergence Statistic (ideally <1.2)
        * Rhat_SPIRE_350             -  Convergence Statistic (ideally <1.2)
        * Rhat_SPIRE_500             -  Convergence Statistic (ideally <1.2)
        * n_eff_SPIRE_250            -  Number of effective samples (ideally >40)
        * n_eff_SPIRE_350            -  Number of effective samples (ideally >40)
        * n_eff_SPIRE_500            -  Number of effective samples (ideally >40)
        * Pval_res_250		     -	Local Goodness of fit measure: 0=good, 1=bad
        * Pval_res_350		     -	Local Goodness of fit measure: 0=good, 1=bad
        * Pval_res_500		     -	Local Goodness of fit measure: 0=good, 1=bad
        * flag_spire_250         -  combined flag, 0=good, 1=bad
        * flag_spire_350         -  combined flag, 0=good, 1=bad
        * flag_spire_500         -  combined flag, 0=good, 1=bad
        


Hurley, P.  et al. 2017, MNRAS 464, 885

The research leading to these results has received funding from the Cooperation
Programme (Space) of the European Union’s Seventh Framework Programme
FP7/2007-2013/ under REA grant agreement n° 607254

================================================================================
Herschel Extragalactic Legacy Programme