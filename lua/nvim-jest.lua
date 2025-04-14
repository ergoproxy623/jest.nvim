local M = {}

local config = {}

local function get_current_file_path()
  return vim.fn.expand("%:p")
end

local function get_current_folder_path()
  return vim.fn.expand("%:p:h")
end

local function create_window()
  vim.cmd("botright vnew")
end

local function focus_last_accessed_window()
  vim.cmd("wincmd p")
end

local function get_local_jest()
  local root_dir = vim.fn.finddir("node_modules/..", get_current_folder_path() .. ";")
  if root_dir == "" then
    print("ERR: Could not find local node_modules. Is this a JS/TS project?")
    return "jest"
  end
  return root_dir .. "/node_modules/jest/bin/jest.js"
end

local function run_jest(args)
  local cmd = { "terminal", config.jest_cmd }

  if args ~= nil then
    for _, v in ipairs(args) do
      table.insert(cmd, v)
    end
  end

  local jest_cmd = table.concat(cmd, " ")
  vim.api.nvim_command(jest_cmd)
end

function M.setup(user_data)
  config.jest_cmd = user_data and user_data.jest_cmd or nil
  config.silent = user_data and user_data.silent or nil

  if not config.jest_cmd or config.jest_cmd == "" then
    config.jest_cmd = get_local_jest()
  end

  if config.silent == nil then
    config.silent = true
  end
end

function M.test_project()
  create_window()
  run_jest()
  focus_last_accessed_window()
end

function M.test_file()
  local c_file = get_current_file_path()
  create_window()

  local args = {
    "--runTestsByPath",
    c_file,
    "--watch",
  }

  if config.silent then
    table.insert(args, "--silent")
  end

  run_jest(args)
  focus_last_accessed_window()
end

function M.test_file_coverage()
  local c_file = get_current_file_path()
  create_window()

  local args = {
    "--runTestsByPath",
    c_file,
    "--watch",
    "--coverage",
  }

  if config.silent then
    table.insert(args, "--silent")
  end

  run_jest(args)
  focus_last_accessed_window()
end

function M.test_single()
  local c_file = get_current_file_path()
  local line = vim.api.nvim_get_current_line()

  local _, _, test_name = string.find(line, "^%s*%a+%(['\"](.+)['\"]")

  if test_name ~= nil then
    create_window()

    local args = {
      "--runTestsByPath",
      c_file,
      "-t=" .. "'" .. test_name .. "'",
      "--watch",
      "--coverage",
    }

    run_jest(args)
    focus_last_accessed_window()
  else
    print("ERR: Could not find test name. Place cursor on line with test name.")
  end
end

function M.test_coverage()
  create_window()

  local args = {
    "--coverage",
  }

  run_jest(args)
  focus_last_accessed_window()
end

return M
