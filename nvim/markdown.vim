try
	echo vimmarkdownwritemode
catch /.*/
	let vimmarkdownwritemode = 0
endtry

if vimmarkdownwritemode
	set notermguicolors
	Goyo
	colorscheme nord
	let vimmarkdownwritemode = 0
else
	set termguicolors

	highlight Normal guibg=#f1f1f1 guifg=#424242
	highlight LineNr guibg=#f1f1f1
	highlight NonText guifg=#f1f1f1

	highlight markdownH1 guifg=#424242 cterm=bold gui=bold
	highlight markdownH2 guifg=#424242 cterm=bold gui=bold
	highlight markdownH3 guifg=#424242 cterm=bold gui=bold
	highlight markdownH4 guifg=#424242 cterm=bold gui=bold
	highlight markdownH5 guifg=#424242 cterm=bold gui=bold
	highlight markdownH6 guifg=#424242 cterm=bold gui=bold

	highlight markdownHeadingDelimiter guifg=#424242

	highlight markdownBold guifg=#424242 cterm=bold gui=bold
	highlight markdownItalic guifg=#424242 cterm=underline gui=underline
	highlight markdownBoldItalic guifg=#424242 cterm=underline,bold gui=underline,bold

	highlight markdownItalicDelimiter guifg=#424242
	highlight markdownBoldDelimiter guifg=#424242
	highlight markdownBoldItalicDelimiter guifg=#424242

	highlight markdownListMarker guifg=#424242
	highlight markdownOrderedListMarker guifg=#424242

	highlight Cursor guibg=#20bbfc

	let vimmarkdownwritemode = 1

	Goyo
endif
