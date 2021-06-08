#' Linear Modeling Function
#'
#' This function applies a linear model to a set of data, and returns the results.
#'
#' @param formula A formula specifying which variable is being predicted by
#'   which other variables.
#' @param data A set of data from which the model will be built.
#'
#' @return A table displaying the linear coefficients, the standard error
#'   of those coefficients, the t-value, and the p-value for each variable.
#'
#' @example
#' my_lm(lifeExp ~ gdpPercap + continent, my_gapminder)
#'
#' @keywords
#' inference
#' prediction
#'
#' @export
my_lm <- function(formula, data) {
  X <- model.matrix(formula, data)
  frame_data <- model.frame(formula, data)
  Y <- model.response(frame_data)
  df <- nrow(X) - ncol(X)
  sigma_sqrd <- 0
  se <- c()
  t_value <- c()
  p_value <- c()
  mat_for_tab <- matrix(nrow = ncol(X), ncol = 4)
  colnames(mat_for_tab) <- c("Estimate", "Std. Error",
                             "t value", "Pr(>|t|)")
  rownames(mat_for_tab) <- colnames(X)

  beta <- (solve(t(X) %*% X)) %*% t(X) %*% Y
  mat_for_tab[, 1] <- beta

  for (i in c(1:nrow(X))) {
    sigma_sqrd <- sigma_sqrd + ((Y[i] - sum((X[i,] * beta))) ^ 2) / df
  }

  for (i in c(1:ncol(X))) {
    se[i] <- sqrt(sigma_sqrd * solve(t(X) %*% X)[i, i])
  }

  mat_for_tab[, 2] <- se

  for (i in c(1:ncol(X))){
    t_value[i] <- beta[i] / se[i]
  }

  mat_for_tab[, 3] <- t_value

  for(i in c(1:ncol(X))) {
    p_value[i] <- 2 * pt(abs(t_value[i]), df, lower.tail = FALSE)

  }

  mat_for_tab[, 4] <- p_value
  final_table <- as.table(mat_for_tab)
  return(final_table)

}
