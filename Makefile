all: post.pdf

STATIC_PATH := ../local-server/static
PAGES_PATH := $(STATIC_PATH)/pages/
ASSETS_PATH := $(STATIC_PATH)/assets/
IMAGES_PATH := ./imgs
CSS_PATH := ./css

post.pdf: post.md style.h.tex
	pandoc ./post.md  -H style.h.tex -o post.pdf
	gio open post.pdf

# $(STATIC_PATH)/$(IMAGES_PATH)
post.html: clean_server post.md style.h.html | $(PAGES_PATH) $(ASSETS_PATH)
	pandoc ./post.md -H style.h.html -o post.html
	cp ./post.html $(PAGES_PATH)
	cp -r $(IMAGES_PATH) $(ASSETS_PATH)
	cp -r $(CSS_PATH) $(ASSETS_PATH)

PHONY: post.pdf post.html

clean:
	rm -f post.html
	rm -f post.pdf

$(PAGES_PATH):
	mkdir -p $(PAGES_PATH)

$(ASSETS_PATH):
	mkdir -p $(ASSETS_PATH)

clean_server:
	rm -rf $(PAGES_PATH)
	rm -rf $(ASSETS_PATH)

# $(STATIC_PATH)/$(IMAGES_PATH):
# 	mkdir -p $(STATIC_PATH)/$(IMAGES_PATH)