main.pdf: main.tex literature.bib
		latexmk -g -pdf -latexoption=-shell-escape main.tex
clean:
		latexmk -CA
		rm -rf figures/*

