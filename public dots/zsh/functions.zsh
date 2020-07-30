tgav() {
	touch $1
	git add $1
	nvim $1
}

ghiv() {
	gh issue view $1 | nvim -R -c 'set ft=markdown' -
}
