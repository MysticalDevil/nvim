local M = {}

local function fs_exists(p)
  return vim.uv.fs_stat(p) ~= nil
end

local function is_gentoo()
  return fs_exists("/etc/gentoo-release") or fs_exists("/etc/portage") or fs_exists("/usr/bin/emerge")
end

local function exepath(bin)
  local p = vim.fn.exepath(bin)
  if p ~= nil and p ~= "" then
    return p
  end
  return nil
end

local function mason_bin(bin)
  local p = vim.fn.stdpath("data") .. "/mason/bin/" .. bin
  if vim.uv.fs_stat(p) then
    return p
  end
  return nil
end

local function find_bin(bin)
  return exepath(bin) or mason_bin(bin)
end

function M.check()
  local h = vim.health
  h.start("devil: ebuild")

  if is_gentoo() then
    do
      local pkgdev = find_bin("pkgdev")
      if pkgdev then
        h.ok("pkgdev: " .. pkgdev)
      else
        h.error("pkgdev missing, Gentoo package app-portage/pkgdev")
      end
    end

    do
      local pkgcheck = find_bin("pkgcheck")
      if pkgcheck then
        h.ok("pkgcheck: " .. pkgcheck)
      else
        h.error("pkgcheck missing, Gentoo package app-portage/pkgcheck")
      end
    end
  else
    h.info("non-Gentoo system detected, skip pkgdev/pkgcheck checks")
  end

  local shellcheck = find_bin("shellcheck")
  if shellcheck then
    h.ok("shellcheck: " .. shellcheck)
  else
    h.warn("shellcheck missing, optional, mason package shellcheck")
  end

  local bashls = find_bin("bash-language-server")
  if bashls then
    h.ok("bash-language-server: " .. bashls)
  else
    h.warn("bash-language-server missing, mason package bash-language-server")
  end

  local ok_ts, _ = pcall(vim.treesitter.language.add, "bash")
  if ok_ts then
    h.ok("treesitter bash parser installed")
  else
    h.warn("treesitter bash parser missing, run :TSInstall bash")
  end
end

return M
