;;This is a template IDL startup file.

;;You will need to edit this to reflect your directory structure --
;; where you keep your data, and where you keep your code.

;;Once you edit it (and add any extra things you want), you should
;; save it by another name (for example: as ~/.idl_setup.pro).
;;Then you need to set the environment variable IDL_STARTUP to point
;; to the edited file.
;;So, if you edit and name it ~/.idl_setup.pro then you want to
;; add a line like
;;
;;export IDL_STARTUP=~/.idl_setup.pro
;;
;; to your login script (assuming you use bash shell -- for others,
;; substitute the apropriate way to set environment variables 
;; In tcsh this would be 
;;    setenv IDL_STARTUP ~/.idl_setup.pro


;;First, you need to define the path where you store SPIRE data
;; This is an example.  Make sure it ends in the path seperator!
defsysv,'!SMAP_DATA',getenv('GITHUB')+'/dmu_products/dmu19/dmu19_timelines/data/'
;; Now let's define the path to SPIRE source catalogs
defsysv,'!SMAP_CATS',getenv('GITHUB_DIR')+'/dmu_products/dmu19/dmu19_timelines/data/cats/'
;; and finally the path to SPIRE maps
defsysv,'!SMAP_MAPS',getenv('GITHUB_DIR')+'/dmu_products/dmu19/dmu19_timelines/data/maps/'
;; (note these three don't all have to be in different places if
;; that's not what you want)

;;Next, you need to define the base path to where you put the SVN
;; repository -- this should be the absolute path to the smap_pipeline
;; directory
defsysv,'!SMAP_PIPELINE_PATH',getenv('GITHUB_DIR')+'/smaproot/smap_pipeline/'


