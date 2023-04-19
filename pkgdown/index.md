# Analysis of Ecological Data : Exploratory and Euclidean Methods in Environmental Sciences [(ade4)](http://pbil.univ-lyon1.fr/ADE-4/) <img src="man/figures/logo.svg" align="right" />
[![CRAN_Status_Badge](http://www.r-pkg.org/badges/version/ade4)](http://cran.r-project.org/package=ade4)
[![CRAN Downloads](https://cranlogs.r-pkg.org/badges/ade4)](https://cran.r-project.org/package=ade4)
[![R-CMD-check](https://github.com/sdray/ade4/workflows/R-CMD-check/badge.svg)](https://github.com/sdray/ade4/actions)
[![License: GPL v3](https://img.shields.io/badge/License-GPLv3-blue.svg)](https://www.gnu.org/licenses/gpl-3.0)

Ade4 is originally a software developped at LBBE (Laboratoire de Biométrie et Biologie Évolutive - UMR 5558), University Claude Bernard Lyon 1. It became a R package in 2002.

If you use ade4, please consider [citing us](http://sdray.github.io/ade4/authors.html#citation) !

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

# Getting started with ade4

## Vignettes

We provide some vignettes to help you get started with ade4. You can also find a list of functions available to users on our [reference page](http://sdray.github.io/ade4/reference/index.html).

## Ressources

Check out the [ade4 book](https://link.springer.com/book/10.1007/978-1-4939-8850-1) and its [shiny application](https://ade4.shinyapps.io/Book/) for a complete introduction to the package and to rerun the code present in the book. You can also find hereafter some [papers](http://sdray.github.io/ade4/articles/papers.html) to help you understand ade4 methods.

## Shinyapps

Consider giving a try to our shinyapps, developped to allow you to run an analysis without having to write your own script: [ade4shiny](https://lbbe-shiny.univ-lyon1.fr/Reproducible_Research/ShinyADE4/). You will be able to download the R script used to generate the results as well as the analyses outputs and graphical representations.

## Getting help

You can swing by our [FAQ section](file:///C:/Users/suzon/Documents/Cours/Master_bioinformatique/M2/projet/docs/faq.html) to check if your question has already been answered or ask for help on the ade4 mailing list [adelist](https://listes.univ-lyon1.fr/sympa/info/adelist).
