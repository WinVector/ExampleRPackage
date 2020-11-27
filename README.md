README
================

<!-- README.md is generated from README.Rmd. Please edit the .Rmd file, not the .md file. -->

[ExampleRPackage](https://github.com/WinVector/ExampleRPackage) package
README.

What you will need for this lesson is:

-   A working `R` of version at least as new as `3.6`, with `4.*`
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

``` r
install.packages(c(
   "roxygen2",   # to generate manuals from comments
   "wrapr",      # example for argument list checking
   "knitr",      # to generate vignettes from markdown
   "rmarkdown",  # to convert markdown formats
   "remotes",    # for installing from GitHub directly
   "tinytest"    # for running tests
   ))
```

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

Procedures for working with packages.
-------------------------------------

For all of these steps we are assuming your current directory is the
top-level of the package you are working with. This can be accomplished
with the `setwd()` command. Alternately one can use an `RStudio`
project, which largely keeps track of the working directory.

### Build Package

We will run this with our working directory inside our package (please
see `getwd()`/`setwd()` for how to navigate between directories in R).
This will produce the file `ExampleRPackage_0.1.0.tar.gz`.

``` r
library(wrapr)

# assumes our current directory is our package
# see setwd()/getwd() for how to change directories
rebuild_current_package_and_attach <- function(
   ...,  # not used, force later arguments to bind by name
   package_dir = getwd(),  # default to package is current directory.
   lib = .libPaths()[[1]]  # where to attach package
   ) {
   wrapr::stop_if_dot_args(substitute(list(...)), "rebuild_current_package")
   start_time <- date()
   message(paste("rebuild_current_package working in directory", package_dir))
   message(paste("rebuild_current_package working in lib", lib))
   # get package name from current directory
   pkg_name <- tail(strsplit(package_dir, .Platform$file.sep)[[1]], n = 1)
   message(paste("rebuild_current_package working on package", pkg_name))
   # get into a clean state with no package installed/attached
   detach_str <- paste0('package:', pkg_name)
   res <- tryCatch(do.call(detach, list(detach_str)), error = function(e) e)
   if(pkg_name %in% rownames(installed.packages())) {
      remove.packages(pkg_name, lib = lib)
   }
   # regenerate man/.Rd files from roxygen comments
   res_text <- capture.output(suppressMessages(roxygen2::roxygenize(package.dir = package_dir)))
   # rebuild a source distribution of package
   res <- system(paste("R CMD build", package_dir), 
                 intern = TRUE)
   # find the tar name
   matches <- res[grepl(pkg_name, res)]
   pkg_pattern <- paste0(pkg_name, '[_.0-9]+', '.tar.gz')
   matches <- matches[grepl(pkg_pattern, matches)]
   if(length(matches) != 1) {
      stop("having trouble finding package tar name from R CMD build output")
   }
   str_span <- regexpr(pkg_pattern, matches)
   tar_name <- substr(matches, str_span, str_span + attr(str_span, 'match.length') - 1)
   # install the package from the source distribution
   res_text <- capture.output(install.packages(tar_name, repos = NULL, verbose = FALSE, quiet = TRUE))
   # attach package for use
   res_text <- capture.output(library(pkg_name, character.only = TRUE))
   end_time <- date()
   return(list(
      pkg_name = pkg_name,
      tar_name = tar_name,
      package_dir = package_dir,
      package_dir = package_dir,
      lib = lib,
      start_time = start_time,
      end_time = end_time
   ))
}
```

``` r
# re-document, re-build, re-install, and re-attach package
# write only name of package and tar file name into current work-space
(unpack[pkg_name, tar_name] := rebuild_current_package_and_attach())

# rebuild_current_package working in directory /Users/johnmount/Documents/work/ExampleRPackage
# rebuild_current_package working in lib /Users/johnmount/Library/R/4.0/library
# rebuild_current_package working on package ExampleRPackage
# 
# $pkg_name
# [1] "ExampleRPackage"
# 
# $tar_name
# [1] "ExampleRPackage_0.1.0.tar.gz"
# 
# $package_dir
# [1] "/Users/johnmount/Documents/work/ExampleRPackage"
# 
# $package_dir
# [1] "/Users/johnmount/Documents/work/ExampleRPackage"
# 
# $lib
# [1] "/Users/johnmount/Library/R/4.0/library"
# 
# $start_time
# [1] "Fri Nov 27 11:13:31 2020"
# 
# $end_time
# [1] "Fri Nov 27 11:13:35 2020"
```

``` r
ls()
```

    ## [1] "pkg_name"                           "rebuild_current_package_and_attach"
    ## [3] "tar_name"

``` r
print(pkg_name)
```

    ## [1] "ExampleRPackage"

``` r
print(tar_name)
```

    ## [1] "ExampleRPackage_0.1.0.tar.gz"

Probably want to restart `R` at this point and re-attach the package
with `library(ExampleRPackage)`.

### Build `README.md` from `README.Rmd`

``` r
knitr::knit("README.Rmd")
```

Some time after rebuilding `README.md` you may want to rebuild the
package again to make sure the new copy is included in the package tar.

### Run tests

This package is already setup to use `tinytest`. Existing packages can
be configured to work with `tinytest` by running
`tinytest::setup_tinytest('.')`.

``` r
# test directory of tests
dir <- system.file('tinytest', 
                   package = 'ExampleRPackage', 
                   mustWork = TRUE)
print(dir)
```

    ## [1] "/Users/johnmount/Library/R/4.0/library/ExampleRPackage/tinytest"

``` r
test_text <- capture.output(tinytest::run_test_dir(
   dir,
   verbose = TRUE,
   color = FALSE))
cat(paste(test_text, collapse = '\n'))
```

    ## Running test_ExampleRPackage.R........    1 tests OK 
    ## [1] "All ok, 1 results"

### Check package

``` r
check_text <- system(paste("R CMD check", tar_name),
       intern = TRUE)
cat(paste(check_text, collapse = '\n'))
```

    ## * using log directory ‘/Users/johnmount/Documents/work/ExampleRPackage/ExampleRPackage.Rcheck’
    ## * using R version 4.0.2 (2020-06-22)
    ## * using platform: x86_64-apple-darwin17.0 (64-bit)
    ## * using session charset: UTF-8
    ## * checking for file ‘ExampleRPackage/DESCRIPTION’ ... OK
    ## * checking extension type ... Package
    ## * this is package ‘ExampleRPackage’ version ‘0.1.0’
    ## * package encoding: UTF-8
    ## * checking package namespace information ... OK
    ## * checking package dependencies ... OK
    ## * checking if this is a source package ... OK
    ## * checking if there is a namespace ... OK
    ## * checking for executable files ... OK
    ## * checking for hidden files and directories ... OK
    ## * checking for portable file names ... OK
    ## * checking for sufficient/correct file permissions ... OK
    ## * checking whether package ‘ExampleRPackage’ can be installed ... OK
    ## * checking installed package size ... OK
    ## * checking package directory ... OK
    ## * checking ‘build’ directory ... OK
    ## * checking DESCRIPTION meta-information ... OK
    ## * checking top-level files ... OK
    ## * checking for left-over files ... OK
    ## * checking index information ... OK
    ## * checking package subdirectories ... OK
    ## * checking R files for non-ASCII characters ... OK
    ## * checking R files for syntax errors ... OK
    ## * checking whether the package can be loaded ... OK
    ## * checking whether the package can be loaded with stated dependencies ... OK
    ## * checking whether the package can be unloaded cleanly ... OK
    ## * checking whether the namespace can be loaded with stated dependencies ... OK
    ## * checking whether the namespace can be unloaded cleanly ... OK
    ## * checking loading without being on the library search path ... OK
    ## * checking dependencies in R code ... OK
    ## * checking S3 generic/method consistency ... OK
    ## * checking replacement functions ... OK
    ## * checking foreign function calls ... OK
    ## * checking R code for possible problems ... OK
    ## * checking Rd files ... OK
    ## * checking Rd metadata ... OK
    ## * checking Rd cross-references ... OK
    ## * checking for missing documentation entries ... OK
    ## * checking for code/documentation mismatches ... OK
    ## * checking Rd \usage sections ... OK
    ## * checking Rd contents ... OK
    ## * checking for unstated dependencies in examples ... OK
    ## * checking installed files from ‘inst/doc’ ... OK
    ## * checking files in ‘vignettes’ ... OK
    ## * checking examples ... OK
    ## * checking for unstated dependencies in ‘tests’ ... OK
    ## * checking tests ...
    ##  OK
    ## * checking for unstated dependencies in vignettes ... OK
    ## * checking package vignettes in ‘inst/doc’ ... OK
    ## * checking running R code from vignettes ...
    ##   ‘Example_Vignette.Rmd’ using ‘UTF-8’... OK
    ##  NONE
    ## * checking re-building of vignette outputs ... OK
    ## * checking PDF version of manual ... OK
    ## * DONE
    ## Status: OK

Example code
------------

``` r
example_function(3)
```

    ## [1] 4

Sharing packages
----------------

### Install from tar

``` r
install.packages(tar_name, repos = NULL)
```

### Install package from github

``` r
remotes::install_github("https://github.com/WinVector/ExampleRPackage")
```
