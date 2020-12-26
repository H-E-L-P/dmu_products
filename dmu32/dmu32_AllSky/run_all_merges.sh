#!/bin/bash
jupyter nbconvert --to notebook --execute --ExecutePreprocessor.timeout=-1 ../dmu32_AKARI-NEP/AKARI-NEP_catalogue_merging.ipynb --ExecutePreprocessor.kernel_name=helpint
jupyter nbconvert --to notebook --execute --ExecutePreprocessor.timeout=-1 ../dmu32_AKARI-SEP/AKARI-SEP_catalogue_merging.ipynb --ExecutePreprocessor.kernel_name=helpint
jupyter nbconvert --to notebook --execute --ExecutePreprocessor.timeout=-1 ../dmu32_Bootes/Bootes_catalogue_merging.ipynb --ExecutePreprocessor.kernel_name=helpint
jupyter nbconvert --to notebook --execute --ExecutePreprocessor.timeout=-1 ../dmu32_CDFS-SWIRE/CDFS-SWIRE_catalogue_merging.ipynb --ExecutePreprocessor.kernel_name=helpint
jupyter nbconvert --to notebook --execute --ExecutePreprocessor.timeout=-1 ../dmu32_COSMOS/COSMOS_catalogue_merging.ipynb --ExecutePreprocessor.kernel_name=helpint
jupyter nbconvert --to notebook --execute --ExecutePreprocessor.timeout=-1 ../dmu32_EGS/EGS_catalogue_merging.ipynb --ExecutePreprocessor.kernel_name=helpint
jupyter nbconvert --to notebook --execute --ExecutePreprocessor.timeout=-1 ../dmu32_ELAIS-N1/ELAIS-N1_catalogue_merging.ipynb --ExecutePreprocessor.kernel_name=helpint
jupyter nbconvert --to notebook --execute --ExecutePreprocessor.timeout=-1 ../dmu32_ELAIS-N2/ELAIS-N2_catalogue_merging.ipynb --ExecutePreprocessor.kernel_name=helpint
jupyter nbconvert --to notebook --execute --ExecutePreprocessor.timeout=-1 ../dmu32_ELAIS-S1/ELAIS-S1_catalogue_merging.ipynb --ExecutePreprocessor.kernel_name=helpint
jupyter nbconvert --to notebook --execute --ExecutePreprocessor.timeout=-1 ../dmu32_GAMA-09/GAMA-09_catalogue_merging.ipynb --ExecutePreprocessor.kernel_name=helpint
jupyter nbconvert --to notebook --execute --ExecutePreprocessor.timeout=-1 ../dmu32_GAMA-12/GAMA-12_catalogue_merging.ipynb --ExecutePreprocessor.kernel_name=helpint
jupyter nbconvert --to notebook --execute --ExecutePreprocessor.timeout=-1 ../dmu32_GAMA-15/GAMA-15_catalogue_merging.ipynb --ExecutePreprocessor.kernel_name=helpint
jupyter nbconvert --to notebook --execute --ExecutePreprocessor.timeout=-1 ../dmu32_HDF-N/HDF-N_catalogue_merging.ipynb --ExecutePreprocessor.kernel_name=helpint

jupyter nbconvert --to notebook --execute --ExecutePreprocessor.timeout=-1 ../dmu32_Herschel-Stripe-82/Herschel-Stripe-82_catalogue_merging.ipynb --ExecutePreprocessor.kernel_name=helpint

jupyter nbconvert --to notebook --execute --ExecutePreprocessor.timeout=-1 ../dmu32_Lockman-SWIRE/Lockman-SWIRE_catalogue_merging.ipynb --ExecutePreprocessor.kernel_name=helpint
jupyter nbconvert --to notebook --execute --ExecutePreprocessor.timeout=-1 ../dmu32_NGP/NGP_catalogue_merging.ipynb --ExecutePreprocessor.kernel_name=helpint
jupyter nbconvert --to notebook --execute --ExecutePreprocessor.timeout=-1 ../dmu32_SA13/SA13_catalogue_merging.ipynb --ExecutePreprocessor.kernel_name=helpint

jupyter nbconvert --to notebook --execute --ExecutePreprocessor.timeout=-1 ../dmu32_SGP/SGP_catalogue_merging.ipynb --ExecutePreprocessor.kernel_name=helpint

jupyter nbconvert --to notebook --execute --ExecutePreprocessor.timeout=-1 ../dmu32_SPIRE-NEP/SPIRE-NEP_catalogue_merging.ipynb --ExecutePreprocessor.kernel_name=helpint
jupyter nbconvert --to notebook --execute --ExecutePreprocessor.timeout=-1 ../dmu32_SSDF/SSDF_catalogue_merging.ipynb --ExecutePreprocessor.kernel_name=helpint
jupyter nbconvert --to notebook --execute --ExecutePreprocessor.timeout=-1 ../dmu32_xFLS/xFLS_catalogue_merging.ipynb --ExecutePreprocessor.kernel_name=helpint
jupyter nbconvert --to notebook --execute --ExecutePreprocessor.timeout=-1 ../dmu32_XMM-13hr/XMM-13hr_catalogue_merging.ipynb --ExecutePreprocessor.kernel_name=helpint

jupyter nbconvert --to notebook --execute --ExecutePreprocessor.timeout=-1 ../dmu32_XMM-LSS/XMM-LSS_catalogue_merging.ipynb --ExecutePreprocessor.kernel_name=helpint

cd ../dmu32_Herschel-Stripe-82/
stilts tcat in=@./data/tiles/fits_list_Herschel-Stripe-82_20180307.lis out=./data/Herschel-Stripe-82_20180307.fits
cd ../dmu32_SGP
stilts tcat in=@./data/tiles/fits_list_sgp_20180221.lis out=./data/SGP_20180221.fits
cd ../dmu32_XMM-LSS
stilts tcat in=@./data/tiles/fits_list_20190328.lis out=./data/XMM-LSS_20190328.fits


