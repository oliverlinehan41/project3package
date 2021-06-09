test_that("multiplication works", {
  expect_equal(2 * 2, 4)
})

test_that("Function returns list", {
  expect_type(object = my_knn_cv(my_penguins, my_penguins$species, 1, 5),
              type = "list")
})
