# Johnny Deps :: ![Build Status](https://circleci.com/gh/VividCortex/johnny-deps.png?circle-token=426f85f6d52ca0b308d1f6aab01dd219afdb4cb0)

We wrote Johnny Deps to provide barebones dependency versioning on our Go projects. We have purposely kept it to a minimum of functionality
so things like dependency resolution are outside of its scope, but it works and solves our problems regarding versioning, for further context on the writing of this tool refer to [this blog post](https://vividcortex.com/blog/2013/07/18/my-wishlist-versioned-packages-in-go/)

## How does it work?

Johnny Deps expects you to have a file called `Godeps` in the root of your project, in the format `<import path> <git tag>`.

Here's a sample `Godeps` file:

```
github.com/VividCortex/ewma       v1.0
github.com/VividCortex/robustly   v1.1
```

Once this file is in place, running the `johnny_deps` script will download those packages
and check out the version specified:

```
$ ls .
Godeps  foo.go  foo_test.go
$ johnny_deps
```

When called without arguments `johnny_deps` looks for the Godeps file in the execution directory, alternatively, you can pass the path to the dependency file as an argument like `johnny_deps /path/to/dependencies` (in this case, the `dependencies` file would be parsed and applied).

### Tags or commit hashes

Johnny Deps suggests (and we usually use) Git tags because it's the most
human-readable format and looks nicer in the `Godeps` file, but thanks to git
being awesome we can also specify a commit SHA and that will work just as well.

So if a particular project you want to import doesn't use git tags for versioning,
you can still specify the commit you want to work with. Under the hood, we use
`git checkout <tag>`, so anything `git` accepts for that argument will work.

Another sample `Godeps` with a branch and a commit SHA:

```
github.com/VividCortex/ewma       v1.0
github.com/nu7hatch/gotrail       2eb79d1f03ab24bacbc32b15b75769880629a865

# TODO: This is a comment! :)
```

#### Something you absolutely shouldn't do

Because `johnny_deps` uses `git checkout <version>` to set the version of each package, you can technically specify a branch there, like `master` or `develop` or whatever. This is a very bad idea.

The assumption that's made is that the versions in the `Godeps` file are immutable, this way we avoid needing a `Godeps.lock` file like [Ruby's Bundler](http://bundler.io/), you *can* ignore this rule, but be aware that you are doing so at your own peril and that we think you are a very bad person for doing this.

## Usage

You can run johnny_deps directly from the web or install it locally.

### Run without installing it

You can run `johnny_deps` specifying a tagged version, like so:

```
$ curl -s https://raw.github.com/VividCortex/johnny-deps/v0.1.5/bin/johnny_deps | bash
```

### Install it locally

To install Johnny Deps just clone the repo and then run:

    $ cd johnny_deps
    $ ./configure --prefix=/usr/local
    $ make install

Now the `johnny_deps` tool should be available in your system.


## Contributing

1. Fork the project.
2. Write awesome code (in a feature branch).
3. Add tests (if applicable)
4. Run tests (always!)
5. Commit, push and send Pull Request.
6. Receive maintainer's unending love.

### Running tests

Yeap, we wrote tests for bash. f@#$% yeah!

```
$ make test
```

## License

Copyright (c) 2013 VividCortex.
Released under MIT License, check LICENSE file for details.

## Authorship/Inspiration/Hugs

`Johnny_Deps` was written by [@pote](https://github.com/pote) - who maintains [a fork of this project](https://github.com/pote/johnny-deps) - for internal use in [Vivid Cortex](https://github.com/VividCortex) whose leadership have enthusiastically agreed to open source it. It is now maintained by [the VividCortex team](https://github.com/VividCortex?tab=members).

The tool is inspired by Ruby's [dep gem](http://cyx.github.io/dep/) - authored by [@cyx](http://cyx.is/) and [@soveran](http://soveran.com/), big thanks to them and to all the contributions made by the many wonderful people in our [contributors page](https://github.com/VividCortex/johnny-deps/graphs/contributors).


![Johnny Deps](http://i.imgur.com/MuupBVC.jpg)
