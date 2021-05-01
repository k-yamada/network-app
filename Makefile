.PHONY: help setup

.DEFAULT_GOAL := help

help:
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

assemble-debug: ## デバッグ用apkを作成
	./gradlew assembleDebug
	open androidApp/build/outputs/apk/debug/

pack-for-xcode-iphoneos: ## shared.frameworkを作成する(実機用)
	SDK_NAME=iphoneos ./gradlew :shared:packForXCode

pack-for-xcode-simulator: ## shared.frameworkを作成する(simulator用)
	SDK_NAME=iphonesimulator ./gradlew :shared:packForXCode
