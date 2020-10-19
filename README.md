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

Configuring your machine
------------------------

Instructions on how to configure a machine are given here

-   [How to configure Linux for R
    work](https://github.com/WinVector/ExampleRPackage/blob/main/extras/setting_up_a_Linux_machine.md).
-   [How to configure OSX for R
    work](https://github.com/WinVector/ExampleRPackage/blob/main/extras/setting_up_a_MacOS_machine.md).
-   [How to configure Windows for R
    work](https://github.com/WinVector/ExampleRPackage/blob/main/extras/setting_up_a_Windows_machine.md).

These steps require some knowlege of working with your computer, network
access, disk space, and admin rights. We strongly advise you take the
steps in this section before class. We also strongly advise taking the
trouble to run these steps. Having full control of a package-enabled R
environment is very powerful. Please reach out for help if you are stuck
on steps.

Once you have your machine configured start up `R` and install the
packages we will be using.

Packages we assume you have installed
-------------------------------------

We assume your machine has a current working R, command-shell (bash /
zsh), text editor (emacs, vim, or other), R, C compliler, git, and
Latex.

Start R and run the following.

    install.packages(c(
       "devtools",   # for working with packages
       "roxygen2",   # to generate manuals from comments
       "wrapr",      # example for argument list checking
       "knitr",      # to generate vignettes from markdown
       "rmarkdown",  # to generate vignettes from markdown
       "R.rsp",      # to pass pre-generated PDF as vignettes
       "inputenc",   # used by the vignette system
       "git2r",      # for direct in-R git work
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

### From `R`

One could try to issue the clone command using
[git2r](https://CRAN.R-project.org/package=git2r).

    # move to a directory we are willing to work in
    setwd("~/Downloads")

    # copy the directory
    git2r::clone(
       url = 'https://github.com/WinVector/ExampleRPackage.git',
       local_path = './ExampleRPackage')
       
    # move into project
    setwd('./ExampleRPackage')

    # remove .git to break association with original GitHub project
    unlink('.git', recursive = TRUE)

    # init a new repository, and add all content
    git2r::init()
    git2r::add(path = '.')
    # git2r::status()
    git2r::commit(message = 'example package')

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
    devtools::document()
    # rebuild a source distribution of package
    pkg_file <- devtools::build()
    print(pkg_file)
    # install the package from the source distribution
    install.packages(pkg_file, repos = NULL)

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

### Check package

    devtools::check(document = FALSE)

### Build source package for distribution and sharing

    devtools::build()

### Install package from github

    remotes::install_github("https://github.com/WinVector/ExampleRPackage")

### List vignettes

    library(ExampleRPackage)
    vignette(package = "ExampleRPackage")

### Get Help

    library(ExampleRPackage)
    help(ExampleRPackage)

Example code
------------

``` r
library(ExampleRPackage)

example_function(3)
```

    ## [1] 4
