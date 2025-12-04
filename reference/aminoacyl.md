# Codon usage

`aminoacyl` is a list containing the codon counts of 36 genes encoding
yeast aminoacyl-tRNA-synthetase(S.Cerevisiae).

## Usage

``` r
data(aminoacyl)
```

## Format

`aminoacyl` is a list containing the 5 following objects:

- genes:

  is a vector giving the gene names.

- localisation:

  is a vector giving the cellular localisation of the proteins (M =
  mitochondrial, C = cytoplasmic, I = indetermined, CI = cyto and mito).

- codon:

  is a vector containing the 64 triplets.

- AA:

  is a factor giving the amino acid names for each codon.

- usage.codon:

  is a dataframe containing the codon counts for each gene.

## Source

Data prepared by D. Charif <Delphine.Charif@versailles.inra.fr>

## References

Chiapello H., Olivier E., Landes-Devauchelle C., Nitschké P. and Risler
J.L (1999) Codon usage as a tool to predict the cellular localisation of
eukariotic ribosomal proteins and aminoacyl-tRNA synthetases. *Nucleic
Acids Res.*, **27**, 14, 2848–2851.

## Examples

``` r
data(aminoacyl)
aminoacyl$genes
#>  [1] "YCR024C" "YDR268W" "YGR094W" "YGR171C" "YHR011W" "YHR091C" "YKL194C"
#>  [8] "YLR382C" "YNL073W" "YOL033W" "YPL040C" "YPL097W" "YPL104W" "YPR033C"
#> [15] "YPR047W" "YNL247W" "YPR081C" "YBL076C" "YBR121C" "YDR023W" "YDR037W"
#> [22] "YDR341C" "YER087W" "YFL022C" "YGL245W" "YGR185C" "YGR264C" "YHR019C"
#> [29] "YIL078W" "YLR060W" "YOL097C" "YOR335C" "YPL160W" "YHR020W" "YOR168W"
#> [36] "YLL018C"
aminoacyl$usage.codon
#>     YCR024C YDR268W YGR094W YGR171C YHR011W YHR091C YKL194C YLR382C YNL073W
#> GCT       4       8      46       9       9       3      12      19       3
#> GCC       4       4      16       5       6      13       4       6       3
#> GCA       7       7       7       3      12      14       2      21       9
#> GCG       2       4       2       2       5       2       2       3       6
#> CGT       3       3      13       4       1       9       4       5       3
#> CGC       2       3       1       0       3       4       3       3       2
#> CGA       1       0       1       5       2       3       1       4       2
#> CGG       1       0       1       0       1       2       0       0       0
#> AGA      13       8      20      12       7      15      10      17      11
#> AGG       3       3       6       7       7       4       5       6      12
#> AAT      17      11      23      24      19      23      17      30      19
#> AAC       7       7      26      10       8      15      12      17      16
#> GAT      13      17      45      20      15      21      17      34      18
#> GAC       5       5      24      11       6      16      11      17      13
#> TGT       5       2      10       6       5       3       2       6       4
#> TGC       3       0       3       2       3       3       3       6       5
#> CAA      18       9      29      20      14      16      12      22      17
#> CAG       5       6       4       6       8      16       7      12      10
#> GAA      24      18      73      24      17      19      22      45      20
#> GAG       9       4      19      11      16       8       9      11      15
#> GGT       8       3      49       9       6      10      13      12       9
#> GGC       3       8       7      11       3       8       3      10      11
#> GGA       8       4       2       7      10      10       5      14       5
#> GGG       5       2       1       1       3       9       1      11       3
#> CAT       5       5      17      10       3      10      10       7       6
#> CAC       9       7       7       5       1       5       2       9       3
#> ATT      11      12      46      22      13      17      15      30      15
#> ATC       5       6      27       6       7       7       7      10       9
#> ATA      15       5       1      16      15      22       7      20      12
#> TTA      20      11      30      15      11      21       9      21      16
#> TTG      10       8      42      13      10      12      10      21      19
#> CTT       5       7       8       4       5      12       7       5       8
#> CTC       3       0       2       6       2       2       3       7       4
#> CTA       9       3       6       8       8      14       7       7       8
#> CTG       4       6       8       8       6       5       6      10      17
#> AAA      24      24      50      35      26      34      23      58      16
#> AAG      10      11      63      13      16      13      18      22      32
#> ATG       8      10      16       9      10      20      14      24      12
#> TTT      21      11      19      15       9      17      15      28      19
#> TTC       9       5      24      14       5      16      16      18      11
#> CCT       9       9      17       9       6       5       7      20      11
#> CCC       3       0       2       3       1       4       4       9       6
#> CCA      11       6      31      11      10      10       8      14       3
#> CCG       2       2       2       5       2       3       4      11       7
#> TCT       9       7      27       9       4      10      13      14       6
#> TCC       9       4      16      16       1      10       4       6       9
#> TCA      14       3       6       8      10      13       3      13       9
#> TCG       5       8       5       4       4       9       6       4       6
#> AGT       4       8       6       7       6       4       1      12       9
#> AGC       3       3       7       4       6       5       1      10       5
#> TAA       0       0       0       0       1       1       1       1       1
#> TAG       0       0       1       0       0       0       0       0       0
#> TGA       1       1       0       1       0       0       0       0       0
#> ACT      15       5      35       6       4       5      11      18       9
#> ACC       9       1      17       4       7       6       0      11       5
#> ACA       8       7       8       8       6       8       4      11       5
#> ACG       3       4       2       5       5       6       5       6      10
#> TGG       8       4      25      11       4       8      10      19       4
#> TAT      13       8      16      16       6      15       7      16       9
#> TAC       7       4      19       9       9       9       8      11      11
#> GTT      12      12      45      15       8      14       7      18       9
#> GTC       3       4      17       3       2       6       2      14       9
#> GTA       3       9       6       8       9      11       6      15       7
#> GTG       4       4       1       6       3       9       5      14       4
#>     YOL033W YPL040C YPL097W YPL104W YPR033C YPR047W YNL247W YPR081C YBL076C
#> GCT       8      12      12      12      29       5      23       6      26
#> GCC       5       8       3      11      10       4      14       4      18
#> GCA       9      17       3       9      10       1      11       9      11
#> GCG       5       5       5       3       3       3       1       2       1
#> CGT       2       4       3       3       4       4       3       3      15
#> CGC       1       7       0       1       0       3       3       2       1
#> CGA       3       4       5       2       1       1       0       5       0
#> CGG       3       0       2       2       0       0       0       1       1
#> AGA      14      18       7      17      11      16      16      16      28
#> AGG       6      13      11       9       6       4       2       9       1
#> AAT      12      29      19      26      11      16      27      22      19
#> AAC      14      22      10      11       5      11      23      12      27
#> GAT      22      36      20      25      24      23      34      23      48
#> GAC       6      16       9      14      11       9      19      13      30
#> TGT      10      11       6       3       5       1       4       6       9
#> TGC       1       3       1       5       0       5       2       2       0
#> CAA       9      32      11      13      12       9      28      13      20
#> CAG       6      17      11      10       4       3       9      12       4
#> GAA      22      53      15      28      31      24      38      32      59
#> GAG      13      14       5      18       9      11      15      14      20
#> GGT      11      12      12      14      30       2      17      15      43
#> GGC       4      12       5       7       7       6      11       4       7
#> GGA       7      18      13       7       2       8       5      10       6
#> GGG       6       5       4       4       1       3       1       8       1
#> CAT       9      25       5      10       2       9      15       9      13
#> CAC       7       9       3       2       4       5       1       4       7
#> ATT       9      29      13      18      20      16      29      22      44
#> ATC       8      20      11      13      15       8      19      10      20
#> ATA      18      23      11      12       4      11       3      12       3
#> TTA      15      34      16      16      14       9      25      16      34
#> TTG      22      26      16      20      18      12      28      23      46
#> CTT      10      16       6       4       4       8       3       4       7
#> CTC       1      10       4       6       1       4       0       2       1
#> CTA      10      23       8       8       6       6       8       7       7
#> CTG       7      10       5       8       1       4       2       6       4
#> AAA      28      50      23      37      25      26      40      29      50
#> AAG      23      29      11      24      29      14      37      17      43
#> ATG      12      15       7      15      12      14      12      18      18
#> TTT      21      25      15      31      10      13      23      24      22
#> TTC       5      13       7       8      10       6      15      15      31
#> CCT      12      11       6       8       7       6       9       8      14
#> CCC       3       9       5       4       1       4       5       4       2
#> CCA       9      13       5      18       7       7      13       8      28
#> CCG       2       8       0       4       0       3       3       5       1
#> TCT      17      14       8      11      21       9      14       5      26
#> TCC       3      15       6       6       8       4      16       7      21
#> TCA       6      20      11       9       9      14       9      10      12
#> TCG       6       6       4       4       2       0       4      11       1
#> AGT       3      11      11      12       5       3       6       6       8
#> AGC       4      13       3       3       1       3       5       1       3
#> TAA       1       0       1       0       1       0       0       1       0
#> TAG       0       0       0       0       0       1       1       0       0
#> TGA       0       1       0       1       0       0       0       0       1
#> ACT       5      17       9       7      14       9      19      16      25
#> ACC       7      11       1       8       5       7      11       5      17
#> ACA       5      16       9      10       7       9       8      10      12
#> ACG       7       8       6       5       2       4       5       7       4
#> TGG       5      18       3       5       4      10      14       6      22
#> TAT      15      25      12      13      10      10       9       5      25
#> TAC       5      17       7       9       7       5      12       8      22
#> GTT       6      19       9      12      19      10      19      10      44
#> GTC       6       9       4       5      10       4       9       6      24
#> GTA       4       8      10       8       2      11       3       9       5
#> GTG       2       9      10      11       4       5       8      10      11
#>     YBR121C YDR023W YDR037W YDR341C YER087W YFL022C YGL245W YGR185C YGR264C
#> GCT      25      16      21      18      10      10      35      11      22
#> GCC      17       6      14      10       3      12      13       9      11
#> GCA       7       1       1      11       6       4       3       6      13
#> GCG       0       1       1       4       5       1       1       5       1
#> CGT       5       4       9       7       4       4      10       0      10
#> CGC       2       0       1       1       2       0       0       0       1
#> CGA       0       0       0       0       3       0       0       0       0
#> CGG       0       0       0       0       1       0       0       0       0
#> AGA      26      12      23      19      12      15      23       8      12
#> AGG       3       1       2       1       6       0       3       2       1
#> AAT      13      11      10      13      24       9      15       9      30
#> AAC      10      12      11      13      11      17      21      12      24
#> GAT      29      17      24      22      31      15      43      10      30
#> GAC      20       7      17      12      10      20      21       8      15
#> TGT       6       5       8       2      11       1       6       3      10
#> TGC       0       3       1       1       4       0       1       1       0
#> CAA      15      17      24      20      11      20      16      15      24
#> CAG       1       4       2       4      11       5       0       2       3
#> GAA      52      40      46      36      27      26      44      23      44
#> GAG       9      11       9      14      10      12       2       7       7
#> GGT      30      21      29      28      14      21      24      17      29
#> GGC       5       2       2       7       8       2       6       4       2
#> GGA       4       3       1       3      11       1       6       1       5
#> GGG       2       0       1       0       3       4       1       1       1
#> CAT      12       5       7       7       8       4       4       3      17
#> CAC       3       4       9       7       5       8      10       2       5
#> ATT      21      12      17      22      13       9      28       9      23
#> ATC      14      13      10      18      11      17      18      12      15
#> ATA       2       1       1       1      14       1       4       0       3
#> TTA      18      17      12      24      17       7      19      10      22
#> TTG      32      17      27      18      15      23      32      19      34
#> CTT       3       2       5       6       5       9       1       4       4
#> CTC       0       1       1       1       2       4       1       2       1
#> CTA       2       4       5       6       6       7       7       5       8
#> CTG       1       0       2       6      11       8       1       1       6
#> AAA      30      24      23      29      35      20      27      21      34
#> AAG      30      26      25      22      15      21      49      21      28
#> ATG      12       6      20      19      16      14      17       9      10
#> TTT      22       7      13      15      18       7       8      12      18
#> TTC      11      13      17      14       5      19      21       8      14
#> CCT       7       3       7       5       6       8       8       6       9
#> CCC       0       1       0       3       4       4       2       2       1
#> CCA      23      15      23      11       9       8      20      17      24
#> CCG       0       0       3       1       1       0       0       1       0
#> TCT      19      12      11      15       5      11      13       5      22
#> TCC      11      10       7       5       4      12       6       5       7
#> TCA       4       3       3       5      14       3       5       3      10
#> TCG       0       0       1       3       6       4       1       1       5
#> AGT       5       3       0       1      11       0       2       3       7
#> AGC       0       1       1       2       5       1       3       2       3
#> TAA       1       1       1       1       0       1       1       1       1
#> TAG       0       0       0       0       1       0       0       0       0
#> TGA       0       0       0       0       0       0       0       0       0
#> ACT      13       7      12      11       8       5      20       5      11
#> ACC       9       4      10       5       4      16      13       8       2
#> ACA       4       1       7       8       8       6       2       2      12
#> ACG       2       1       0       1       2       3       2       2       7
#> TGG       7       6       2       9      10       6      12       1      13
#> TAT      10       8       7      13       8       3       8       7      20
#> TAC       8      13      13      11      10      12      15       6      15
#> GTT      33      15      15      24      10       9      22      14      32
#> GTC      17       8      14       8       7      12      22       8       7
#> GTA       1       4       3       3       6       0       1       1       1
#> GTG       0       1       1       2       4       3       6       3       6
#>     YHR019C YIL078W YLR060W YOL097C YOR335C YPL160W YHR020W YOR168W YLL018C
#> GCT      20      17      16       6      39      43      25      20      21
#> GCC      12      17      16       7      19      24      17       7      14
#> GCA       9       3       3       7       8      24       7      15       8
#> GCG       0       2       2       2       2       6       0       6       0
#> CGT       9      10       7       4      12      15       5       3      10
#> CGC       1       0       0       1       1       1       2       0       1
#> CGA       0       0       0       0       0       0       0       0       0
#> CGG       0       0       0       0       0       0       0       0       0
#> AGA      17      27      17      10      20      20      26      14      19
#> AGG       0       2       1       1       2       5       3       5       6
#> AAT       4      12      14       7      27      18      13      15       4
#> AAC       8      20      18       4      23      21      10      12      12
#> GAT      11      30      22      20      49      50      29      16      10
#> GAC      26      14      18      15      24      14      20       9      23
#> TGT       8       9       8       5       6      11       6       7       3
#> TGC       1       3       1       1       1       2       0       2       0
#> CAA      20      23      15      19      23      31      15      14      18
#> CAG       4       4       3       3       3       6       1       1       5
#> GAA      34      56      31      22      66      81      52      29      43
#> GAG      10       8      16       6      12      18       9       8      14
#> GGT      27      31      18      17      60      42      30      17      27
#> GGC       6       5       6       4      10       9       5       3       1
#> GGA       3       6       0       2       3       3       4      13       0
#> GGG       1       5       4       2       3       6       2       3       4
#> CAT       8      13       7       7      11      12      12       9       4
#> CAC       2       6       8       2       5       8       3       5       8
#> ATT      13      21      20      11      29      46      21      24      16
#> ATC      14      13      19       6      24      22      14      11      12
#> ATA       1       1       4       2       3       6       2       9       0
#> TTA       7      21      15       7      20      28      18      13       6
#> TTG      35      31      25      16      38      30      32      21      36
#> CTT       1       1       5       3       8       5       3       8       3
#> CTC       2       0       0       0       1       1       0       1       2
#> CTA       5       6       8       4       6       9       2       9       7
#> CTG       4       3       2       3       6       4       1       4       2
#> AAA      13      32      23      18      39      47      30      24      16
#> AAG      30      33      23      26      52      53      30      15      32
#> ATG      11      22      13       8      10      27      12      16      11
#> TTT       7      18      13      16      26      30      22      10      12
#> TTC      15      21      16      19      27      29      11       5      16
#> CCT       3       4       7       7      11      19       7      11       7
#> CCC       2       0       0       1       4       1       0       3       5
#> CCA      17      22      21      12      22      29      23      15      14
#> CCG       0       2       2       1       1       3       0       3       0
#> TCT      13      28      11       3      25      28      19      16       7
#> TCC      13       7      13       9      11       6      11       9      10
#> TCA       3       3       5       4       8      12       4       6       2
#> TCG       1       2       4       2       1       2       0       1       1
#> AGT       2       6       2       1       3       3       5       5       5
#> AGC       3       1       3       5       2       5       0       2       3
#> TAA       0       1       1       1       1       1       1       1       0
#> TAG       0       0       0       0       0       0       0       0       0
#> TGA       1       0       0       0       0       0       0       0       1
#> ACT      12      18       9       9      26      23      13       9       5
#> ACC      17      10      14      10      13      15       9       4      13
#> ACA       5       2       4       6       8      13       4      12       6
#> ACG       2       0       3       2       1       6       2       6       1
#> TGG       4      13       4       3       8      13       7       1       1
#> TAT      10       8       4       3      13      26      10       9       6
#> TAC      13      16      13       9      22      26       8       7      12
#> GTT      13      24      17      12      36      25      33      18      11
#> GTC      15      18      12       8      16      17      17      11      11
#> GTA       4       3       6       5       3       8       1      10       4
#> GTG       3       1       4       7       6       3       0      10       7
dudi.coa(aminoacyl$usage.codon, scannf = FALSE)
#> Duality diagramm
#> class: coa dudi
#> $call: dudi.coa(df = aminoacyl$usage.codon, scannf = FALSE)
#> 
#> $nf: 2 axis-components saved
#> $rank: 34
#> eigen values: 0.07774 0.01301 0.008387 0.007261 0.006383 ...
#>   vector length mode    content       
#> 1 $cw    36     numeric column weights
#> 2 $lw    64     numeric row weights   
#> 3 $eig   34     numeric eigen values  
#> 
#>   data.frame nrow ncol content             
#> 1 $tab       64   36   modified array      
#> 2 $li        64   2    row coordinates     
#> 3 $l1        64   2    row normed scores   
#> 4 $co        36   2    column coordinates  
#> 5 $c1        36   2    column normed scores
#> other elements: N 
```
