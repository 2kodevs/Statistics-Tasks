.DEFAULT_GOAL 	:= help

CP8-Ex5: ## run the CP8-Ex5 R script and show its output
	@cd Tasks/CP8-Ex5/ && Rscript CP8-Ex5.r

CP9-Ex2: ## run the CP9-Ex2 R script and show its output
	@cd Tasks/CP9-Ex2/ && Rscript CP9-Ex2.r

view: ## display the Makefile
	@cat Makefile

edit: ## open the Makefile with `code`
	@code Makefile

install: ## Install project requierments
	@sudo apt-get install r-base r-cran-lmtest

help: ## Show this help
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

