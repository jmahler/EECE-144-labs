
skel.dvi: skel.tex
	rubber $<

skel.pdf: skel.tex
	rubber --pdf $<

clean:
	-rm -f *.aux *.blg *.bbl *.log *.out *.toc
