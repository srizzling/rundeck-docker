all: clean zip

clean:
	rm -rf dist
	mkdir dist
zip: 
	mkdir -p dist/docker-nodes-images
	cp -r src/* dist/docker-nodes-images
	(cd dist; zip -r ../dist/docker-nodes-images.zip docker-nodes-images)

check-env:
ifndef RDECK_BASE
    $(error RDECK_BASE is undefined)
endif

install: zip check-env
	cp dist/docker-nodes-images.zip $(RDECK_BASE)/libext

