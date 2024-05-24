-- Funktion zum Ausführen des Python-Wrapper und Zurückgeben des Ergebnisses
local function get_user_site_packages()
  local python_command =
    string.format("python3 %s", vim.fn.expand "<sfile>:p:h" .. "/lua/config/get_user_site_packages.py")
  local result = vim.fn.system(python_command)
  return result:gsub("\n", "") -- Entferne Zeilenumbrüche aus dem Ergebnis
end

-- Find python path if switch on virtual env
local function get_python_path()
  local path_table = {}
  -- Use activated virtualenv.
  if vim.env.VIRTUAL_ENV then
    table.insert(path_table, vim.fn.resolve(vim.env.VIRTUAL_ENV .. "/bin" .. "/python"))
  end

  local result = get_user_site_packages()
  table.insert(path_table, result)

  -- Fallback to system Python.
  table.insert(path_table, vim.fn.exepath "python3" or vim.fn.exepath "python" or "python")
  return path_table
end

local pythonpaths = get_python_path()

for _, path in ipairs(pythonpaths) do
  if vim.env.PYTHONPATH == nil then
    vim.env.PYTHONPATH = path
  else
    vim.env.PYTHONPATH = vim.env.PYTHONPATH .. ":" .. path
  end
end

print(vim.env.PYTHONPATH)
