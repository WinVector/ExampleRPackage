
Our example of how to set up a Linux machine is for `MacOS` Catalina (should work on earlier versions). This is to prepare for [our lesson on building your own R package](https://github.com/WinVector/ExampleRPackage).


## Installing R and support software

To work effectively with R packages one needs to install R, complilers, git, and Latex documentation support.

To install:

  * **xcode** Install [xcode from the app store](https://apps.apple.com/us/app/xcode/id497799835).
  * **git.** Install git from [https://git-scm.com](https://git-scm.com).
  * **R.** Go to [https://cran.r-project.org/index.html](https://cran.r-project.org/index.html), and download and install.
  * **Latex** Go to [https://miktex.org/download](https://miktex.org/download) and download and install.
  * **Pandoc** Install from [https://pandoc.org/installing.html](https://pandoc.org/installing.html).

Another way to maintain Linux-style software on a Mac is to use Homebrew [https://brew.sh](https://brew.sh).

Each machine is going to be a bit different. Paths with spaces in them can cause trouble for R, so try to avoid them. We confirmed these insstall instructions on MacOS 10.15.7 Catalina on Monday October 18th, 2020.
    
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
