local gl = require('galaxyline')
local condition = require('galaxyline.condition')
local vcs = require('galaxyline.provider_vcs')

local fn = vim.fn
local cmd = vim.cmd
local api = vim.api
local bo = vim.bo

local section = gl.section

gl.short_line_list = {"startify", "vim-plug", "vista", "qf"}

local colours = {
	bg0 = "#2e3440",
	bg1 = "#4c566a",
	fg = "#d8dee9",
	nord7 = "#8fbcbb", -- blue/green
	nord8 = "#88c0d0", -- blue
	nord9 = "#81a1c1", -- blue
	nord10 = "#5e81ac", -- blue
	nord11 = "#bf616a", -- red
	nord12 = "#d08770", -- orange
	nord13 = "#ebcb8b", -- yellow
	nord14 = "#a3be8c", -- green
}

local leftsep = {
	LeftSeparator = {
		provider = function ()
			return ''
		end,
		highlight = {colours.bg1},
	}
}

local rightsep = {
	RightSeparator = {
		provider = function ()
			return ''
		end,
		highlight = {colours.bg1},
	},
}

local padding = {
	Padding = {
		provider = function ()
			return ' '
		end
	}
}

section.left[1] = leftsep

section.left[2] = {
	ViMode = {
		provider = function ()
			local modecols = {
				N = colours.nord8,
				T = colours.nord8,
				['!'] = colours.nord8,
				V = colours.nord7,
				I = colours.nord14,
				R = colours.nord14,
				C = colours.nord12,
			}
			local mode = string.upper(
				string.gsub(
					string.sub(fn.mode(), 1, 1), "", "V"
				):gsub("", "S")
			)
			cmd("hi GalaxyViMode guifg=" .. modecols[mode])
			return mode
		end,
		separator = '',
		separator_highlight = {colours.bg1},
		highlight = {colours.fg, colours.bg1, "bold"},
	}
}

section.left[3] = padding
section.left[4] = leftsep

local function shortenPath(path)

	while #path + 2 > (fn.winwidth(fn.winnr()) - 50) do -- 50 is approx width of right section
		local split = vim.split(path, '/')
		if #split < 2 then
			break
		end
		path = '<' .. table.concat(
			{unpack(
				split, 2
			)},
			'/'
		)
	end

	-- breaks if file path begins with `<`, but you shouldn't be putting that in a file name anyway
	return string.gsub(path, '^%<', '</')
end

section.left[5] = {
	FileName = {
		provider = function ()
			-- return string.gsub(fileinfo.get_current_file_name('', ''), '^%s*(.-)%s*$', '%1')
			local icon = ''
			local path = shortenPath(fn.fnamemodify(fn.expand('%'), ':~:.'))
			if path == '' then
				path = '[No File]'
			end
			if fn.getbufinfo(fn.bufnr('%'))[1].changed == 1 then
				icon = ' [+]'
			end
			return path .. icon
		end,
		highlight = {colours.fg, colours.bg1},
		separator = '',
		separator_highlight = {colours.bg1},
	}
}

local function showgit()
	return condition.check_git_workspace and fn.winwidth(fn.winnr()) > 70
end

local function strip(text)
	if text then
		return string.gsub(text, "%s+", "")
	end
end

section.left[6] = {
	GitSep = {
		provider = function ()
			if showgit() and (vcs.diff_remove() or vcs.diff_add() or vcs.diff_modified()) then
				return ' '
			end
		end,
		highlight = {colours.bg1},
	},
}

section.left[8] = {
	GitAdditions = {
		provider = function ()
			local space = ''
			if vcs.diff_modified() then
				space = ' '
			end
			if vcs.diff_add() then
				return strip(vcs.diff_add()) .. space
			end
		end,
		icon = "+",
		highlight = {colours.nord14, colours.bg1},
		condition = showgit
	}
}

section.left[9] = {
	GitModifications = {
		provider = function ()
			local space = ''
			if vcs.diff_remove() then
				space = ' '
			end
			if vcs.diff_modified() then
				return strip(vcs.diff_modified()) .. space
			end
		end,
		icon = "~",
		highlight = {colours.nord13, colours.bg1},
		condition = showgit
	}
}

section.left[10] = {
	GitDeletions = {
		provider = function ()
			return strip(vcs.diff_remove())
		end,
		icon = "-",
		highlight = {colours.nord11, colours.bg1},
		condition = showgit
	}
}

section.left[11] = {
	GitSepRight = {
		provider = function ()
			if showgit() and (vcs.diff_remove() or vcs.diff_add() or vcs.diff_modified()) then
				return ''
			end
		end,
		highlight = {colours.bg1},
	}
}

section.left[12] = {
	ResetColour = {
		provider = function ()
			return ''
		end,
		highlight = {colours.bg0},
	}
}

section.right[1] = {
	FileType = {
		provider = function ()
			return bo.filetype
		end,
		condition = function ()
			local ft = bo.filetype
			return not (not ft or ft == '')
		end,
		highlight = {colours.fg, colours.bg1},
		separator = '',
		separator_highlight = {colours.bg1},
	}
}

section.right[2] = {
	CondRightSeparator = {
		provider = function ()
			return ''
		end,
		highlight = {colours.bg1},
		condition = function ()
			local ft = bo.filetype
			return not (not ft or ft == '')
		end,
	},
}
section.right[3] = padding

local function getalediag()
	local getcount = fn["ale#statusline#Count"]
	local bufnr = fn.bufnr('%')
	local errorcount = getcount(bufnr).error
	local warningcount = getcount(bufnr).total - errorcount
	return {
		errors = errorcount,
		warnings = warningcount
	}
end

section.right[4] = {
	LineNCharN = {
		provider = function ()
			return fn.line('.') .. ':' .. fn.col('.')
		end,
		highlight = {colours.nord9, colours.bg1},
		separator = '',
		separator_highlight = {colours.bg1},
	}
}

section.right[5] = rightsep
section.right[6] = padding

section.right[7] = {
	PercentTotLines = {
		provider = function ()
			local curline = fn.line('.')
			local totlines = fn.line('$')
			local percent = math.modf((curline / totlines) * 100)
			return percent .. '%/' .. totlines
		end,
		highlight = {colours.nord9, colours.bg1},
		separator = '',
		separator_highlight = {colours.bg1},
	}
}

section.right[8] = rightsep
section.right[9] = padding


section.right[10] = {
	ALEWarning = {
		provider = function ()
			return "W:" .. getalediag().warnings
		end,
		highlight = {colours.nord13, colours.bg1},
		separator = '',
		separator_highlight = {colours.bg1},
	}
}

section.right[11] = {
	nothing = {
		provider = function ()
			return ' '
		end,
		highlight = {colours.fg, colours.bg1},
	}
}

section.right[12] = {
	ALEError = {
		provider = function ()
			return "E:" .. getalediag().errors
		end,
		highlight = {colours.nord11, colours.bg1},
	}
}

section.right[13] = rightsep

section.short_line_left[1] = leftsep

section.short_line_left[2] = {
	Name = {
		provider = function ()
			return bo.filetype:gsub("^%l", string.upper)
		end,
		highlight = {colours.fg, colours.bg1},
		separator = '',
		separator_highlight = {colours.bg1},
	}
}
