
Our example of how to set up a Linux machine is for `Windows` 10.


## Installing R and support software

To work effectively with R packages one needs to install R, complilers, git, and Latex documentation support.

To install:

  * **git.** Install git for Windows [https://gitforwindows.org](https://gitforwindows.org) which supplies `gitbash`.
  * **R.** Go to [https://cran.r-project.org/index.html](https://cran.r-project.org/index.html), click on "Download R for Windows" and then click on "base", and finally "Download R 4.0.3 for Windows".  Run the ".exe" when it has finished downloading.
  * **Rtools.** Go to [https://cran.r-project.org/index.html](https://cran.r-project.org/index.html), click on "Download R for Windows" and then click on "Rtools", and finally download and run "rtools40-x86_64.exe".
  * **Latex** Go to [https://miktex.org/download](https://miktex.org/download) and download and install.

    
Use R to install R packages.

    Start R
    install.packages(c(
       "devtools",   # for working with packages
       "roxygen2",   # to generate manuals from comments
       "wrapr",      # example for argument list checking
       "knitr",      # to generate vignettes from markdown
       "rmarkdown",  # to generate vignettes from markdown
       "R.rsp",      # to pass pre-generated PDF as vignettes
       "git2r",      # for direct in-R git work
       "remotes",    # for installing from GitHub directly
       "tinytest"    # for running tests
       ))
    quit(save = 'no')


Back at the bash or zsh bring in our example package.

    Start R
    git2r::clone(
       url = 'https://github.com/WinVector/ExampleRPackage.git',
       local_path = './ExampleRPackage')

or

    From a bash prompt
    git clone https://github.com/WinVector/ExampleRPackage.git
    
Start to work on the package.

    Start R
    setwd("ExampleRPackage")
    devtools::build()
    install.packages('~/ExampleRPackage_0.1.0.tar.gz', repos = NULL)
    quit(save = 'no')
    
    Start R
    library(ExampleRPackage)
    setwd("ExampleRPackage")
    tinytest::test_package("ExampleRPackage")

## (Optional) Installing RStudio


Install RStudio for Windows 10/8/7 from [https://rstudio.com/products/rstudio/download/#download](https://rstudio.com/products/rstudio/download/#download).
