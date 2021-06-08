#' T-test Function
#'
#' This function performs a t-test on a data vector.
#'
#' @param x Data vector on which t-test is performed.
#' @param alternative A String (less, greater, or two.sided),
#'   against which the null-hypothesis will be compared.
#' @param mu A numeric value representing the null hypothesis for the t-test.
#'
#' @return List containing the numeric test statistic, numeric degrees of freedom,
#'   string representing the type of t-test performed, and the numeric p-value.
#'
#' @examples
#' my_t_test(my_gapminder$lifeExp, "greater", 60)
#' my_t_test(my_gapminder$lifeExp, "two.sided", 60)
#'
#' @keywords
#' inference
#'
#' @export
my_t_test <- function(x, alternative, mu) {
  df <- length(x) - 1
  st_error <- sd(x)/sqrt(length(x))
  test_stat <- (mean(x) - mu) / st_error
  if (alternative == "less"){
    p_val <- pt(test_stat, df, lower.tail = TRUE)
  }
  else if (alternative == "greater"){
    p_val <- 1- pt(test_stat, df, lower.tail = TRUE)
  }
  else if (alternative == "two.sided") {
    p_val <- 2 * pt(abs(test_stat), df, lower.tail = FALSE)
  }
  else {
    return("Error: Invalid alternative hypothesis. Value for `Alternative` must be `greater`, `less`, or `two.sided`.")
  }
  return(list(test_stat, df, alternative, p_val))

}
