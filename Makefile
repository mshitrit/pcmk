IMG:=pcmk-img
REGISTRY:=quay.io/omular/pcmk

build:
	docker build --tag $(IMG) .

push: build
	docker push $(IMG) docker://$(REGISTRY)
