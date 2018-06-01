#!/usr/bin/env python

import random

"""Program to try to optimize the fields so that each of the
four subgroups takes about the same total amount of disk space.
This is a combinatorically hard problem, with about 100 quadrillion
combinations for 32 fields sorted into four groups (32!/8!^4), so the 
code just tries a million shuffles and takes the best one.
"""

def maxdiff(values,nsets=4) :
    sz = [ val[1] for val in values ]
    sizes = [ sum( sz[i::nsets] ) for i in range(nsets) ]
    return max(sizes) - min(sizes)
    

nsets = 5

#this was done by hand;  it would be better to be smarter and
# write something to read the conf files to find the data directory
# and re-check, but meh.
sizedict = {}
sizedict['abell0370'] = 863803
sizedict['abell1689'] = 863805
sizedict['abell1835'] = 863803
sizedict['abell2218'] = 4494435
sizedict['abell2219'] = 863786
sizedict['abell2390'] = 863785
sizedict['adfs']      = 4389281
sizedict['bootes']    = 11855419
sizedict['cl0024']    = 863805
sizedict['cdfs-swire']= 19140740
sizedict['cdfs-swire3']= 8242720
sizedict['cosmos']    = 7605383
sizedict['cosmos2']   = 17574393
sizedict['ecdfs']     = 3530847
sizedict['egroth']    = 1400549
sizedict['egs-scuba'] = 2357124
sizedict['elais-n1']  = 5060531
sizedict['elais-n1-new-ivan'] = 4533418
sizedict['elais-n2']  = 2164234
sizedict['elais-n2-swire2'] = 1331201
sizedict['elais-s1']  = 4474759
sizedict['fls']       = 4066352
sizedict['global-epicentre']=1284586
sizedict['goodsn']    = 6429906
sizedict['goodsn-gh'] = 8657369
sizedict['goodss']    = 7815193
sizedict['lockman-east'] = 1300771
sizedict['lockman-north'] = 1832729
sizedict['lockman-swire'] = 6118117
sizedict['lockman-swire3'] = 12212749
sizedict['ms0451']    = 863786
sizedict['ms1054']    = 795046
sizedict['ms1358']    = 863786
sizedict['rxj0152']   = 795062
sizedict['rxj1347']   = 863806
sizedict['s1-video']  = 1091592
sizedict['uds']       = 4744795
sizedict['video-xmm1']= 2121749
sizedict['video-xmm2']= 1372668
sizedict['video-xmm3']= 2127260
sizedict['vvds']      = 4744801
sizedict['xmm-lss']   = 11149850

sizes = list(zip( sizedict.keys(), sizedict.values() ))

currmin = sizes[:]
bestdiff = maxdiff(sizes,nsets=nsets)
for i in range(4000000) :
    random.shuffle(sizes)
    currdiff = maxdiff(sizes,nsets=nsets)
    if currdiff < bestdiff :
        bestdiff = currdiff
        currmin = sizes[:]
    
print( "Best size difference: %dk" % bestdiff )

setdict = {}
for i in range(nsets) :
    vals = currmin[i::nsets]
    keys = [ val[0] for val in vals ]
    for key in keys :
        setdict[key] = i


for key in sorted(setdict) :
    print('\t{f: "%s",\ts: %d},' % (key,setdict[key]) )
