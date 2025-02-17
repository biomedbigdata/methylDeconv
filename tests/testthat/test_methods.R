suppressMessages(library(methylDeconv))
suppressMessages(library(minfiData))
suppressMessages(library(minfi))

methyl_set <- minfiData::MsetEx
ratio_set <- minfi::ratioConvert(methyl_set)
beta_matrix <- minfi::getBeta(ratio_set)

# write.csv()

test_that("EpiDISH works", {
  epidish_res <- methylDeconv::run_epidish(beta_matrix = beta_matrix, mode='RPC')$estF
  check_result <- as.matrix(read.csv("test_results/epidish.csv",
                                     row.names = 1,
                                     check.names = FALSE
  ))
  expect_equal(
    info = "deconvolution result is correct", object = epidish_res,
    expected = check_result, tolerance = 1e-3
  )
})


test_that("methylCC works", {
  methylcc_res <- as.matrix(methylDeconv::run_methylcc(methyl_set = methyl_set))
  check_result <- as.matrix(read.csv("test_results/methylcc.csv",
                                     row.names = 1,
                                     check.names = FALSE
  ))
  expect_equal(
    info = "deconvolution result is correct", object = methylcc_res,
    expected = check_result, tolerance = 1e-3
  )
})

test_that("FlowSorted works", {
  flowSorted_res <- methylDeconv::run_flowsortedblood(methyl_set = methyl_set)$prop
  check_result <- as.matrix(read.csv("test_results/flowsorted.csv",
                                     row.names = 1,
                                     check.names = FALSE
  ))
  expect_equal(
    info = "deconvolution result is correct", object = flowSorted_res,
    expected = check_result, tolerance = 1e-3
  )
})

test_that("MethylResolver works", {
  methylResolver_res <- as.matrix(methylDeconv::run_methylresolver(beta_matrix = beta_matrix, alpha = 1)$result_fractions)
  check_result <- as.matrix(read.csv("test_results/methylresolver.csv",
                                     row.names = 1,
                                     check.names = FALSE
  ))
  expect_equal(
    info = "deconvolution result is correct", object = methylResolver_res,
    expected = check_result, tolerance = 1e-3
  )
})

test_that("MethAtlas works", {
  meth_atlas_res <- methylDeconv::run_meth_atlas(beta_matrix = beta_matrix)
  check_result <- as.matrix(read.csv("test_results/meth_atlas.csv",
                                     row.names = 1,
                                     check.names = FALSE
  ))
  expect_equal(
    info = "deconvolution result is correct", object = meth_atlas_res,
    expected = check_result, tolerance = 1e-3
  )
})
