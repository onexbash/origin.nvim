local M = {}

function M.setup(opts)
   opts = opts or {}

   local selected_provider
   local provider_base_url
   local tmp_dir

   if opts.tmp_dir then
      tmp_dir = opts.tmp_dir
   else
      tmp_dir = "/tmp/onetmp"
   end

   if opts.custom_provider then
      print("custom providers not supported yet" .. "defaulting to github")
   end

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
      print("custom providers not supported yet" .. "defaulting to github")
      provider_base_url = "https://github.com"
   else
      print("unknown provider:" .. selected_provider .. "defaulting to github")
      provider_base_url = "https://github.com"
   end

   vim.keymap.set("n", "<Leader>gh", function()
      local repo_short_url =
         vim.fn.input("Enter short_url of" .. selected_provider .. "repository")
      local repo_name = repo_short_url:match("([^/]+)$")
      local repo_url = provider_base_url .. "/" .. repo_short_url
      local repo_install_url = repo_url .. "/archive/refs/heads/main.zip"
      -- make sure tmp dir exists
      os.execute("mkdir -p " .. tmp_dir)
      -- download repository as .zip
      os.execute(
         "wget -O "
            .. tmp_dir
            .. "/"
            .. repo_name
            .. ".zip "
            .. repo_install_url
      )
      -- extract .zip
      os.execute(
         "unzip -o " .. tmp_dir .. "/" .. repo_name .. ".zip -d " .. tmp_dir
      )
   end)
end

return M
