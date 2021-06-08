
# project3package

<!-- badges: start -->
[![R-CMD-check](https://github.com/oliverlinehan41/project3package/workflows/R-CMD-check/badge.svg)](https://github.com/oliverlinehan41/project3package/actions)

<a href="https://codecov.io/gh/oliverlinehan41/project3package">
<img src="https://codecov.io/gh/oliverlinehan41/project3package/branch/master/graph/badge.svg?token=93GFV9VC0C"/>
      </a>
    
<!-- badges: end -->

The goal of project3package is to demonstrate knowledge of concepts I learned throughout the Stat 302 course.

## Installation

You can install the released version of project3package from [CRAN](https://CRAN.R-project.org) with:

``` r
install.packages("project3package")
```

To view the vignette:
``` r
devtools::install_github("oliverlinehan41/project3package", build_vignette= TRUE, build_opts = c())
library(project3package)
# Use this to view vignette in the HTML help
help(package = "project3package", help_type = "html")
# Use this to view vignette as an isolated HTML file
utils::browseVignettes(package = "project3package")

```

## Example

This is a basic example which shows you how to solve a common problem: Raising a number to a power

``` r
library(project3package)
my_pow(2)
```

