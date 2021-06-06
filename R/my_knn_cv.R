#' K Nearest Neighbors Cross Validation Function
#'
#' Function performs cross validation to determine appropriate "k"
#'   for k-nearest-neighbors.
#'
#' @param train The dataset on which your model will be trained.
#' @param cl The vector containing the actual classes of your observations.
#' @param k_nn The number of nearest neighbors used to predict the class of an observation.
#' @param k_cv The number of folds your training data will be divided into for cross-validation.
#'
#' @return A list containing vector "class", which contains the predicted classes using
#'   the entire data as training data, and the numeric "cv_err" which is the mean
#'   cross-validation error for your chosen "k".
#'
#' @examples
#' my_knn_cv(penguins, penguins$species, 1, 5)
#' my_knn_cv(penguins, penguins$species, 5, 5)
#'
#' @keywords
#' prediction
#'
#' @export
my_knn_cv <- function(train, cl, k_nn, k_cv) {

  # Generates random set of numbers between 1 and k_cv
  n <- nrow(train)
  fold <- sample(rep(1:k_cv, length = n))

  # Assigns above numbers to data frame to divide data into folds
  # Also adds relevant variables to data frame
  sp_dta <- data.frame("bill_lng" = train$bill_length_mm,
                       "bill_dpt" = train$bill_depth_mm ,
                       "flip_lng" = train$flipper_length_mm,
                       "body_mass" = train$body_mass_g,
                       "fold" = fold,
                       "species" = cl)
  sp_dta <- na.omit(sp_dta)
  misclass_rates <- vector(mode = "numeric", length = k_cv)

  # Obtains class prediction and classification error for each fold
  for(i in 1:k_cv) {

    # Initializes data sets and vectors
    data_train <- sp_dta %>% filter(fold != i)
    data_test <- sp_dta %>% filter(fold == i)
    z <- nrow(data_test)
    predictions <- vector(mode = "character", length = nrow(data_test))
    is_correct <- vector(mode = "numeric", length = nrow(data_test))

    # Predicts classifications for folds and assigns to a vector.
    predictions <- knn(data_train[, -c(5:6)], data_test[, -c(5:6)], data_train$species, k = k_nn)
    pred_vct <- as.vector(predictions)




    # Checks if predictions are correct
    for(j in 1:length(pred_vct)) {
      if (pred_vct[j] == data_test$species[j]) {
        is_correct[j] <- 0

      }
      else {
        is_correct[j] <- 1
      }


    }





    # Adds misclassification rate for each fold to a vector

    misclass_rates[i] <- mean(is_correct)





  }


  # Predicts using full data as both training and test data, putting result into "class"
  # Calculates cross validation error
  class <- vector(mode = "character", length = length(sp_dta))
  class <- as.vector(knn(train = sp_dta[, -c(5:6)], test = sp_dta[, -c(5:6)], sp_dta$species, k = k_nn))
  cv_err <- mean(misclass_rates)

  return(list(class, cv_err))




}
