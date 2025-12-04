# Generic Function for Multiple Graphs in a K-tables Analysis

Methods for `foucart`, `mcoa`, `mfa`, `pta`, `sepan`, `sepan.coa` and
`statis`

## Usage

``` r
kplot(object, ...)
```

## Arguments

- object:

  an object used to select a method

- ...:

  further arguments passed to or from other methods

## Examples

``` r
methods(plot)
#>   [1] plot,ADEg,ANY-method                      
#>   [2] plot,ADEgS,ANY-method                     
#>   [3] plot,ANY,ANY-method                       
#>   [4] plot,Spatial,missing-method               
#>   [5] plot,SpatialGrid,missing-method           
#>   [6] plot,SpatialGridDataFrame,missing-method  
#>   [7] plot,SpatialLines,missing-method          
#>   [8] plot,SpatialMultiPoints,missing-method    
#>   [9] plot,SpatialPixels,missing-method         
#>  [10] plot,SpatialPixelsDataFrame,missing-method
#>  [11] plot,SpatialPoints,missing-method         
#>  [12] plot,SpatialPolygons,missing-method       
#>  [13] plot,color,ANY-method                     
#>  [14] plot,genlight,ANY-method                  
#>  [15] plot,phylo4,missing-method                
#>  [16] plot,pixmap,ANY-method                    
#>  [17] plot.4thcorner*                           
#>  [18] plot.ACF*                                 
#>  [19] plot.Gabriel*                             
#>  [20] plot.HoltWinters*                         
#>  [21] plot.MOStest*                             
#>  [22] plot.R6*                                  
#>  [23] plot.SOM*                                 
#>  [24] plot.SeqAcnucWeb*                         
#>  [25] plot.TBI*                                 
#>  [26] plot.TukeyHSD*                            
#>  [27] plot.Variogram*                           
#>  [28] plot.WRperio*                             
#>  [29] plot.acf*                                 
#>  [30] plot.acm*                                 
#>  [31] plot.agnes*                               
#>  [32] plot.anosim*                              
#>  [33] plot.augPred*                             
#>  [34] plot.bcaloocv*                            
#>  [35] plot.bclust*                              
#>  [36] plot.betadisper*                          
#>  [37] plot.betadiver*                           
#>  [38] plot.betcoi*                              
#>  [39] plot.betdpcoa*                            
#>  [40] plot.betrlq*                              
#>  [41] plot.between*                             
#>  [42] plot.betwitdpcoa*                         
#>  [43] plot.boot*                                
#>  [44] plot.cascadeKM*                           
#>  [45] plot.cca*                                 
#>  [46] plot.clamtest*                            
#>  [47] plot.classIntervals*                      
#>  [48] plot.clusGap*                             
#>  [49] plot.cohesiveBlocks*                      
#>  [50] plot.coinertia*                           
#>  [51] plot.communities*                         
#>  [52] plot.compareFits*                         
#>  [53] plot.constr.hclust*                       
#>  [54] plot.contribdiv*                          
#>  [55] plot.corkdist*                            
#>  [56] plot.correlogram*                         
#>  [57] plot.correlogramList*                     
#>  [58] plot.correspondence*                      
#>  [59] plot.data.frame*                          
#>  [60] plot.decomposed.ts*                       
#>  [61] plot.decorana*                            
#>  [62] plot.default                              
#>  [63] plot.deldir*                              
#>  [64] plot.dendrogram*                          
#>  [65] plot.density*                             
#>  [66] plot.diana*                               
#>  [67] plot.discloocv*                           
#>  [68] plot.discrimin*                           
#>  [69] plot.divchain*                            
#>  [70] plot.dpcaiv*                              
#>  [71] plot.dpcoa*                               
#>  [72] plot.ecdf                                 
#>  [73] plot.envfit*                              
#>  [74] plot.evonet*                              
#>  [75] plot.factor*                              
#>  [76] plot.fca*                                 
#>  [77] plot.fisher*                              
#>  [78] plot.fisherfit*                           
#>  [79] plot.fitspecaccum*                        
#>  [80] plot.formula*                             
#>  [81] plot.foucart*                             
#>  [82] plot.function                             
#>  [83] plot.gam*                                 
#>  [84] plot.ggplot2::ggplot*                     
#>  [85] plot.gls*                                 
#>  [86] plot.gtable*                              
#>  [87] plot.haploGen*                            
#>  [88] plot.hclust*                              
#>  [89] plot.histogram*                           
#>  [90] plot.ica*                                 
#>  [91] plot.igraph*                              
#>  [92] plot.inertia*                             
#>  [93] plot.intervals.lmList*                    
#>  [94] plot.isomap*                              
#>  [95] plot.isoreg*                              
#>  [96] plot.jam*                                 
#>  [97] plot.khat*                                
#>  [98] plot.krandboot*                           
#>  [99] plot.krandtest*                           
#> [100] plot.krandxval*                           
#> [101] plot.lda*                                 
#> [102] plot.listw*                               
#> [103] plot.lm*                                  
#> [104] plot.lmList*                              
#> [105] plot.lme*                                 
#> [106] plot.mantel.correlog*                     
#> [107] plot.mc.sim*                              
#> [108] plot.mca*                                 
#> [109] plot.mcoa*                                
#> [110] plot.meandist*                            
#> [111] plot.medpolish*                           
#> [112] plot.metaMDS*                             
#> [113] plot.mfa*                                 
#> [114] plot.mfpa*                                
#> [115] plot.mlm*                                 
#> [116] plot.mona*                                
#> [117] plot.monmonier*                           
#> [118] plot.monoMDS*                             
#> [119] plot.mst*                                 
#> [120] plot.multiPhylo*                          
#> [121] plot.multiblock*                          
#> [122] plot.multispati*                          
#> [123] plot.nb*                                  
#> [124] plot.nestednodf*                          
#> [125] plot.nestedtemp*                          
#> [126] plot.nffGroupedData*                      
#> [127] plot.nfnGroupedData*                      
#> [128] plot.niche*                               
#> [129] plot.nls*                                 
#> [130] plot.nmGroupedData*                       
#> [131] plot.ordipointlabel*                      
#> [132] plot.ordisurf*                            
#> [133] plot.orthobasis*                          
#> [134] plot.orthobasisSp*                        
#> [135] plot.pal_continuous*                      
#> [136] plot.pal_discrete*                        
#> [137] plot.partition*                           
#> [138] plot.pcaiv*                               
#> [139] plot.pdMat*                               
#> [140] plot.permat*                              
#> [141] plot.phylo*                               
#> [142] plot.phylog*                              
#> [143] plot.phymltest*                           
#> [144] plot.poolaccum*                           
#> [145] plot.popsize*                             
#> [146] plot.ppca*                                
#> [147] plot.ppr*                                 
#> [148] plot.prc*                                 
#> [149] plot.prcomp*                              
#> [150] plot.preston*                             
#> [151] plot.prestonfit*                          
#> [152] plot.princomp*                            
#> [153] plot.procrustes*                          
#> [154] plot.procuste*                            
#> [155] plot.profile*                             
#> [156] plot.profile.nls*                         
#> [157] plot.prop.part*                           
#> [158] plot.pta*                                 
#> [159] plot.rad*                                 
#> [160] plot.radfit*                              
#> [161] plot.radfit.frame*                        
#> [162] plot.radline*                             
#> [163] plot.randboot*                            
#> [164] plot.randtest*                            
#> [165] plot.randxval*                            
#> [166] plot.ranef.lmList*                        
#> [167] plot.ranef.lme*                           
#> [168] plot.raster*                              
#> [169] plot.rda*                                 
#> [170] plot.relative*                            
#> [171] plot.renyi*                               
#> [172] plot.renyiaccum*                          
#> [173] plot.ridgelm*                             
#> [174] plot.rlq*                                 
#> [175] plot.s2_cell*                             
#> [176] plot.s2_cell_union*                       
#> [177] plot.s2_geography*                        
#> [178] plot.scalogram*                           
#> [179] plot.sepan*                               
#> [180] plot.seqTrack*                            
#> [181] plot.sf*                                  
#> [182] plot.sfc_CIRCULARSTRING*                  
#> [183] plot.sfc_GEOMETRY*                        
#> [184] plot.sfc_GEOMETRYCOLLECTION*              
#> [185] plot.sfc_LINESTRING*                      
#> [186] plot.sfc_MULTILINESTRING*                 
#> [187] plot.sfc_MULTIPOINT*                      
#> [188] plot.sfc_MULTIPOLYGON*                    
#> [189] plot.sfc_POINT*                           
#> [190] plot.sfc_POLYGON*                         
#> [191] plot.sfg*                                 
#> [192] plot.shingle*                             
#> [193] plot.silhouette*                          
#> [194] plot.simulate.lme*                        
#> [195] plot.sir*                                 
#> [196] plot.skater*                              
#> [197] plot.skyline*                             
#> [198] plot.somgrid*                             
#> [199] plot.spantree*                            
#> [200] plot.spca*                                
#> [201] plot.spcor*                               
#> [202] plot.spec*                                
#> [203] plot.specaccum*                           
#> [204] plot.spline*                              
#> [205] plot.statis*                              
#> [206] plot.stepfun                              
#> [207] plot.stft*                                
#> [208] plot.stl*                                 
#> [209] plot.svm*                                 
#> [210] plot.table*                               
#> [211] plot.taxondive*                           
#> [212] plot.tile.list*                           
#> [213] plot.transform*                           
#> [214] plot.trellis*                             
#> [215] plot.triSht*                              
#> [216] plot.triang.list*                         
#> [217] plot.ts                                   
#> [218] plot.tskernel*                            
#> [219] plot.tune*                                
#> [220] plot.units*                               
#> [221] plot.varcomp*                             
#> [222] plot.varpart*                             
#> [223] plot.varpart234*                          
#> [224] plot.voronoi*                             
#> [225] plot.voronoi.polygons*                    
#> [226] plot.wcmdscale*                           
#> [227] plot.witcoi*                              
#> [228] plot.witdpcoa*                            
#> [229] plot.within*                              
#> [230] plot.witrlq*                              
#> [231] plot.wk_crc*                              
#> [232] plot.wk_grd_rct*                          
#> [233] plot.wk_grd_xy*                           
#> [234] plot.wk_rct*                              
#> [235] plot.wk_wkb*                              
#> [236] plot.wk_wkt*                              
#> [237] plot.wk_xy*                               
#> [238] plot.xyVector*                            
#> see '?methods' for accessing help and source code
methods(scatter)
#>  [1] scatter.acm*    scatter.coa*    scatter.dapc*   scatter.dudi*  
#>  [5] scatter.fca*    scatter.glPca*  scatter.mspa*   scatter.nipals*
#>  [9] scatter.pco*    scatter.ppca*   scatter.smooth 
#> see '?methods' for accessing help and source code
methods(kplot)
#> [1] kplot.foucart* kplot.mbpcaiv* kplot.mcoa*    kplot.mfa*     kplot.pta*    
#> [6] kplot.sepan*   kplot.statis* 
#> see '?methods' for accessing help and source code
```
