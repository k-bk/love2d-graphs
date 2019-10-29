run: love
	./love .

test:
	lua -lv2 -e "v2.test()"

love:
	wget -L -O love https://bitbucket.org/rude/love/downloads/love-11.3-x86_64.AppImage
	chmod +x love
