# Swift Git

[![Linux](https://github.com/fwcd/swift-git/actions/workflows/linux.yml/badge.svg)](https://github.com/fwcd/swift-git/actions/workflows/linux.yml)
![SwiftPM compatible](https://img.shields.io/badge/SwiftPM-compatible-4BC51D.svg?style=flat)
![Swift 5.3.x](https://img.shields.io/badge/Swift-5.3.x-orange.svg)

Swift bindings to [libgit2](https://github.com/libgit2/libgit2).

```swift
let URL: URL = ...
let result = Repository.at(URL)
switch result {
case let .success(repo):
    let latestCommit = repo
        .HEAD()
        .flatMap {
            repo.commit($0.oid)
        }

    switch latestCommit {
    case let .success(commit):
        print("Latest Commit: \(commit.message) by \(commit.author.name)")

    case let .failure(error):
        print("Could not get commit: \(error)")
    }

case let .failure(error):
    print("Could not open repository: \(error)")
}
```

## Design

`swift-git` uses value types wherever possible. That means using Swift’s `struct`s and `enum`s without holding references to libgit2 objects. This has a number of advantages:

1. Values can be used concurrently.
2. Consuming values won’t result in disk access.
3. Disk access can be contained to a smaller number of APIs.

This vastly simplifies the design of long-lived applications, which are the most common use case with Swift. Consequently, `swift-git` APIs don’t necessarily map 1-to-1 with libgit2 APIs.

All methods for reading from or writing to a repository are on `swift-git`’s only `class`: `Repository`. This highlights the failability and mutation of these methods, while freeing up all other instances to be immutable `struct`s and `enum`s.

## Required Tools

To build `swift-git`, you need to install `libgit2` on your system.

### on macOS

Make sure to have Homebrew installed, then run

```
brew install libgit2
```

### on Linux

On Debian/Ubuntu-based distributions, run

```
apt install libgit2-dev
```

## Adding `swift-git` to your Project

The easiest way to add `swift-git` to your project is to use [SwiftPM](https://swift.org/package-manager/). Simply add the following line to your `Package.swift`'s dependencies:

```swift
.package(url: "https://github.com/fwcd/swift-git.git", .branch("main"))
```

## Building `swift-git` Manually

If you want to build a copy of `swift-git`, e.g. for development:

1. Clone `swift-git`
2. Run `swift build`
3. Optionally run `swift test` to run the tests

## Contributions

We :heart: to receive pull requests! GitHub makes it easy:

1. Fork the repository
2. Create a branch with your changes
3. Send a Pull Request

All contributions should match GitHub’s [Swift Style Guide](https://github.com/github/swift-style-guide).

## License

`swift-git` is available under the MIT license.
