
Our example of how to set up a Linux machine is for `Ubuntu` 20.04. This is to prepare for [our lesson on building your own R package](https://github.com/WinVector/ExampleRPackage).

Find the terminal app and make sure it is in your favorites.

## Installing R and support software

Using the terminal install editors.

    sudo apt-get update
    sudo apt-get install emacs-nox vim-nox
    
Now add a bunch of support packages.

    sudo apt-get install curl xml2 libcurl4-openssl-dev libxml2-dev libssl-dev git qpdf pandoc gdebi-core
    sudo apt-get install texlive texstudio texinfo texlive-fonts-extra

Each machine is going to be a bit different. Paths with spaces in them can cause trouble for R, so try to avoid them. We confirmed these insstall instructions on clean `Ubuntu` 20.04 machine on Sunda October 17th, 2020.

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


(From [https://rstudio.com/products/rstudio/download-server/debian-ubuntu/](https://rstudio.com/products/rstudio/download-server/debian-ubuntu/).)

    wget https://download2.rstudio.org/server/bionic/amd64/rstudio-server-1.3.1093-amd64.deb
    sudo gdebi rstudio-server-1.3.1093-amd64.deb
    sudo rstudio-server restart

Now open a web-browser to [http://127.0.0.1:8787/](http://127.0.0.1:8787/) and log in with your Unix name and password.

