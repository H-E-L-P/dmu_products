### dmu26_XID+PACS_ELAIS-N1
Description:

  XID+ is developed using a probabilistic Bayesian framework which provides
  a natural framework in which to include prior information, and uses the
  Bayesian inference tool Stan to obtain the full posterior probability
  distribution on flux estimates (see Hurley et al. 2017 for more details).

ELAIS-N1 was split into two regions, defined by the IRAC coverage. The deep region is defined by the SERVS survey,
 the shallow region by the remaining SWIRE region.
 
## SERVS

### Prior
  This catalogue uses sources in the masterlist that have a `flag_optnir_det` flag >= 5 and have a
   MIPS 24 $\mathrm{\mu m}$ flux >= 20 $\mathrm{\mu Jy}$. For the full processing of the
   prior object list see the Jupyter notebook [XID+PACS_prior_SERVS.ipynb](./XID+PACS_prior_SERVS.ipynb) and 
   

### Running on Apollo
To run on Apollo, first run the notebook [XID+PACS_prior_SERVS.ipynb](./XID+PACS_prior_SERVS.ipynb) to create the `Master_prior.pkl` and `Tiles.pkl` file. Then generate the
 hierarchical tiles:
```bash
mkdir output
mv XID_plus_hier.sh
cd output
module load sge
qsub -t 1-n_hier_tiles -q mps.q -jc mps.short XID_plus_hier.sh
```
Then fit all tiles. Each tile requires 4 cores, 13G memory and estimated to run for 4 hours:
```bash
cd ..
qsub -t 1-n_tiles -pe openmp 4 -l h_rt=4:00:00 -l m_mem_free=13G -q mps.q XID_plus_tile.sh
```
Then combine the Bayesian maps into one:
 ```bash
 python make_combined_map.py
 ```
 This will also pick up any failed tiles and list them in a `failed_tiles.pkl` 
file, which you can then go back and fit by editing the `XIDp_run_script_pacs_tile.py` file so it reads in
 `failed_tiles.pkl` rather than `Tiles.pkl`.
  
 To make the final catalogue, I make a list of all the catalogue files and combine them with stilts:
 ```bash
 ls *cat.fits | cat_files
module load starlink/hikianalia-64bit
stilts ifmt=fits in=@cat_files out=dmu26_XID+PACS_ELAIS-N1_cat.fits
```
 
#### Computation 
 Details on computational cost of fitting ELAIS-N1:
 
 SERVS:
```qacct failed on apollo: cannot report statistics```
 
 
## SWIRE (-SERVS)

### Prior
  This catalogue uses sources in the masterlist that have a `flag_optnir_det` flag >= 5 and have a
   MIPS 24 $\mathrm{\mu m}$ flux >= 20 $\mathrm{\mu Jy}$. For the full processing of the
   prior object list see the Jupyter notebook [XID+PACS_prior_SWIRE.ipynb](./XID+PACS_prior_SWIRE.ipynb) and 
   

### Running on Apollo
To run on Apollo, first run the notebook [XID+PACS_prior_SWIRE.ipynb](./XID+PACS_prior_SWIRE.ipynb) to create the `Master_prior.pkl` and `Tiles.pkl` file. Then generate the
 hierarchical tiles:
```bash
mkdir output
mv XID_plus_hier.sh
cd output
module load sge
qsub -t 1-n_hier_tiles -q mps.q -jc mps.short XID_plus_hier.sh
```
Then fit all tiles. Each tile requires 4 cores, 13G memory and estimated to run for 4 hours:
```bash
cd ..
qsub -t 1-n_tiles -pe openmp 4 -l h_rt=4:00:00 -l m_mem_free=13G -q mps.q XID_plus_tile.sh
```
Then combine the Bayesian maps into one:
 ```bash
 python make_combined_map.py
 ```
 This will also pick up any failed tiles and list them in a `failed_tiles.pkl` 
file, which you can then go back and fit by editing the `XIDp_run_script_pacs_tile.py` file so it reads in
 `failed_tiles.pkl` rather than `Tiles.pkl`.
  
 To make the final catalogue, I make a list of all the catalogue files and combine them with stilts:
 ```bash
 ls *cat.fits | cat_files
module load starlink/hikianalia-64bit
stilts ifmt=fits in=@cat_files out=dmu26_XID+PACS_ELAIS-N1_cat.fits
```
 
#### Computation 
 Details on computational cost of fitting ELAIS-N1:

````bash
 OWNER     WALLCLOCK         UTIME         STIME           CPU             MEMORY                 IO                IOW
======================================================================================================================
pdh21      17055281  59784320.915     69961.341  59854282.790       37406648.330           1784.232              0.000
```


### Final data products

  The resulting marginalised flux probability distributions for each source, are
  described by the 50th, 84th and 16th percentiles. For those wanting to assume
  Gaussian uncertainties, take the maximum of (84th-50th percentile) and
  (50th-16th percentile).



    
    Column descriptions:

        * help_id                    -  ID
        * RA                   degrees  Right Ascension (J2000)
        * Dec                  degrees  Declination (J2000)
        * F_PACS_100              mJy  Flux density at 100 µm (Median)
        * FErr_PACS_100_u         mJy  Flux density at 100 µm (84th Percentile)
        * FErr_PACS_100_l         mJy  Flux density at 100 µm (16th Percentile)
        * F_PACS_160              mJy  Flux density at 160 µm (Median)
        * FErr_PACS_160_u         mJy  Flux density at 160 µm (84th Percentile)
        * FErr_PACS_160_l         mJy  Flux density at 160 µm (16th Percentile)
        * Bkg_PACS_100       MJy/Pixel  Fitted Background of 100 µm map (Median)
        * Bkg_PACS_160       MJy/Pixel  Fitted Background of 160 µm map (Median)
        * Sig_conf_PACS_100  MJy/Pixel  Fitted residual noise component due to confusion (Median)
        * Sig_conf_PACS_160 MJy/Pixel  Fitted residual noise component due to confusion (Median)
        * Rhat_PACS_100             -  Convergence Statistic (ideally <1.2)
        * Rhat_PACS_160             -  Convergence Statistic (ideally <1.2)
        * n_eff_PACS_100            -  Number of effective samples (ideally >40)
        * n_eff_PACS_160            -  Number of effective samples (ideally >40)
        * Pval_res_100		     -	Local Goodness of fit measure: 0=good, 1=bad
        * Pval_res_160		     -	Local Goodness of fit measure: 0=good, 1=bad
        * flag_pacs_100         -  combined flag, 0=good, 1=bad
        * flag_pacs_160         -  combined flag, 0=good, 1=bad        


Hurley, P.  et al. 2017, MNRAS 464, 885

The research leading to these results has received funding from the Cooperation
Programme (Space) of the European Union’s Seventh Framework Programme
FP7/2007-2013/ under REA grant agreement n° 607254

================================================================================
Herschel Extragalactic Legacy Programme