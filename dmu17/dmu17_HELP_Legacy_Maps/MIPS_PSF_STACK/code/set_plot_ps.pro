pro set_plot_ps,file
if not keyword_set(file) then file='idl.ps'

set_plot,'ps'
device,file=file,/col;, /encaps
;colours

!p.thick=5
!x.thick=5
!y.thick=5
!p.charsize=2
!p.charthick=3



end

