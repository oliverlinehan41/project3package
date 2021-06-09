#' Random Forest Cross Validation Function
#'
#' This function performs cross validation for values of k in random forest.
#'
#' @param k A number representing the number of folds the data will be divided into.
#'
#' @return A number representing the mean cross-validation standard error for that
#'   number of folds.
#'
#' @examples
#' library(randomForest)
#' library(dplyr)
#' my_rf_cv(2)
#' my_rf_cv(10)
#'
#' @keywords
#' prediction
#'
#' @export
my_rf_cv <- function(k) {

  library(randomForest)
  library(dplyr)
  # Creates dataframe and assigns folds
  rf_dta <- data.frame("mass" = my_penguins$body_mass_g,
                       "bill_lng" = my_penguins$bill_length_mm,
                       "bill_dpt" = my_penguins$bill_depth_mm,
                       "flip_lng" = my_penguins$flipper_length_mm)
  rf_dta <- na.omit(rf_dta)
  fold <- sample(rep(1:k, length = nrow(rf_dta)))
  rf_dta$fold <- fold

  # Initializes mean SE vector
  mses <- vector(mode = "numeric", length = k)

  # Predicts body mass and calculates mean SE for each fold
  for(i in 1:k) {

    # Initializes training and test data
    data_train <- rf_dta %>% filter(fold != i)
    data_test <- rf_dta %>% filter(fold == i)

    # Predicts body mass
    Model <- randomForest(mass ~ bill_lng + bill_dpt + flip_lng,
                          data = data_train,
                          ntree = 100)
    Predictions <- predict(Model, data_test[, c(2:4)])

    # Calculates mean SE for each fold
    diff_sqd <- vector(mode = "numeric", length = nrow(data_test))
    for(j in 1:nrow(data_test)) {
      diff_sqd[j] <- (Predictions[j] - data_test$mass[j]) ^ 2
    }

    # Assigns mean SE for each fold to a vector
    mses[i] <- mean(diff_sqd)

  }

  # Calculates the mean CV standard error
  cv_mse <- mean(mses)
  return(cv_mse)




}
