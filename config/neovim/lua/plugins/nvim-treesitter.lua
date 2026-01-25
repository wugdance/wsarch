-- Almost exact copy from 
-- https://github.com/nvim-lua/kickstart.nvim/pull/1657/changes
--
-- New languages will be automatically detected and installed.
return {
    'nvim-treesitter/nvim-treesitter',
    lazy = false,
    build = ':TSUpdate',
    branch = 'main',
    -- [[ Configure Treesitter ]] See `:help nvim-treesitter-intro`
    config = function()
        ---@param buf integer
        ---@param language string
        local function treesitter_try_attach(buf, language)
            -- Check if parser exists and load it.
            if not vim.treesitter.language.add(language) then
                return
            end
            -- Enables syntax highlighting and other treesitter features.
            vim.treesitter.start(buf, language)

            -- Enables treesitter based folds.
            -- For more info on folds see `:help folds`.
            -- vim.wo.foldexpr = 'v:lua.vim.treesitter.foldexpr()'

            -- Enables treesitter based indentation.
            vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
        end

        local available_parsers = require('nvim-treesitter').get_available()
        vim.api.nvim_create_autocmd('FileType', {
            callback = function(args)
                local buf, filetype = args.buf, args.match
                local language = vim.treesitter.language.get_lang(filetype)
                if not language then
                    return
                end

                local installed_parsers = require('nvim-treesitter').get_installed 'parsers'

                if vim.tbl_contains(installed_parsers, language) then
                    -- Enable the parser if it is installed.
                    treesitter_try_attach(buf, language)
                elseif vim.tbl_contains(available_parsers, language) then
                    -- If a parser is available in `nvim-treesitter` 
                    -- enable it after ensuring it is installed.
                    require('nvim-treesitter').install(language):await(function()
                        treesitter_try_attach(buf, language)
                    end)
                else
                    -- Try to enable treesitter features in case the parser 
                    -- exists but is not available from `nvim-treesitter`.
                    treesitter_try_attach(buf, language)
                end
            end,
        })

        -- Ensure basic parser are installed.
        local parsers = { 
            'bash',
            'c',
            'diff',
            'html',
            'lua',
            'luadoc',
            'markdown',
            'markdown_inline',
            'query',
            'vim',
            'vimdoc',
        }
        require('nvim-treesitter').install(parsers)
    end,
}
