main.pdf: main.tex literature.bib graphics/* data/*/*/*
		latexmk -g -pdf -latexoption=-shell-escape main.tex
clean:
		latexmk -CA
		rm -rf figures/*

