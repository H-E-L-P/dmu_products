# ![HELP LOGO](https://avatars1.githubusercontent.com/u/7880370?s=75&v=4) HELP Template Files (dmu12) LOFAR masterlist crossmatching

Contains code that implements a modified version of the likelihood ratio code from https://github.com/nudomarinero/mltier1 to crossmatch LOFAR catalogues to the masterlist.

## Folder structure
The notebook radio_masterlist_liklihood_ratio_crossmatch.ipynb provides a detailed description of the likelihood ratio method used in the crossmatching as well as some diagnostic and validation plots. It uses function from Q0_calc.py and mltier.py. The likelihood_ratio.py is the same code as the notebook but written as a function that can be called in other notebooks without producing all the diagnostic plots.