pro pix_scale,hd,scale
extast, hd, ast

 scale1 = abs(ast.cdelt[0])
 scale2 = abs(ast.cdelt[1])
crpix1=sxpar(hd,'crpix1')
crpix2=sxpar(hd,'crpix2')

 IF (scale1-scale2)/scale1 GT 0.01 THEN message, 'ERROR pixel scales do not match'
 scale = sqrt(scale1^2+scale2^2)/sqrt(2.)

 x = crpix1-0.5+[0, 1]
 y = crpix2-0.5+[0, 1]
 icxy2ad, x, y, hd, a, d
 gcirc, 1, a[1]/15., d[1], a[0]/15., d[0], dis
 scale = dis/3600./sqrt(2.)

end
