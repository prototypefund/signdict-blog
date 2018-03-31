.PHONY: default
default: serve ;

serve:
	bundle exec jekyll s -H 0.0.0.0 --future --watch

deploy:
	sh deploy.sh
