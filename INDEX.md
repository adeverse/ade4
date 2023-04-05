[![CRAN_Status_Badge](http://www.r-pkg.org/badges/version/ade4)](http://cran.r-project.org/package=ade4)
[![CRAN Downloads](https://cranlogs.r-pkg.org/badges/ade4)](https://cran.r-project.org/package=ade4)
[![R-CMD-check](https://github.com/sdray/ade4/workflows/R-CMD-check/badge.svg)](https://github.com/sdray/ade4/actions)
[![License: GPL v3](https://img.shields.io/badge/License-GPLv3-blue.svg)](https://www.gnu.org/licenses/gpl-3.0)

# [About ade4](http://pbil.univ-lyon1.fr/ADE-4/)

Analysis of Ecological Data : Exploratory and Euclidean Methods in Environmental Sciences

Ade4 is originally a software developped at LBBE (Laboratoire de Biométrie et Biologie Évolutive - UMR 5558), University Claude Bernard Lyon 1. It became a R package in 2002.

If you use ade4, please consider citing:

- Chessel, D., A.-B. Dufour, and J. Thioulouse. 2004. The ade4 package-I- One-table methods. R News 4:5-10.
- S. Dray, A.B. Dufour, and D. Chessel. 2007. The ade4 package - II: Two-table and K-table methods. R News 7(2):47-52.
- S. Dray and A.B. Dufour. 2007. The ade4 package: implementing the duality diagram for ecologists. Journal of Statistical Software 22(4):1-20.
- Thioulouse, J., D. Chessel, S. Dolédec, and J. M. Olivier. 1997. ADE-4: a multivariate analysis and graphical display software. Statistics and Computing 7:75-83.

# Install *ade4*

To install the development version from github:

1. Install the release version of `remotes` from CRAN with `install.packages("remotes")`.

2. Make sure you have a working development environment.
    - **Windows**: Install [Rtools](http://cran.r-project.org/bin/windows/Rtools/).
    - **Mac**: Install Xcode from the Mac App Store.
    - **Linux**: Install a compiler and various development libraries (details vary across different flavors of Linux).

Then:

```r
remotes::install_github("sdray/ade4")
```

The stable version can be installed from CRAN using:

```r
install.packages("ade4")
```

Once installed, the package can be loaded using:

```r
library("ade4")
```

If you do not wish to install the development environments Rtools (Windows) / XCode (Mac), you can get the binary packages here:

- [**Windows**](http://pbil.univ-lyon1.fr/members/thioulouse/bin/windows/)

- [**macOS**](http://pbil.univ-lyon1.fr/members/thioulouse/bin/macosx/)
