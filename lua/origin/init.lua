local M = {}

function M.setup(opts)
   opts = opts or {}

   local selected_provider
   local provider_base_url
   if opts.provider then
      print("provider set:" .. opts.provider)
      selected_provider = opts.provider
   else
      print("no provider set in opts{}. Falling back to github (default)")
      selected_provider = "github"
   end

   if selected_provider == "github" then
      provider_base_url = "https://github.com"
   elseif selected_provider == "gitlab" then
      provider_base_url = "https://gitlab.com"
   elseif selected_provider == "bitbucket" then
      provider_base_url = "https://bitbucket.org"
   elseif selected_provider == "custom" then
      print("custom providers not supported yet")
   else
      print("unknown provider:" .. selected_provider)
   end

   vim.keymap.set("n", "<Leader>gh", function()
      local repo_short_url =
         vim.fn.input("Enter short_url of" .. selected_provider .. "repository")
      local repo_name = repo_short_url:match("([^/]+)$")
      local repo_url = provider_base_url .. "/" .. repo_short_url
      local repo_install_url = repo_url .. "/archive/refs/heads/main.zip"
      os.execute("mkdir -p /tmp/onetmp")
      os.execute(
         "wget -O /tmp/onetmp/" .. repo_name .. ".zip " .. repo_install_url
      )
   end)
end

return M
