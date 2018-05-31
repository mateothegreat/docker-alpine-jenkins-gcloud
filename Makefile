NAME	= mateothegreat/docker-alpine-jenkins-gcloud
ALIAS	= jenkins
VERSION	= 1.0.0

.PHONY:	all build test tag_latest release

all:	build

clean:

	sudo rm -rf jenkins_home/

build: clean

	@echo "Building an image with the current tag $(NAME):$(VERSION).."
	
	docker build 	--rm 	\
					--tag $(NAME):$(VERSION) \
					.

run: stop

	docker run 	--rm -d 				                        \
				--volume $(PWD)/jenkins_home:/var/jenkins_home 	\
				--volume $(PWD)/service_account.json:/service_account.json \
				-e GCLOUD_KEY_FILE=/service_account.json 		\
				-e GCLOUD_PROJECT=nodetech-devops-01	 		\
				-e GCLOUD_ZONE=us-central1-a			 		\
				--publish 8080:8080		                        \
				--publish 50000:50000                           \
				--name $(ALIAS)                                 \
				$(NAME):$(VERSION)

stop:

	docker rm -f $(ALIAS) | true

logs:

	docker logs -f $(ALIAS)

shell:

	docker run 	--rm -it 				                        \
				--volume $(PWD)/jenkins_home:/var/jenkins_home 	\
				--publish 8080:8080		                        \
				--publish 50000:50000                           \
				--name $(ALIAS)                                 \
				--entrypoint /bin/sh                            \
				$(NAME):$(VERSION)

tag_latest:

	docker tag $(NAME):$(VERSION) $(NAME):latest

push:

	docker push $(NAME)
