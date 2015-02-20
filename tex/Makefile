main.pdf: main.tex literature.bib graphics/*
		latexmk -g -pdf -latexoption=-shell-escape main.tex
clean:
		latexmk -CA
		rm -rf figures/*

