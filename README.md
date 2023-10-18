# pkgdown <img src="man/figures/logo.svg" align="right" />
[![CRAN_Release_Badge](http://www.r-pkg.org/badges/version-ago/ade4)](http://cran.r-project.org/package=ade4)
[![CRAN Downloads](https://cranlogs.r-pkg.org/badges/ade4)](https://cran.r-project.org/package=ade4)
[![R-CMD-check](https://github.com/sdray/ade4/actions/workflows/R-CMD-check.yaml/badge.svg)](https://github.com/sdray/ade4/actions/workflows/R-CMD-check.yaml)
[![License: GPL v3](https://img.shields.io/badge/License-GPLv3-blue.svg)](https://www.gnu.org/licenses/gpl-3.0)

# [ade4](http://pbil.univ-lyon1.fr/ADE-4/)
Analysis of Ecological Data: Exploratory and Euclidean Methods in Environmental Sciences

Installing *ade4*
-------------

To install the development version from github:

1. Install the release version of `remotes` from CRAN with `install.packages("remotes")`.

2. Make sure you have a working development environment.
    * **Windows**: Install [Rtools](http://cran.r-project.org/bin/windows/Rtools/).
    * **Mac**: Install Xcode from the Mac App Store.
    * **Linux**: Install a compiler and various development libraries (details vary across different flavors of Linux).
    
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

* [**Windows**](http://pbil.univ-lyon1.fr/members/thioulouse/bin/windows/)

* [**macOS**](http://pbil.univ-lyon1.fr/members/thioulouse/bin/macosx/)
