test_that("multiplication works", {
  expect_equal(2 * 2, 4)
})

test_that("Standard Error is Numeric", {
  expect_type(my_t_test(my_gapminder$lifeExp, "two.sided", 60), type = "list")
})


