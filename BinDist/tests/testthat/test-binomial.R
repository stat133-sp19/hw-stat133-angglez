context("Binomial")

test_that("bin_choose computes correct number of combinations", {
  expect_error(bin_choose(10,20))
  expect_equal(bin_choose(5,2), 10)
  expect_equal(bin_choose(8,7), 8)
})

test_that("bin_probability computs correct binomial prob", {
  expect_error(bin_probability(10,20.1,0.1))
  expect_error(bin_probability(-10,20,0.1))
  expect_error(bin_probability(10,20,2))
  expect_equal(bin_probability(2,5,0.5), 0.3125)
})

test_that("bin_distribution computes the binomial distribution", {
  expect_equal(bin_distribution(10,0.3)$success, 0:10)
  expect_is(bin_distribution(10,0.3), c('bindis','data.frame'))
  expect_equal(bin_distribution(10,0.3)$probability, c(0.0282475249,0.1210608210,0.2334744405,0.2668279320,0.2001209490,0.1029193452,0.0367569090,0.0090016920,0.0014467005,0.0001377810,0.0000059049))
})

test_that("bin_cumulative computes the cumulative binomial distribution", {
  expect_equal(bin_cumulative(10,0.3)$success, 0:10)
  expect_is(bin_cumulative(10,0.3), c('bincum','data.frame'))
  expect_equal(bin_cumulative(10,0.3)$probability, c(0.0282475249,0.1210608210,0.2334744405,0.2668279320,0.2001209490,0.1029193452,0.0367569090,0.0090016920,0.0014467005,0.0001377810,0.0000059049))
  expect_equal(bin_cumulative(10,0.3)$cumulative, c(0.02824752,0.14930835,0.38278279,0.64961072,0.84973167,0.95265101,0.98940792,0.99840961,0.99985631,0.99999410,1.00000000))
})
