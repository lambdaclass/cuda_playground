.PHONY: help clean run clean.run

default: help

# help: @ Displays this message
help:
	@grep -E '[a-zA-Z\.\-]+:.*?@ .*$$' $(firstword $(MAKEFILE_LIST))| tr -d '#'  | awk 'BEGIN {FS = ":.*?@ "}; {printf "\033[32m%-30s\033[0m %s\n", $$1, $$2}'

# clean: @ Cleans artifacts
clean:
	@cargo clean

# run: @ Runs program
run:
	@cargo run

# clean.run: @ Cleans and then runs
clean.run: clean run
