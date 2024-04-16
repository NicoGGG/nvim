return {
  "epwalsh/obsidian.nvim",
  version = "*", -- recommended, use latest release instead of latest commit
  lazy = true,
  ft = "markdown",
  -- Replace the above line with this if you only want to load obsidian.nvim for markdown files in your vault:
  -- event = {
  --   -- If you want to use the home shortcut '~' here you need to call 'vim.fn.expand'.
  --   -- E.g. "BufReadPre " .. vim.fn.expand "~" .. "/my-vault/**.md"
  --   "BufReadPre path/to/my-vault/**.md",
  --   "BufNewFile path/to/my-vault/**.md",
  -- },
  dependencies = {
    -- Required.
    "nvim-lua/plenary.nvim",

    -- see below for full list of optional dependencies 👇
  },
  config = function()
    require("obsidian").setup({
      workspaces = {
        {
          name = "personal",
          path = "~/Workspace/obsidian/main",
        },
        {
          name = "work",
          path = "~/Workspace/obsidian/equidia",
        },
      },
      daily_notes = {
        folder = "dailies",
      },
      new_notes_location = "notes_subdir",
      -- Optional, customize how names/IDs for new notes are created.
      note_id_func = function(title)
        -- Create note IDs in a Zettelkasten format with a timestamp and a suffix.
        -- In this case a note with the title 'My new note' will be given an ID that looks
        -- like '1657296016-my-new-note', and therefore the file name '1657296016-my-new-note.md'
        local suffix = ""
        if title ~= nil then
          -- If title is given, transform it into valid file name.
          suffix = title:gsub(" ", "-"):gsub("[^A-Za-z0-9-]", ""):lower()
        else
          -- If title is nil, just add 4 random uppercase letters to the suffix.
          for _ = 1, 4 do
            suffix = suffix .. string.char(math.random(65, 90))
          end
        end
        return tostring(os.time()) .. "-" .. suffix
      end,
    })
    -- Keybinds

    local nmap = function(keys, func, desc)
      if desc then
        desc = "Obsidian: " .. desc
      end

      vim.keymap.set("n", keys, func, { desc = desc })
    end
    nmap("<leader>ob", "<CMD>ObsidianBacklinks<CR>", "Obsidian List [B]acklinks")
    nmap("<leader>oo", "<CMD>ObsidianOpen<CR>", "Obsidian [O]pen in App")
    nmap("<leader>on", "<CMD>ObsidianNew<CR>", "Obsidian [N]ew Note")
    nmap("<leader>ot", "<CMD>ObsidianToday<CR>", "Obsidian [T]oday Daily Note")
    nmap("<leader>oy", "<CMD>ObsidianYesterday<CR>", "Obsidian [Y]esterday Daily Note")
    nmap("<leader>op", "<CMD>ObsidianQuickSwitch<CR>", "Obsidian Quick Switch")
    nmap("<leader>ow", "<CMD>ObsidianWorkspace<CR>", "Obsidian Change [W]orkspace")
    nmap("<leader>ol", "<CMD>ObsidianTags<CR>", "Obsidian [L]ist Tags")
    nmap("<leader>of", "<CMD>ObsidianFollowLink<CR>", "Obsidian [F]ollow Link")
  end,
}
