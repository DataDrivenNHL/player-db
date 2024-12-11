define docker-compose-up
	docker-compose --log-level ERROR up --always-recreate-deps --force-recreate --remove-orphans --build --exit-code-from $(1) $(1)
endef

.PHONY: all

info: header

define HEADER
                                                                                    
         ###                                                       ##      /        
          ###                                                       ##   #/         
           ##                                                       ##   ##         
           ##                                                       ##   ##         
           ##                                                       ##   ##         
   /###    ##      /###   ##   ####      /##  ###  /###         ### ##   ## /###    
  / ###  / ##     / ###  / ##    ###  / / ###  ###/ #### /     ######### ##/ ###  / 
 /   ###/  ##    /   ###/  ##     ###/ /   ###  ##   ###/     ##   ####  ##   ###/  
##    ##   ##   ##    ##   ##      ## ##    ### ##            ##    ##   ##    ##   
##    ##   ##   ##    ##   ##      ## ########  ##            ##    ##   ##    ##   
##    ##   ##   ##    ##   ##      ## #######   ##            ##    ##   ##    ##   
##    ##   ##   ##    ##   ##      ## ##        ##            ##    ##   ##    ##   
##    ##   ##   ##    /#   ##      ## ####    / ##            ##    /#   ##    /#   
#######    ### / ####/ ##   #########  ######/  ###            ####/      ####/     
######      ##/   ###   ##    #### ###  #####    ###            ###        ###      
##                                  ###                                             
##                           #####   ###                                            
##                         /#######  /#                                             
 ##                       /      ###/                                               
endef
export HEADER

.PHONY: requirements-dev
requirements-dev:
	@echo "install requirements-dev"
	pip install -r requirements-dev.txt

.PHONY: requirements
requirements:
	@echo "install requirements"
	pip install -r requirements.txt

.PHONY: test
test:
	@echo "test player db"
	@echo "$$HEADER"
	rm -rf ./cdk.out
	coverage run -m pytest
	coverage report
	coverage html
	@eval $$(rm ./*.ics)

.PHONY: lint
lint:
	@echo "lint player db"
	@echo "$$HEADER"
	flake8 app.py tests player_db --count --select=E9,F63,F7,F82 --show-source --statistics
	flake8 app.py player_db --count --exit-zero --max-complexity=10 --max-line-length=127 --statistics