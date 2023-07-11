require'nvim-treesitter.configs'.setup
{
	ensure_installed = { "c", "lua", "python", "latex", "cpp", "bash" },

	sync_install = false,
	auto_install = true,
	highlight =
	{
		enable = true,
		disable = {"latex"}
	},
}
