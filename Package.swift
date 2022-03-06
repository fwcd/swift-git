// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
	name: "swift-git",
	platforms: [
		.macOS(.v10_11),
		.iOS("9.2"),
	],
	products: [
		.library(
			name: "Git",
			targets: ["Git"]
		),
	],
	dependencies: [
		.package(url: "https://github.com/Quick/Quick", from: "2.2.0"),
		.package(url: "https://github.com/Quick/Nimble", from: "8.0.8"),
		.package(url: "https://github.com/marmelroy/Zip.git", from: "2.0.0"),
	],
	targets: [
		.systemLibrary(
			name: "Clibgit2",
			pkgConfig: "libgit2",
			providers: [
				.brew(["libgit2"]),
				.apt(["libgit2-dev"]),
			]
		),
		.target(
			name: "Git",
			dependencies: [
				.target(name: "Clibgit2"),
			],
			exclude: ["Info.plist"]
		),
		.testTarget(
			name: "GitTests",
			dependencies: [
				.target(name: "Git"),
				.product(name: "Quick", package: "Quick"),
				.product(name: "Nimble", package: "Nimble"),
				.product(name: "Zip", package: "Zip"),
			],
			exclude: ["Info.plist"],
			resources: [
				.copy("Fixtures/repository-with-status.zip"),
				.copy("Fixtures/Mantle.zip"),
				.copy("Fixtures/simple-repository.zip"),
				.copy("Fixtures/detached-head.zip"),
			]
		),
	]
)
