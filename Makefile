test:
	bin/rspec && bin/yard doctest

lint:
	bin/rubocop
