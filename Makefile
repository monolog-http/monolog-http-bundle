lint-php:
	php vendor/bin/phpcs --standard=Generic --sniffs="Generic.PHP.Syntax" src -p

phpcbf:
	php vendor/bin/phpcbf src tests

phpcs:
	php vendor/bin/phpcs src tests -n

php-cs-fixer:
	php bin/php-cs-fixer.phar fix -v

composer-normalize:
	php bin/composer-normalize.phar --no-update-lock

phpstan:
	php vendor/bin/phpstan analyse

phpunit:
	php vendor/bin/phpunit tests/ --colors=always --stop-on-failure
	@if [ ! -f build/coverage.txt ]; then exit 1; fi;
	@cat build/coverage.txt;
	@coverageLimit=91; \
	currentCoverage=$$(grep -E '^\s*Lines' build/coverage.txt | grep -P '\d+.\d+%' -o | grep -P '^\d+' -o); \
	if [ $${currentCoverage} -lt $${coverageLimit} ]; then echo "Insufficient Lines coverage, need at least $$coverageLimit%" && exit 1; fi;
