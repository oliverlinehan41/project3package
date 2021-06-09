test_that("multiplication works", {
  expect_equal(2 * 2, 4)
})

test_that("Function returns double", {
  expect_type(object = my_lm(lifeExp ~ gdpPercap + continent, my_gapminder), type = "double")
})

