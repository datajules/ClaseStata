

capture program drop coment_tit

program define coment_tit
	version 1.0
	args texto
	local num strlen("`texto'")
	local vinieta  = ("*")*round((76 - `num') / 2)
	display "`vinieta'" " -" "`texto'" "- " "`vinieta'"
end
	

