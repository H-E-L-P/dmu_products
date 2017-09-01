# dmu26_XID+MIPS_CDFS-SWIRE
Description:

  XID+ is developed using a probabilistic Bayesian framework which provides
  a natural framework in which to include prior information, and uses the
  Bayesian inference tool Stan to obtain the full posterior probability
  distribution on flux estimates (see Hurley et al. 2017 for more details).

### Prior
  This catalogue uses sources in the masterlist that have a `flag_optnir_det` flag >= 5. For the full processing of the
   prior object list see the Jupyter notebook [XID+MIPS_prior.ipynb](./XID+MIPS_prior.ipynb) 
   

### Running on Apollo

To run on Apollo, first run the notebook [XID+MIPS_prior.ipynb](./XID+MIPS_prior.ipynb) to create the `Master_prior.pkl` and `Tiles.pkl` file. Then generate the
 hierarchical tiles:
 
```bash
mkdir output
mv XID_plus_hier.sh
cd output
module load sge
qsub -t 1-47 -q mps.q -jc mps.short XID_plus_hier.sh
```
Then fit all 9899 tiles. Each tile requires 4 cores, 10GB memory and estimated to run for 4 hours:
```bash
cd ..
qsub -t 1-9899 -pe openmp 4 -l h_rt=4:00:00 -l m_mem_free=10G -q mps.q XID_plus_tile.sh
```
Then combine the Bayesian maps into one:
 ```bash
 python make_combined_map.py
 ```
 This will also pick up any failed tiles and list them in a `failed_tiles.pkl` 
file, which you can then go back and fit by editing the `XIDp_run_script_mips_tile.py` file so it reads in
 `failed_tiles.pkl` rather than `Tiles.pkl`.
  
 To make the final catalogue, I make a list of all the catalogue files and combine them with stilts:
 ```bash
 ls *cat.fits | cat_files
module load starlink/hikianalia-64bit
stilts tcat ifmt=fits in=@cat_files out=dmu26_XID+MIPS_CDFS-SWIRE_cat_20170901.fits
```
 
#### Computation 
 Details on computational cost of fitting CDFS-SWIRE:
 
 APOLLO qacct command not functioning
 

 
### Final data products

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