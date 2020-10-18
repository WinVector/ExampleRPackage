
#' Example Function.
#'
#' This function is an example.
#'
#' @param a numeric argument
#' @param ... Not, used- force later arguments to bind by name
#' @param delta numeric amount to add
#' @return a + delta
#'
#' @examples
#'
#' example_function(3, delta = 2)  # should be 5
#'
#' @export
#'
example_function <- function(
  a,
  ...,
  delta = 1) {
  wrapr::stop_if_dot_args(substitute(list(...)), "example_function")
  a + delta
}
