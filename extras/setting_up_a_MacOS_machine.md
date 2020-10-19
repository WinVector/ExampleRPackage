
Our example of how to set up a Linux machine is for `MacOS` Catalina (should work on earlier versions).


## Installing R and support software

To work effectively with R packages one needs to install R, complilers, git, and Latex documentation support.

To install:

  * **git.** Install git from [https://git-scm.com](https://git-scm.com).
  * **R.** Go to [https://cran.r-project.org/index.html](https://cran.r-project.org/index.html), and download and install.
  * **Latex** Go to [https://miktex.org/download](https://miktex.org/download) and download and install.

Another way to maintain Linux-style software on a Mac is to use Homebrew [https://brew.sh](https://brew.sh).
    
Use R to install R packages.

    R --no-restore
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

    R --no-restore
    git2r::clone(
       url = 'https://github.com/WinVector/ExampleRPackage.git',
       local_path = './ExampleRPackage')

or

    From a bash prompt
    git clone https://github.com/WinVector/ExampleRPackage.git
    
Start to work on the package.

    R --no-restore
    setwd("ExampleRPackage")
    devtools::build()
    install.packages('~/ExampleRPackage_0.1.0.tar.gz', repos = NULL)
    quit(save = 'no')
    
    R --no-restore
    library(ExampleRPackage)
    setwd("ExampleRPackage")
    tinytest::test_package("ExampleRPackage")

## (Optional) Installing RStudio


Install RStudio for macOS from [https://rstudio.com/products/rstudio/download/#download](https://rstudio.com/products/rstudio/download/#download).
