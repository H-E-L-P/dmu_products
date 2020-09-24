### dmu26_XID+SPIRE_HS82
**Note**
Given the small number of SEIP-maps available for this field, we decided to use Ldust priors to run XID+SPIRE. For next releases we will make available SPIRE data using IRAC priors. 

Description:

  XID+ is developed using a probabilistic Bayesian framework which provides
  a natural framework in which to include prior information, and uses the
  Bayesian inference tool Stan to obtain the full posterior probability
  distribution on flux estimates (see Hurley et al. 2017 for more details).


### Prior
  This catalogue uses sources in the masterlist that have a `flag_optnir_det` flag >= 5, have a $L_dust$ prediction 
  from CIGALE and photometric redshift and have a resulting 250-flux prediction above 5mJy. For the full processing of the prior object list see the Jupyter notebook [XID+SPIRE_prior-Ldust.ipynb](./XID+SPIRE_prior-Ldust.ipynb) 
   

### Running on Apollo

To run on Apollo, first run the python file [XID+SPIRE_prior_cutout.py](./XID+SPIRE_prior_cutout.py) to create the `Master_prior.pkl` and `Tiles.pkl` file for each cutout (we have divided the map into 4 cutouts, due to memory errors). Then generate the hierarchical tiles, where #n_hier_tiles is the number of hierarchical tiles:

```bash
module load sge
python XID_plus_hier.py
```

This script will submit, for each cutout:
qsub -t 1-%s -l m_mem_free=20G -q seb_node.q XID_plus_hier.sh

Then fit all main tiles, where #n_tiles is the number of main tiles. Each tile requires 4 cores, 20GB memory and estimated to run for 6 hours:
```bash
python XID_plus_tile.py
```
This script will submit, for each cutout:
qsub -t 1-#n_tiles -pe openmp 4 -l h_rt=6:00:00 -l m_mem_free=20G -q seb_node.q XID_plus_tile.sh

The file [make_combined.py](./make_combined.py) will be used to combine the Bayesian maps into one:
 ```bash
 python make_combined_map.py
 ```
 This will also pick up any failed tiles and list them in a `failed_tiles.pkl` 
file, which you can then go back and fit by editing the `XIDp_run_script_spire_tile.py` file so it reads in
 `failed_tiles.pkl` rather than `Tiles.pkl`.
  
make_combined.py can also be used to make the final catalogue, by calling the file [make_combined_cat.py](./make_combined_cat.py), which makes a list of all the catalogue files and combine them with stilts:
 ```bash
 module load stilts
 ls *cat.fits > cat_files
stilts tcat ifmt=fits in=@cat_files out=dmu26_XID+SPIRE_HS82_cat.fits
```
 
#### Computation 
 Details on computational cost of fitting HS82:
 

 ```bash
NOT AVAILABLE
``` 
 
 

### Final data products
  Final stage requires examination and validation of catalogues using [XID+SPIRE_HS82_final_processing.ipynb](XID+SPIRE_HS82_final_processing.ipynb).
  This notebook checks at what flux level the Gaussian approximation to uncertainties is valid and can be treated as a detection. 
  We also add notebooks based on this flux level and the `Pval_res statistic`.

  The resulting marginalised flux probability distributions for each source, are
  described by the 50th, 84th and 16th percentiles. For those wanting to assume
  Gaussian uncertainties, take the maximum of (84th-50th percentile) and
  (50th-16th percentile).


  We note the Gaussian approximation to uncertainties is only valid for sources
  above ~ 4 mJy at 250, ~6 mJy at 350 and 10 at 500mJy:

    
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


