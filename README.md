# nevenincs distribution repository

One repository serving both package managers for every product published under
this account.

- **Homebrew** formulae live in `Formula/`.
- **Scoop** manifests live in `bucket/`.

## Install

Add the tap once, then install any product in it by name:

```sh
brew tap nevenincs/tap
brew install nevenincs/tap/<product>
```

Add the bucket once, then install any product in it by name:

```powershell
scoop bucket add nevenincs https://github.com/nevenincs/homebrew-tap
scoop install nevenincs/<product>
```

You perform each of those `tap`/`bucket add` steps once, ever — not once per
product.

## Why a Scoop bucket lives in a repository named for Homebrew

Because the two ecosystems constrain different things, and only one of them
constrains the repository name.

Homebrew's one-argument tap form requires the remote repository to be named
`homebrew-<name>`, so a repository with that prefix has to exist regardless.
Scoop imposes no name constraint at all and scopes manifest discovery to a
`bucket/` subdirectory when one is present. The two constraints are disjoint, so
one repository satisfies both.

The alternative arrangements each cost something real. A second, dedicated bucket
repository would create a discretionary distribution repository when a mandatory
one already exists. Serving Scoop from each product's own repository would hold
the repository count at zero only by multiplying the user's one-time bucket-add
by the number of products, and by committing to a public product repository's
default branch at every release.

So the odd-looking name is the entire price of the arrangement, and it is paid
once, here, in this paragraph.

## Adding a product

A new product adds one formula file and one manifest file. It creates nothing.
The repository count for this account is one at one product and one at a hundred.

Releases write here automatically. Each product's publication stages only its own
`Formula/<product>.rb` and `bucket/<product>.json`, never the whole tree, so
products cannot disturb each other's files. Each push also refuses a backward
version bump — these files are release pointers that a package manager resolves,
so silently regressing one would un-publish a working version for everyone
installing it.
