-- Clear highlights on search when pressing <Esc> in normal mode
vim.keymap.set(
    'n',
    '<Esc>',
    '<cmd>nohlsearch<CR>',
    {desc = 'Clear highlighted search matches.'}
)
