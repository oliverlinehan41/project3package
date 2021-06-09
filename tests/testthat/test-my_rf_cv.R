test_that("multiplication works", {
  expect_equal(2 * 2, 4)
})

test_that("function returns double", {
  expect_type(object = my_rf_cv(5), type = "double")
})
