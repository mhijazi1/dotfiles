return {
  'nvim-orgmode/orgmode',
  name = 'orgmode',
  event = 'VeryLazy',
  ft = 'org',
  dependencies = {
    'akinsho/org-bullets.nvim',
  },
  config = function()
    require('orgmode').setup({
      org_agenda_files = {'~/org/*', '~/org/**/*'},
      org_default_notes_file = '~/org/refile.org',
      org_todo_keywords = {'TODO', 'NEXT', 'WAITING', 'IN-PROGRESS', '|', 'DONE', "DROPPED"},
      org_startup_indent = true,
      org_blank_before_new_entry = { heading = false, plain_list_item = false },
      org_hide_emphasis_markers = true,
      org_todo_keyword_faces = {
        TODO = ':foreground yellow',
        NEXT = ':foreground red',
        WAITING = ':foreground orange',
        ['IN-PROGRESS'] = ':foreground green',
        DONE = ':foreground black :background green',
        DROPPED = ':foreground black :background red',
      },
      win_split_mode = 'tabnew',
    })

    require('org-bullets').setup()
  end
}
