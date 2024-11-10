local M = {}
local noice = require("noice")

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
      noice.notify(
         "custom providers not supported yet" .. "defaulting to github"
      )
   end

   if opts.provider then
      selected_provider = opts.provider
   else
      noice.notify(
         "no provider set in opts{}. Falling back to github (default)"
      )
      selected_provider = "github"
   end

   if selected_provider == "github" then
      provider_base_url = "https://github.com"
   elseif selected_provider == "gitlab" then
      provider_base_url = "https://gitlab.com"
   elseif selected_provider == "bitbucket" then
      provider_base_url = "https://bitbucket.org"
   elseif selected_provider == "custom" then
      noice.notify(
         "custom providers not supported yet" .. "defaulting to github"
      )
      provider_base_url = "https://github.com"
   else
      noice.notify(
         "unknown provider:" .. selected_provider .. "defaulting to github"
      )
      provider_base_url = "https://github.com"
   end

   vim.keymap.set("n", "<Leader>gh", function()
      local repo_short_url =
         vim.fn.input("short_url of " .. selected_provider .. " repository: ")
      local repo_name = repo_short_url:match("([^/]+)$")
      local local_repo_path = tmp_dir .. "/" .. repo_name
      -- make sure tmp_dir exists
      os.execute("mkdir -p " .. tmp_dir)
      -- clone repository into tmp_dir
      os.execute(
         "git clone"
            .. " "
            .. "-q"
            .. " "
            .. provider_base_url
            .. "/"
            .. repo_short_url
            .. " "
            .. local_repo_path
      )
      -- open new buffer inside the cloned repository
      vim.cmd("edit " .. local_repo_path)

      -- delete the cloned repository from tmp_dir when buffer is closed
      vim.api.nvim_create_autocmd("BufWipeout", {
         buffer = vim.api.nvim_get_current_buf(),
         callback = function()
            local delete_cmd = "rm -rf " .. local_repo_path
            local delete_result = vim.fn.system(delete_cmd)
            if vim.v.shell_error ~= 0 then
               noice.notify(
                  "Error deleting directory: " .. delete_result,
                  "error"
               )
            end
         end,
      })
   end)
end

return M
