test_that("multiplication works", {
  expect_equal(2 * 2, 4)
})

test_that("Degrees of Freedom is closure", {
  expect_type(object = df, type = "closure")
})

test_that("Alternative is character", {
  expect_type(object = my_t_test(my_gapminder, "two.sided", 60), type = "list")
})
