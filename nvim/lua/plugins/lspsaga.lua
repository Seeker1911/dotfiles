return {
	"nvimdev/lspsaga.nvim",
	event = "LspAttach",
	dependencies = {
		"nvim-treesitter/nvim-treesitter",
		"nvim-tree/nvim-web-devicons",
	},
	config = function()
		require("lspsaga").setup({
			-- UI
			ui = {
				winblend = 10,
				border = "rounded",
				colors = {
					normal_bg = "#002b36",
				},
			},
			-- Hover
			hover = {
				max_width = 0.9,
				max_height = 0.8,
				open_link = "gx",
				open_cmd = "!chrome",
			},
			-- Diagnostic
			diagnostic = {
				on_insert = false,
				on_insert_follow = false,
				insert_winblend = 0,
				show_code_action = true,
				show_layout = "float",
				show_normal_height = 10,
				jump_num_shortcut = true,
				max_width = 0.8,
				max_height = 0.6,
				max_show_width = 0.9,
				max_show_height = 0.6,
				text_hl_follow = true,
				border_follow = true,
				extend_relatedInformation = false,
				keys = {
					exec_action = "o",
					quit = "q",
					expand_or_jump = "<CR>",
					quit_in_show = { "q", "<ESC>" },
				},
			},
			-- Code action
			code_action = {
				num_shortcut = true,
				show_server_name = false,
				extend_gitsigns = true,
				keys = {
					quit = "q",
					exec = "<CR>",
				},
			},
			-- Lightbulb
			lightbulb = {
				enable = true,
				sign = true,
				enable_in_insert = true,
				sign_priority = 40,
				virtual_text = false,
			},
			-- Preview
			preview = {
				lines_above = 0,
				lines_below = 10,
			},
			-- Scroll preview
			scroll_preview = {
				scroll_down = "<C-f>",
				scroll_up = "<C-b>",
			},
			-- Request timeout
			request_timeout = 2000,
			-- Finder
			finder = {
				max_height = 0.5,
				left_width = 0.4,
				methods = {
					tyd = "textDocument/typeDefinition",
				},
				default = "ref+imp+tyd+def",
				layout = "float",
				silent = false,
				filter = {},
				fname_sub = nil,
				sp_inexist = false,
				sp_global = false,
				ly_botright = false,
				keys = {
					shuttle = "[w",
					toggle_or_req = "o",
					vsplit = "s",
					split = "i",
					tabe = "t",
					tabnew = "r",
					quit = "q",
					close = "<C-c>k",
				},
			},
			-- Definition
			definition = {
				width = 0.6,
				height = 0.5,
				save_pos = false,
				keys = {
					edit = "<C-c>o",
					vsplit = "<C-c>v",
					split = "<C-c>i",
					tabe = "<C-c>t",
					tabnew = "<C-c>n",
					quit = "q",
					close = "<C-c>k",
				},
			},
			-- Rename
			rename = {
				in_select = true,
				auto_save = false,
				project_max_width = 0.5,
				project_max_height = 0.5,
				keys = {
					quit = "<C-k>",
					exec = "<CR>",
					mark = "x",
					confirm = "<CR>",
					in_select = "<Tab>",
					in_preview = "<M-p>",
					auto_save = "<leader>s",
				},
			},
			-- Outline
			outline = {
				win_position = "right",
				win_width = 30,
				preview_width = 0.4,
				show_detail = true,
				auto_preview = true,
				auto_close = true,
				close_after_jump = false,
				layout = "normal",
				max_height = 0.5,
				left_width = 0.3,
				keys = {
					toggle_or_jump = "o",
					quit = "q",
					jump = "e",
				},
			},
			-- Callhierarchy
			callhierarchy = {
				layout = "float",
				left_width = 0.2,
				keys = {
					edit = "e",
					vsplit = "s",
					split = "i",
					tabe = "t",
					close = "q",
					quit = "q",
					shuttle = "[w",
					toggle_or_req = "u",
				},
			},
			-- Symbol in winbar
			symbol_in_winbar = {
				enable = true,
				separator = " › ",
				hide_keyword = false,
				ignore_patterns = nil,
				show_file = true,
				folder_level = 1,
				color_mode = true,
				dely = 300,
			},
			-- Beacon
			beacon = {
				enable = true,
				frequency = 7,
			},
		})
	end,
}
