README
================

<!-- README.md is generated from README.Rmd. Please edit the .Rmd file, not the .md file. -->

[ExampleRPackage](https://github.com/WinVector/ExampleRPackage) package
README.

What you will need for this lesson is:

-   A working `R` of version at least as new as `3.6`, with `4.0.2`
    preferred.
-   A network connection.
-   To install the `R` packages listed in the next subsection.
-   A text editor or IDE (integrated development environment) for
    editing `R` files.
-   For the source-control steps a `git` client (either command line or
    graphical).
-   Some ability to delete files/directories.
-   A command-line shell able to run `R CMD` steps.

Configuring your machine
------------------------

Instructions on how to configure a machine are given here

-   [How to configure Linux for R
    work](https://github.com/WinVector/ExampleRPackage/blob/main/extras/setting_up_a_Linux_machine.md).
-   [How to configure OSX for R
    work](https://github.com/WinVector/ExampleRPackage/blob/main/extras/setting_up_a_MacOS_machine.md).
-   [How to configure Windows for R
    work](https://github.com/WinVector/ExampleRPackage/blob/main/extras/setting_up_a_Windows_machine.md).

These steps require some knowledge of working with your computer,
network access, disk space, and admin rights. We strongly advise you
take the steps in this section before class. We also strongly advise
taking the trouble to run these steps. Having full control of a
package-enabled R environment is very powerful. Please reach out for
help if you are stuck on steps.

Once you have your machine configured start up `R` and install the
packages we will be using.

A word of warning
-----------------

There are many systems and tutorials that sit on top of higher order R
tools. These can be useful, but, one must remember in R [“Writing R
Extensions”](https://cran.r-project.org/doc/manuals/R-exts.html) is the
primary source for how to develop R packges.

Packages we assume you have installed
-------------------------------------

We assume your machine has a current working R, command-shell (bash /
zsh), text editor (emacs, vim, or other), R, C compiler, git, and Latex.

Start R and run the following.

    install.packages(c(
       "roxygen2",   # to generate manuals from comments
       "wrapr",      # example for argument list checking
       "knitr",      # to generate vignettes from markdown
       "rmarkdown",  # to convert markdown formats
       "remotes",    # for installing from GitHub directly
       "tinytest"    # for running tests
       ))

The file structure of this project
----------------------------------

    DESCRIPTION    # the main project control file
    R              # project source code directory
     /example_function.R  # our example function
     /package_help.R      # package documentation
    README.Rmd     # package documentation source
    inst           # installed items distributed with package
        /tinytest  # package test directory
        /tinytest/test_ExampleRPackage.R  # the one test we have now
    vignettes      # where we place longer documents
             /Example_Vignette.Rmd  # Example markdown document
             /Peter_Winkler_Seven_Puzzles.pdf  # Example pre-rendered pdf
             /Peter_Winkler_Seven_Puzzles.pdf.asis  # pdf control
    tests             # test trigger, do not edit
         /tinytest.R  # test trigger, do not edit
    .Rbuildignore  # file that tells the builder what files to ignore
    .gitignore     # file that tells version control what files to skip
    ExampleRPackage.Rproj   # (optional) config file for RStudio
    man            # roxygen2 generated documentation
       /ExampleRPackage.Rd   # generated package documentation
       /example_function.Rd  # generated function documentation
    NAMESPACE      # project imports/exports, produced by roxygen2
    README.md      # package documentation, produced from README.Rmd

How to copy this project
------------------------

### From GitHub

Point browser to <https://github.com/WinVector/ExampleRPackage> and
press “Fork” in the upper right portion of the page.

### Copying the project at the command line (`base`/`zsh` for Linux, MacOS, or Windows with Windows Subsystem for Linux)

From a `bash`/`zsh` command line:

    # get a copy of the repository
    git clone https://github.com/WinVector/ExampleRPackage.git

    # remove the .git directory to sever it from the original repository
    cd ExampleRPackage
    rm -rf .git

    # start up a new git repository
    git init .
    git add -A .
    git commit -m"example package"

Then associate the package with your own repository by creating an new
empty repository on GitHub and following their “preexisting project”
instructions (adding a remote).

### From `RStudio`

    File -> New Project -> Version Control -> Git
       Repository URL: https://github.com/WinVector/ExampleRPackage.git
       Package name: name of your choice (try ExampleRPackage first).

Procedures for working with packages.
-------------------------------------

For all of these steps we are assuming your current directory is the
top-level of the package you are working with. This can be accomplished
with the `setwd()` command. Alternately one can use an `RStudio`
project, which largely keeps track of the working directory.

### Build `README.md` from `README.Rmd`

    knitr::knit("README.Rmd")

### Rebuild Package

    # regenerate man/.Rd files from roxygen comments
    roxygen2::roxygenize()
    # rebuild a source distribution of package
    # produces ExampleRPackage_0.1.0.tar.gz
    system("R CMD build .")
    # install the package from the source distribution
    install.packages("ExampleRPackage_0.1.0.tar.gz", repos = NULL)
    # attach package for use
    library(ExampleRPackage)

Probably want to restart `R` at this point and re-attach the package
with `library(ExampleRPackage)`.

### Run tests

This package is already setup to use `tinytest`. Existing packages can
be configured to work with `tinytest` by running
`tinytest::setup_tinytest('.')`.

``` r
# test package
tinytest::test_package('ExampleRPackage')
```

Running test\_ExampleRPackage.R…….. 0 tests Running
test\_ExampleRPackage.R…….. 1 tests \[0;32mOK\[0m \[1\] “All ok, 1
results”

``` r
# test directory of tests
dir <- system.file('tinytest', package = 'ExampleRPackage', mustWork = TRUE)
print(dir)
```

\[1\] “/Users/johnmount/Library/R/4.0/library/ExampleRPackage/tinytest”

``` r
tinytest::run_test_dir(dir)
```

Running test\_ExampleRPackage.R…….. 0 tests Running
test\_ExampleRPackage.R…….. 1 tests \[0;32mOK\[0m \[1\] “All ok, 1
results”

### Build source package for distribution and sharing

We will run this with our working directory inside our package (please
see `getwd()`/`setwd()` for how to navigate between directories in R).
This will produce the file `ExampleRPackage_0.1.0.tar.gz`.

    system("R CMD build .")

### Check package

    system("R CMD check ExampleRPackage_0.1.0.tar.gz")

Example code
------------

``` r
library(ExampleRPackage)

example_function(3)
```

    ## [1] 4

Sharing packages
----------------

### Install package from github

    remotes::install_github("https://github.com/WinVector/ExampleRPackage")
