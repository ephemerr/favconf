JOB ?= Software Engineer

run:  
	make all
all :  
	xelatex my.tex 
	xelatex "\def\jobposition{$(JOB)} \input{my.tex}"
	cp my.pdf "Alexander Zheleznov - $(JOB)".pdf
	evince my.pdf

.PHONY: clean all

clean :
	rm -f *.pdf *.aux *.log

