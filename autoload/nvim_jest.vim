function nvim_jest#test_project()
  call luaeval('require("nvim-jest").test_project()')
endfunction

function nvim_jest#test_file()
  call luaeval('require("nvim-jest").test_file()')
endfunction

function nvim_jest#test_file_coverage()
  call luaeval('require("nvim-jest").test_file_coverage()')
endfunction

function nvim_jest#test_single()
  call luaeval('require("nvim-jest").test_single()')
endfunction

function nvim_jest#test_coverage()
  call luaeval('require("nvim-jest").test_coverage()')
endfunction
