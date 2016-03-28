all: clean zip

clean:
	rm -rf dist
	mkdir dist
zip: 
	mkdir -p dist/docker-runner-images
	cp -r src/* dist/docker-runner-images
	(cd dist; zip -r ../dist/docker-runner-images.zip docker-runner-images)

check-env:
ifndef RDECK_BASE
    $(error RDECK_BASE is undefined)
endif

install: zip check-env
	cp dist/docker-runner-images.zip $(RDECK_BASE)/libext

