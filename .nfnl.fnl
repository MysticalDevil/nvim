(local config (require :nfnl.config))
(local default (config.default))

{;; Passed to fennel.compileString when your code is compiled.
 ;; See https://fennel-lang.org/api for more information.
 :compiler-options {}

 ;; Warning! In reality these paths are absolute and set to the root directory
 ;; of your project (where your .nfnl.fnl file is). This means even if you
 ;; open a .fnl file from outside your project's cwd the compiler will still
 ;; find your macro files. If you use relative paths like I'm demonstrating here
 ;; then macros will only work if your cwd is in the project you're working on.

 ;; They also use OS specific path separators, what you see below is just an example really.

 ;; String to set the compiler's fennel.path to before compilation.
 :fennel-path "./?.fnl;./?/init.fnl;./fnl/?.fnl;./fnl/?/init.fnl"

 ;; String to set the compiler's fennel.macro-path to before compilation.
 :fennel-macro-path "./?.fnl;./?/init-macros.fnl;./?/init.fnl;./fnl/?.fnl;./fnl/?/init-macros.fnl;./fnl/?/init.fnl"

 ;; A list of glob patterns (autocmd pattern syntax) of files that
 ;; should be compiled. This is used as configuration for the BufWritePost
 ;; autocmd, so it'll only apply to buffers you're interested in.
 ;; Will use backslashes on Windows.
 ;; Defaults to compiling all .fnl files, you may want to limit it to your fnl/ directory.
 :source-file-patterns ["fnl/**/*.fnl"]

 ;; A function that is given the absolute path of a Fennel file and should return
 ;; the equivalent Lua path, by default this will translate `fnl/foo/bar.fnl` to `lua/foo/bar.lua`.
 ;; See the "Writing Lua elsewhere" tip below for an example function that writes to a sub directory.
 :fnl-path->lua-path (fn [fnl-path]
                       (let [rel-fnl-path (vim.fn.fnamemodify fnl-path ":.")]
                         (default.fnl-path->lua-path (.. "complied/" rel-fnl-path))))}
