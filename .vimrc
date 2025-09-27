set nocompatible              " be iMproved, required
filetype off                  " required

" Include distribution plugins
let g:tex_flavor="latex"

" Install Vim-Plug if it is not found
let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim')) 
    silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
    autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif


call plug#begin()
    " Allow vim-plug to update itself
    Plug 'junegunn/vim-plug'

    "Plug 'vim-airline/vim-airline'
    " Make sure we have default colorschemes
    "Plug 'vim/colorschemes'

    " Get catppuccin theme
    Plug 'catppuccin/vim', { 'as': 'catppuccin' }

    " For wiki:
    "Plug 'vimwiki/vimwiki'
    " For Encryption
    Plug 'jamessan/vim-gnupg'

    " Lsp/Autocomplete Plugins
    Plug 'yegappan/lsp'
    Plug 'girishji/vimcomplete'
    Plug 'girishji/ngram-complete.vim'

    " For writing not-code
    Plug 'junegunn/goyo.vim'
    Plug 'junegunn/limelight.vim'
    Plug 'godlygeek/tabular'
    Plug 'preservim/vim-markdown'
    " Can also be used for programming
    Plug 'majutsushi/tagbar'

    " For processing highlighted output with a program (the ! command) <Extremely useful>
    Plug 'vim-scripts/vis'

    " For ascii-art
    Plug 'vim-scripts/DrawIt'

    " For ansi esc seq
    Plug 'powerman/vim-plugin-AnsiEsc'

    " Autocompile latex, super useful
    Plug 'lervag/vimtex'

    " For spelling (super useful if you want to useCamelCaseAndNotSeeRed)
    Plug 'kamykn/spelunker.vim'

    " For documentation skeleton generation
    Plug 'kkoomen/vim-doge', { 'do': { -> doge#install() } }

    " Syntax Plugs
    Plug 'pboettch/vim-cmake-syntax'
    Plug 'octol/vim-cpp-enhanced-highlight'
    Plug 'tikhomirov/vim-glsl'
    Plug 'dcharbon/vim-flatbuffers'
    Plug 'udalov/kotlin-vim'
    Plug 'terrastruct/d2-vim'
    Plug 'janiczek/vim-latte'

    " For better abbreviations
    Plug 'tpope/vim-abolish'
    " For surrounding things
    Plug 'tpope/vim-surround'
    " For better session management
    Plug 'tpope/vim-obsession'
    " For heuristicly setting tab width 'n stuff
    Plug 'tpope/vim-sleuth'
    " For git stuff
    Plug 'tpope/vim-fugitive'
    " For enabling repeating some plugins with "."
    Plug 'tpope/vim-repeat'
    " For commenting stuff out
    Plug 'tpope/vim-commentary'
    " Better netrwc
    Plug 'tpope/vim-vinegar'

    " For cheating...
    Plug 'dbeniamine/cheat.sh-vim'

    " Format tables
    Plug 'dhruvasagar/vim-table-mode'
call plug#end()


function StopForLoopAbbrev()
    iabbrev int int
    " Reset escape key
    imap <ESC> <ESC>
endfunction

function ForLoopAbbrev()
    iabbrev int int i = 0; i <; i++<ESC>?;<CR>i
    " Cancel the abbreviation if we enter normal mode
    imap <ESC> <ESC>:call StopForLoopAbbrev()<CR>
endfunction

function CppConfigureAbbrevs()
    " Auto {} for while, if and for
    "iabbrev while while() {<CR>}<ESC>?)<CR>i
    "iabbrev if if() {<CR>}<ESC>?)<CR>i
    "iabbrev else else {<CR>}<ESC>?{<CR>o
    "iabbrev elif else if () {<CR>}<ESC>?)<CR>i
    "iabbrev for for() {<CR>}<ESC>?)<CR>:call ForLoopAbbrev()<CR>i

    " For class
    "autocmd FileType cpp iabbrev class class TMP {<CR>private:<CR>protected:<CR>public:<CR>};<ESC>k<i{?TMP<CR>ciw
endfunction

function ConfigureAbbrevs() 
    " Create a table in latex easily
    iab ltab \begin{center} <CR>\begin{tabular}<CR>\end{tabular}<CR>\end{center}

    " Auto fix miss-types
    Abolish taht that
    Abolish teh the
    Abolish flaot float
    Abolish viod void
    Abolish ned end
    Abolish catigorie category
    Abolish mieles miles
    Abolish awnser answer
    Abolish feild{s} field{s}
    Abolish sais says
    Abolish beign being
    Abolish Miels Miles

    autocmd FileType c,cpp call CppConfigureAbbrevs()
endfunction

" Variables related to how vim formats code (EX: background, tablength,
" etc...)
function SetupStyleVariables()
    syntax on
    filetype plugin indent on    " required
    filetype plugin on
    set autoindent
    set smartindent
    "set expandtab
    set number
    "set shiftwidth=4
    "set tabstop=4
    set background=dark
    colorscheme catppuccin_macchiato
    " no windows lines
    set nobomb
    " better line break (does linebreak by word)
    set linebreak
    " Add indentation after linebreak
    set breakindentopt=shift:4

    " Make tabs visible
    set listchars=tab:⎼\ ,trail:·,extends:>
    set list

    " No borders between windows
    set fillchars=vert:\ 

    " Writing (not-code) stuff
    autocmd! User GoyoEnter Limelight
    autocmd! User GoyoLeave Limelight!
endfunction

function SetupNonPluginRelatedVariables()
    " Allow some term gui stuff to work
    set termguicolors
    " Allow backspace to work
    set backspace=2
    " Make it so auto completion does not use included files (it takes too long)
    autocmd filetype :set complete-=i
    " For spelling
    set dictionary+=/usr/share/dict/american-english
    set undodir=~/.vim/undo
    set undofile
    " Make it so vim looks recursively through the current directory.
    set path +=**

    " Spell checking
    set nospell

    " Enable mouse
    set mouse=a

    " Make completion more like bash
    set wildmode=longest,list,full
    " But add a menu, just for fun
    set wildmenu


    " Render all languages in markdown
    let g:markdown_fenced_languages = ['go', 'c', 'd2', 'json', 'sh', 'ksh=sh', 'bash=sh', 'html', 'javascript', 'js=javascript', 'css', 'python']

    call SetupStyleVariables()
endfunction

function SetupNonPluginRelatedMappings()
    nmap <Space> <Leader>
    vmap <Space> <Leader>
    " Allow saving of files as sudo when I forgot to start vim using sudo
    cmap w!! w !sudo tee > /dev/null %

    " Allow for easy grepping (and adding the things found to the quickfix list
    nnoremap <Leader>g :cexpr system('rg  --vimgrep ')<Left><Left><Left><Left><Left><Left><Left><Left><Left><Left><Left><Left><Left>

    " Build the current project (assumes build files are in *build*)
    nnoremap <Leader>B :make -C *build*
    " Make it so you can use * in visual mode
    vnoremap // y/\V<C-R>=escape(@",'/\')<CR><CR>

    "inoremap <tab> <c-n>
    "inoremap <S-tab> <c-p>
    " Make it so that Q copys to the System Copy Buffer
    vnoremap <Leader>y "+y
    nnoremap <Leader>y "+y
    vnoremap <Leader>p "+p
    nnoremap <Leader>p "+p

    nnoremap <Leader>f :find 
endfunction

function SetupNonPluginRelatedConfig()
    call SetupNonPluginRelatedVariables()
    call SetupNonPluginRelatedMappings()
endfunction



function SetupLspConfig()
    let g:lspServers = [#{
        \      name: 'clang',
        \      filetype: ['c', 'cpp'],
        \      path: '/usr/bin/clangd',
        \      args: ['--background-index']
        \ }, #{
        \ name: 'typescript-language-server',
        \ filetype: ['typescript'],
        \ path: '/usr/bin/typescript-language-server',
        \ args: ['--stdio']
        \ }, #{
        \ name: 'harper-ls',
        \ filetype: ['markdown', 'txt'],
        \ path: '/usr/bin/harper-ls',
        \ args: ['--stdio']
        \ }, #{
        \ name: 'python-lsp-server',
        \ filetype: ['python'],
        \ path: '/usr/bin/pylsp',
        \ args: []
        \ }, #{
        \ name: 'godot',
        \ filetype: ['gdscript'],
        \ path: '/usr/bin/ncat',
        \ args: ['localhost', '6005']
        \ }]
    autocmd VimEnter * call LspAddServer(g:lspServers)

    let g:lspOpts = #{autoHighlightDiags: v:false,  useQuickfixForLocations: v:true, showInlayHints: v:false}
    autocmd VimEnter * call LspOptionsSet(g:lspOpts)

    let g:vimCompleteOptions = #{ 
                \ lsp:    #{ enable: v:true, priority: 8, filetypes: ['*'], maxCount: 200 }, 
                \ path:   #{ enable: v:true, priority: 7, filetypes: ['*'], maxCount: 20, },
                \ ngram:  #{ enable: v:true, priority: 5, maxCount: 5,  bigram: v:true,  filetypes: ['text', 'markdown', 'd2'],  filetypesComments: ['*'],  },
                \ buffer: #{ enable: v:true, priority: 1, filetypes: ['*'], }}

    " Setup vimcomplete options
    autocmd VimEnter * call VimCompleteOptionsSet(g:vimCompleteOptions)

    " Enable vimcomplete
    autocmd VimEnter * VimCompleteEnable

    autocmd FileType c,cpp,typescript nnoremap gd :LspGotoDeclaration<CR> 
    autocmd FileType c,cpp,typescript nnoremap gD :LspGotoDefinition<CR>

    "autocmd FileType c,cpp,typescript nnoremap <space> :LspHover<CR>
    nnoremap Dc :LspDiagFirst<CR>
    nnoremap Dn :LspDiagNextWrap<CR>
    nnoremap DN :LspDiagPrevWrap<CR>

    "nnoremap <Enter> :LspCodeAction<CR>
endfunction

function SetupPluginRelatedConfig()
    " For Openning Encrypted Files
    let g:GPGFilePattern = '*.\(gpg\|asc\|pgp\)\(.md\)\='
    " Change wiki format to markdown
    let g:vimwiki_list = [{'path': '~/vimwiki/',
                      \ 'syntax': 'markdown', 'ext': 'md'}]
    " Do gridtables by default
    let g:table_mode_corner_corner='+'
    let g:table_mode_header_fillchar='='

    " For generating Documentation Skeletons with doGe
    nnoremap <Leader>D :DogeGenerate <CR>
    " Lets me see ansi color esc seq with :log
    command Log colorscheme elflord | %s/\[39m//g | AnsiEsc

    "let g:airline#extensions#tabline#enabled = 1

    call SetupLspConfig()
endfunction

call SetupNonPluginRelatedConfig()
call SetupPluginRelatedConfig()
" Call ConfigureAbbrevs when we open vim (but after plugins are loaded)
autocmd VimEnter * call ConfigureAbbrevs()

packadd! termdebug
