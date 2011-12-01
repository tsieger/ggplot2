context("Scales: breaks and labels")

init_scale <- function(...) {
  sc <- scale_x_discrete(...)
  scale_train(sc, factor(1:100))
  expect_that(length(scale_limits(sc)), equals(100))
  sc
}


test_that("labels must match breaks", {
  expect_that(scale_x_discrete(breaks = 1:3, labels = 1:2),
    throws_error("unequal lengths"))
  expect_that(scale_x_continuous(breaks = 1:3, labels = 1:2),
    throws_error("unequal lengths"))
  
})

test_that("discrete labels match breaks", {
  
  sc <- init_scale(breaks = 0:5 * 10)
  expect_equal(length(scale_breaks(sc)), 5)
  expect_equal(length(scale_labels(sc)), 5)
  expect_equivalent(scale_labels(sc), scale_breaks(sc))

  sc <- init_scale(breaks = 0:5 * 10, labels = letters[1:6])
  expect_equal(length(scale_breaks(sc)), 5)
  expect_equal(length(scale_labels(sc)), 5)
  expect_equal(scale_labels(sc), letters[2:6])

  sc <- init_scale(breaks = 0:5 * 10, labels = 
    function(x) paste(x, "-", sep = ""))
  expect_equal(scale_labels(sc), c("10-", "20-", "30-", "40-", "50-"))
  
  pick_5 <- function(x) sample(x, 5)
  sc <- init_scale(breaks = pick_5)
  expect_equal(length(scale_breaks(sc)), 5)
  expect_equal(length(scale_labels(sc)), 5)
  
})
