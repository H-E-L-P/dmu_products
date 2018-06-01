;+
;NAME
; createmap_defparams
;PURPOSE
; Default values for itermap map-maper routines
;-
PRO CREATEMAP_DEFPARAMS, badbolos, excludemask, exname, excludeweightmask
  COMPILE_OPT IDL2, HIDDEN

badbolos = ['PSWD15','PSWC12','PSWG8','PSWG11','PSWA10','PSWA11','PSWA13']

;;"maskVoltageOol" ignored since generally on for PLW
excludemask = ["maskMaster","maskTruncated",$
               "maskUncorrectedTruncation","maskDead",$
               "maskAdcLatch","maskNoRespData","maskTSignalHdv",$
               "maskGlitchL1Detected","maskGlitchL1NotRemoved",$
               "maskGlitchL2Detected","maskGlitchL2NotRemoved",$
               "maskJumpThermistorsDarksSignal",$
               "maskNoThermistorAvailable","maskZeroVelocity",$
               "maskManual","maskSlew","maskNoSMAPThermcorr"]
excludeweightmask = ["maskManualNoParamWeight"]

CALDAT, SYSTIME(/JUL), m, d, y
exname = STRING([y,m,d], FORM='(I04,I02,I02)')

END
