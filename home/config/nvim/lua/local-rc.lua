-- Based on https://github.com/neovim/neovim/issues/13501

local ffi = require 'ffi'

ffi.cdef[[
 int getuid(void);
]]

local function file_owned_by_me(file)
  return ffi.C.getuid() == vim.loop.fs_stat(file).uid
end

local function load()
  local local_rc_name = '.nvimrc.lua'
  if (vim.loop.fs_stat(local_rc_name)) then
    if (file_owned_by_me(local_rc_name)) then
      dofile(local_rc_name)
    else
      print(local_rc_name .. ' exists but is not loaded. Security reason: a diffent owner.')
    end
  end
end

return {
   load = load
}
