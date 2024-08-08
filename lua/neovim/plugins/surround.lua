return {
	"kylechui/nvim-surround",
	event = { "bufreadpre", "bufnewfile" },
	version = "*", -- use for stability; omit to use `main` branch for the latest features
	config = function()
		require("nvim-surround").setup({
			-- keymaps = {
			-- 	insert = "<c-g>s",
			-- 	insert_line = "<c-g>s",
			-- 	normal = "ys",
			-- 	normal_cur = "yss",
			-- 	normal_line = "ys",
			-- 	normal_cur_line = "yss",
			-- 	visual = "gss",
			-- 	visual_line = "gs",
			-- 	delete = "ds",
			-- 	change = "cs",
			-- 	change_line = "cs",
			-- },

		})
	end
}
--     surr*ound_words             ysiw)           (surround_words)
--     *make strings               ys$"            "make strings"
--     [delete ar*ound me!]        ds]             delete around me!
--     remove <b>html t*ags</b>    dst             remove html tags
--     'change quot*es'            cs'"            "change quotes"
--     <b>or tag* types</b>        csth1<cr>       <h1>or tag types</h1>
--     delete(functi*on calls)     dsf             function calls
--
-- y s (быстро нажимаем) - активация плагина для выделения одного слова
-- w - выделяем слово и далее уже нажимаем,что надо кавыычки,скобки и тд
-- y s s (нажимаем медленно) - выделяем строку до конца и далее уже кавычки или скобку и тд.
-- d s (нажимаем быстро) - активация плагина для отмены скобкок или кавычкек
-- c s (нажимаем быстро) - активируем режим замены,далее нажимаем тот символ в который сейчас обернуто слово и следом уже нажимаем новый символ
-- shift + s - Выделенную строку оборачиваем нажав большую s и далее уже во что обернемол
