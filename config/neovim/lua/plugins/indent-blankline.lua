return {
	"lukas-reineke/indent-blankline.nvim",
	event = "VeryLazy",
	main = "ibl",
	---@module "ibl"
	---@type ibl.config
	opts = {
		scope = {
			enabled = false,
			show_start = false,
			show_end = false,
		},
	},
}
