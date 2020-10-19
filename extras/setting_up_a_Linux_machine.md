
Our example of how to set up a Linux machine is for `Ubuntu` 20.04.

Find the terminal app and make sure it is in your favorites.

Using the terminal install editors.

    sudo apt-get update
    sudo apt-get install emacs-nox vim-nox
    
Now add a bunch of support packages.

    sudo apt-get install curl xml2 libcurl4-openssl-dev libxml2-dev libssl-dev git qpdf pandoc 
    sudo apt-get install texlive texstudio texinfo texlive-fonts-extra

Add an R distro to your package repository lists.

    # add the following line to /etc/apt/sources.list (no indent/initial spaces)
    #   deb https://cloud.r-project.org/bin/linux/ubuntu focal-cran40/
    # I did this by using an editor:
    #   sudo emacs /etc/apt/sources.list
    #   sudo vim /etc/apt/sources.list
    # documentation from: https://cran.r-project.org linux installation
    sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 51716619E084DAB9
    sudo apt-get update

Now install R.  
    
    sudo apt-get install r-base
    sudo apt-get install r-base-dev
    
Use R to install R packages.

    R
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
    quit()


Back at the bash or zsh bring in our example package.

    git clone https://github.com/WinVector/ExampleRPackage.git
    
Start to work on the package.

    R
    setwd("ExampleRPackage")
    devtools::build()
    install.packages('~/ExampleRPackage_0.1.0.tar.gz', repos = NULL)
    quit()
    
    R
    library(ExampleRPackage)
    setwd("ExampleRPackage")
    tinytest::test_package("ExampleRPackage")

