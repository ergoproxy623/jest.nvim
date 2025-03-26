if vim.g.loaded_nvim_jest then
	return
end
vim.g.loaded_nvim_jest = true

require("nvim-jest").setup()

vim.cmd([[
  command! Jest :call nvim_jest#test_project()
  command! JestFile :call nvim_jest#test_file()
  command! JestFileCoverage :call nvim_jest#test_file_coverage()
  command! JestSingle :call nvim_jest#test_single()
  command! JestCoverage :call nvim_jest#test_coverage()
]])
