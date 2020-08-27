# dmu26_XID+MIPS_Herschel-Stripe-82
**Note**
Given the small number of SEIP-maps available for this field, we decided to use Ldust predictions to run XID+SPIRE. 
 

Description:

  XID+ is developed using a probabilistic Bayesian framework which provides
  a natural framework in which to include prior information, and uses the
  Bayesian inference tool Stan to obtain the full posterior probability
  distribution on flux estimates (see Hurley et al. 2017 for more details).
 

## Herschel-Stripe-82

### Prior
  This catalogue uses sources in the masterlist that have a `flag_optnir_det` flag >= 5. For the full processing of the
   prior object list see the Jupyter notebook [XID+MIPS_prior.ipynb](./XID+MIPS_prior.ipynb) 
   
#### SEIP-Maps
In the case of the mosaic maps see [XID+MIPS_prior_mosaic.py](./XID+MIPS_prior_mosaic.py)

### Running on Apollo

#### SEIP-Maps
   
To run on Apollo, first run the script [XID_plus_priors.sh](./XID_plus_priors.sh). This will create the `Master_prior.pkl` and `Tiles.pkl` file for every SEIP-Map, in separate folders (check [XID+MIPS_prior_mosaic.py](./XID+MIPS_prior_mosaic.py)).

We will also obtained two files with the number of hierarchical tiles and main tiles for each case:
[large_tiles.csv](./data/large_tiles.csv) 
[tiles.csv](./data/tiles.csv) 

Then generate the hierarchical tiles:

```bash
module load sge
python XID_plus_hier.py 
```
This python script will iterate over every folder and submit the job:
qsub -t 1-$n_hier_tiles -q seb_node.q XID_plus_hier.sh
where $n_hier_tiles is the number of hierarchical tiles for each SEIP-Map red from the file [large_tiles.csv].

Then fit all tiles, where $n_tiles is the number of main tiles. 
```bash
python XID_plus_tile.py
```

This python script will iterate over every folder and submit the job:
qsub -t 1-$n_tiles -pe openmp 4 -l h_rt=4:00:00 -l m_mem_free=10G -q mps.q XID_plus_tile.sh
where $n_tiles is the number of main tiles for each SEIP-Map red from the file [tiles.csv]. Each tile requires 4 cores, 10G memory and estimated to run for 4 hours. 


Then combine the Bayesian maps into one:
 ```bash
 python make_combined.py
 ```
 This will call `make_combined_map.py` which pick up any failed tiles and list them in a `failed_tiles.pkl` 
file, which you can then go back and fit by editing the `XIDp_run_script_mips_tile.py` file so it reads in
 `failed_tiles.pkl` rather than `Tiles.pkl`.
  
 To make the final catalogue, I make a list of all the catalogue files and combine them with `make_combined_cat.py`, which creates a list with all cat files in every folder, and uses stilts to join them:
 ```bash
 ls *cat.fits > cat_files
module load stilts
stilts tcat ifmt=fits in=@cat_files out=dmu26_XID+MIPS_Herschel-Stripe-82_cat.fits
```
#### Computation 
# Details on computational cost of fitting Herschel-Stripe-82:

 
### Final data products

  Final stage requires examination and validation of catalogues using [XID+MIPS_Herschel-Stripe-82_final_processing.ipynb](XID+MIPS_Herschel-Stripe-82_final_processing.ipynb).
  This notebook checks at what flux level the Gaussian approximation to uncertainties is valid and can be treated as a detection. 
  We also add notebooks based on this flux level and the `Pval_res statistic`.

  The resulting marginalised flux probability distributions for each source, are
  described by the 50th, 84th and 16th percentiles. For those wanting to assume
  Gaussian uncertainties, take the maximum of (84th-50th percentile) and
  (50th-16th percentile).


  We note the Gaussian approximation to uncertainties is only valid for sources
  above ~ 20 uJy at 24 µm:

    
    Column descriptions:

      * help_id                    -  ID
      * RA                   degrees  Right Ascension (J2000)
      * Dec                  degrees  Declination (J2000)
      * F_MIPS_24               uJy  Flux density at 24 µm (Median)
      * FErr_MIPS_24_u          uJy  Flux density at 24 µm (84th Percentile)
      * FErr_MIPS_24_l          uJy  Flux density at 250 µm (16th Percentile)
      * Bkg_MIPS_24           MJy/Sr  Fitted Background of 23 µm map (Median)
      * Sig_conf_MIPS_24      MJy/Sr  fixed at 0
      * Rhat_MIPS_24             -  Convergence Statistic (ideally <1.2)
      * n_eff_MIPS_24            -  Number of effective samples (ideally >40)
      * Pval_res_MIPS_24               -  Local Goodness of fit measure: 0=good, 1=bad
      * flag_mips_24         -  combined flag, 0=good, 1=bad


Hurley, P.  et al. 2017, MNRAS 464, 885

The research leading to these results has received funding from the Cooperation
Programme (Space) of the European Union’s Seventh Framework Programme
FP7/2007-2013/ under REA grant agreement n° 607254

================================================================================
Herschel Extragalactic Legacy Programme