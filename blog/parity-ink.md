# First impressions of Rust smart contract programming with Parity's Ink

I am on a slow journey to learn about smart contract programming in Rust.
Today I am going to finally dip into [`ink`], a framework for writing
smart contracts for blockchains built on Parity's [Substrate] framework,
which includes the recently-launched [Polkadot] network.

[`ink`]: https://github.com/paritytech/ink
[Substrate]: https://www.parity.io/substrate/
[Polkadot]: https://www.parity.io/polkadot/

I have previously written impressions of other blockchains,
and their smart contract programming experiences:
[NEAR], [Nervos], [Ethereum].

[NEAR]: https://brson.github.io/2020/09/07/near-smart-contracts-rust
[Nervos]: https://talk.nervos.org/t/experience-report-first-time-building-and-running-ckb/4518/
[Ethereum]: https://github.com/Aimeedeer/bigannouncement/blob/master/doc/hacklog.md


## About Ink, Parity, Polkadot, and Substrate

`ink` is described in their readme as an "eDSL",
or "embedded domain-specific language".

TODO


## What's my goal

I am going to follow the platform's docs as close as I can,
and write down my thoughts as I do so.
I hope to end up with some functional contract deployed to a testnet.


## The starting point

Polkadot is Parity's primary blockchain at this point.
Substrate is a platform for building blockchains.
I know the two are related,
but am not confident in how.
I am sure Substrate can be used to build Polkadot "parachains",
which are essentially Polkadot shards,
or perhaps sidechains;
I _think_ Substrate is used to build Polkadot itself;
I do not know if Substrate can be used to build independent blockchains.

For now,
I only care about running contracts on the main Polkadot chain,
and am not interested in parachains.

I am going to start at the Polkadot developer docs,
and see where that leads me.
For now I am going to ignore the `ink` repo,
assuming that the Polkadot docs will lead me there when I need it.

Let's roll.


## Reading the Polkadot docs

Starting at Parity's Polkadot page

> https://www.parity.io/polkadot/

A big button immediately leads me to main Polkadot page,

> https://polkadot.network/

Not sure why I started at Parity's page instead of the Polkadot website,
but at least it directed me to the right place.

I'm guessing the "Build" link is where I need to go as a developer.

There are also prominent links to a "lightpaper" _and_ a "whitepaper",
which I open for reading later:

- https://polkadot.network/Polkadot-lightpaper.pdf
- https://polkadot.network/PolkaDotPaper.pdf

On the "Build" page I see

> when the mainnet comes

but the Polkadot front page said the mainnet was live.
Seems like this copy needs to be updated.

Ok, this page is prominently pitching Substrate to me,
not Polkadot smart contract programming.

Wow, this page is all about Substrate.
How do I write a Polkadot contract?

I have no clues yet.

Because Polkadot is (I think) built with Substrate,
I guess I have to click through to the Substrate documentation,
and learn about Substrate contract programming in order to
understand Polkadot contract programming.

Before I follow the links to Substrate,
I poke around a few other links on the Polkadot site.

Under the "Technology" section I see a "Documentation" link
that links to a wiki:

> http://wiki.polkadot.network/en/latest/

Having important docs on a wiki don't give me great confidence.

The wiki though looks like typical docs,
not a wiki,
and seems to have a good deal of content.
On it I find the "builder's portal":

> https://wiki.polkadot.network/docs/en/build-index

So this _seems_ like a good place to be as a new Polkadot smart
contract developer.
For now I think I'll ignore the Substrate website and follow these docs.

So the documentation flow here seems to have not worked for me:
the moste prominent links were leading me to Substrate documentation,
while I think I wanted to end up at the Polkadot Builder's Portal,
the link to which was not as obvious.

Aside: clicking several clicks down the Substrate documentation flow
leads me the Substrate Developer Hub:

> https://substrate.dev/docs/en/

This also seems useful,
and I'm guessing I will need it eventually,
but for now I'm going to follow the _Polkadot_ docs,
not the _Substrate_ docs.


## Reading the Polkadot Builder's Portal

There are a lot of subjects to read here,
most of them not directly about getting started with smart contract programming.
Assuming I need _some_ background though before getting started,
I just start reading front to back,
with the intention of jumping to the contract documentation once I think
I've got the basics of what I need to know.

So I click forward to the "Polkadot Builder's Starters Guide":

> https://wiki.polkadot.network/docs/en/build-build-with-polkadot

Apparently Substrate isn't the only way to build parachains.
There's another framework (or "Parachain Development Kit")
called [Cumulus].

No, apparently I'm wrong. I quick clickthrough to Cumulous
reveals that Cumulous builds on Substrate.

[Cumulous]: https://wiki.polkadot.network/docs/en/learn-crosschain

I'm quickly getting the impression that hacking in the Polkadot ecosystem
is going to require a lot of learning.

Oh, there's a section here called "What you need to know".
I feel a wave of relief,
just as I was starting to panic.

Ok, now I know that Substrate is for building blockchains,
Cumulus is an extension to Substrate that lets Substrate blockchains
become Polkadot parachains.

Polkadot does not support smart contracts!

I am learning.

Contracts are run on parachains.

I hope I don't have to build my own parachain just to experiment with Substrate
smart contracts.

On the other hand,
the prospect of having an entire parachain to myself,
to run my smart contracts,
is enticing.

I'm a little excited.

Polkadot supports para*chains* and para*threads*.
Parachains have to commit to the Polkadot relay chain every block,
but parathreads do not.

There are separate docs for developers who want to build
an entire parachain and for those that want to build a smart
contract.
For now I am the latter,
I follow the link,

> https://wiki.polkadot.network/docs/en/build-build-with-polkadot#so-you-want-to-build-a-smart-contract

These docs have me excited about all the options available
to Polkadot developers.

It does seem potentially extremely complicated,
in a domain that is already extremely complicated.


## So you want to build a smart contract

Following the previously-linked docs here:

> https://wiki.polkadot.network/docs/en/build-build-with-polkadot#so-you-want-to-build-a-smart-contract

Apparently smart contracts today can only be developed on a local development parachain.
According to the docs there aren't live parachains available for smart contract development yet.

So we're going to have to create a Substrate parachain for ourselves.
Substrate seems to be very flexible,
with building blocks called _pallets_,
and to create a WASM smart-contract parachain
we need to use the [Contracts pallet][cpt].

[cpt]: https://github.com/paritytech/substrate/tree/master/frame/contracts

The docs have mentioned the "FRAME" library a few times,
but I've missed a definition of what that is.

I see some typos in the docs.

We're good open-source citizens: let's see if we can find the source and fix them!

Yeah, this is a "wiki",
which in this case actually means that it's just a GitHub repo,
and the "edit" link leads me to the GitHub online editor.
It's pretty awkward as a document-editing interface,
but for a simple patch I manage to make the edit and submit a PR after two tries:

> https://github.com/w3f/polkadot-wiki/pull/1291

The docs go on to mention [Edgeware],
a live smart-contract-enabled Substrate chain
(but not yet a parachain)
where devs can deploy their contracts.
So I was wrong (or the docs were wrong)
that contracts can only be developed on dev nets,
and not deployed to a live network.

[Edgeware]: https://edgewa.re/

The "so you want to build a smart contract docs"
cover a few more concepts and then says

> Good luck!

It's not obvious what to do next,
but the docs do indicate that the state of the ecosystem is early,
so that's not a surprise.
We have to create our own game plan.

The game plan:

- create a substrate devnet with the contracts pallet
- write an ink contract
- test that ink contract on our local devnet

If we can accomplish that within this blog post I'll be happy.

I'm kinda excited that writing a smart contract here first involves creating my own personal blockchain.
I hope that it is easy to do,
and that having my own blockchain gives me lots of control during development.


## Creating a blockchain with substrate

Now I'm going to the Substrate Developer Hub and following those docs:

> https://substrate.dev/docs/en/

"Welcome to the wonderful world of blockchain development with Substrate!"

Oooh.

Oh neat:

> In Substrate, runtime code is compiled to Wasm and becomes part of the
  blockchain's storage state - this enables one of the defining features of a
  Substrate-based blockchain: forkless runtime upgrades.

So you customize a substrate blockchain my writing its logic in WASM,
which is itself stored on-chain.
That's fun.

There are several ways to build a substrate chain,
but the easiest is to use the "Substrate Node" right out of the box,
with a little bit of custom configuration.
For our purposes,
this seems right.

Oh, there's so much documentation here.
It seems impossible to follow it in any linear way.
That's ok - at least there are docs.

For running a Substrate Node,
the docs indicate to use the two tutorials:

- [Create Your First Substrate Chain](https://substrate.dev/docs/en/tutorials/create-your-first-substrate-chain/)
- [Start a Private Network](https://substrate.dev/docs/en/tutorials/start-a-private-network/)

I figure we'll do the first, then the second.

We've only just started reading the top-level docs on [substrate.dev] though.
Looking at the sidebar I see lots of interesting topics I want to know more about,
but for now we'll go straight to the tutorial.

[substrate.dev]: https://substrate.dev


## Following the "create your first substrate chain" tutorial

Ok, now we're following _these_ docs:

> https://substrate.dev/docs/en/tutorials/create-your-first-substrate-chain/

Hopefully we'll be hacking soon.

There's a one-liner for setting up development tools:

> curl https://getsubstrate.io -sSf | bash -s -- --fast

but reading about what it does,
I should already have everything it installs on my box.
I skip that step.

The first step is to clone a "node template":

```
git clone -b v2.0.0 --depth 1 https://github.com/substrate-developer-hub/substrate-node-template
```

I see it is cloning "v2.0.0" and wonder if that is the latest.
Is it?
Yes, there are no newer tags.
Good job keeping the docs up to date, devs.

Per the docs I update my stable and nightly Rust toolchains,
and add the `wasm32-unknown-unknown` target to the nightly.

```
rustup update nightly
rustup update stable
rustup target add wasm32-unknown-unknown --toolchain nightly
```

Now I can build the template with `cargo build --release`.


## Interlude: What's in the substrate node template?

While we are building...

The [readme for `substrate-node-template`][rsnt] is informative.

[rsnt]: https://github.com/substrate-developer-hub/substrate-node-template

TODO


## The build fails

I run into a build error:

```
  error[E0282]: type annotations needed
      --> /home/ubuntu/.cargo/registry/src/github.com-1ecc6299db9ec823/sp-arithmetic-2.0.0/src/fixed_point.rs:541:9
       |
  541  |                   let accuracy = P::ACCURACY.saturated_into();
       |                       ^^^^^^^^ consider giving `accuracy` a type
```

I'm guessing this is a problem related to nightlies:
the tutorial has told me to use just "nightly",
and probably I need a specific nightly.

I see that the readme for `substrate-node-template` has a different `cargo build` invocation than the tutorial:

```
WASM_BUILD_TOOLCHAIN=nightly-2020-10-05 cargo build --release
```

This is telling the substrate build scripts (presumably) to use a specific nightly when building
the WASM parts of the runtime.

I install that nightly and its wasm target:

```
rustup toolchain install nightly-2020-10-05
rustup target add wasm32-unknown-unknown --toolchain=nightly-2020-10-05
```

and run the new build command:

```
$ WASM_BUILD_TOOLCHAIN=nightly-2020-10-05 cargo build --release
   Compiling librocksdb-sys v6.11.4
   Compiling futures-timer v3.0.2
   Compiling jsonrpc-ipc-server v15.0.0
   Compiling parity-util-mem v0.7.0
The following warnings were emitted during compilation:

warning: couldn't execute `llvm-config --prefix` (error: No such file or directory (os error 2))
warning: set the LLVM_CONFIG_PATH environment variable to the full path to a valid `llvm-config` executable (including the executable itself)

error: failed to run custom build command for `librocksdb-sys v6.11.4`
```

A different error.
This is surely because I didn't run the `getsubstrate.io` setup script,
thinking I had all the development prerequisites installed.
Fortunately I'm familiar with this error and know I need to install clang/llvm development packages.

I `sudo install libclang-dev` and try again.
It fails.
I `sude install llvm-dev` and try again:

```
$ WASM_BUILD_TOOLCHAIN=nightly-2020-10-05 cargo build --release
   Compiling librocksdb-sys v6.11.4
   Compiling async-std v1.6.2
   Compiling sp-utils v2.0.0
   Compiling cranelift-wasm v0.66.0
error: failed to run custom build command for `librocksdb-sys v6.11.4`

Caused by:
  process didn't exit successfully: `/home/ubuntu/substrate-node-template/target/release/build/librocksdb-sys-871a9c160c12016c/build-script-build` (exit code: 101)
  --- stderr
  rocksdb/include/rocksdb/c.h:65:10: fatal error: 'stdarg.h' file not found
```

This one is because clang's stdlib is not installed.
I `sudo install libc++-dev` and try again.
Nope, not that one.
I give up guessing and look at the script at `https://getsubstrate.io`.
Oh, it's just `clang`.
I `sudo install clang` and try again.

Now my build succeeds.

While my build suceeds,
my partner's (who is also following along)
does not.
She continues to get the same "type annotations needed" error.
After investigation we discover that while I have
the "stable" toolchain set to the default,
she has the "nightly" toolchain as the default.

So on her computer we run

```
rustup default stable
```

Now her build succeeds.

There must be a type inference regression on nightlies that is causing the build to break.

I should report this to the Rust bug tracker...
but I'm tired of diversions and want to press on.
Sorry.

The build takes about 15 minutes,
in release mode,
on my fairly puny machine.
Thanks, Rust.

I have my own blockchain now, yay!
Thanks again, Rust.

These would have been difficult problems to overcome for somewhat not already familiar with nightly Rust development,
and I can tell the Substrate docs are trying to be friendly to non-Rust devs.

Time to continue the "create your first substrate chain" tutorial...


## The front-end

Next, the tutorial wants us to install the front end template,
which is of course JavaScript.

I don't _think_ I need this right now,
since I'm interested in writing contracts,
but I'll need it eventually,
and I'm curious what the front end is like,
and I want to follow the tutorial as written.

I'm always a bit resentful whenever I have to build / run a JavaScript project.
That world feels alien and haphazard.

Let's feel the pain...

```
$ git clone -b v2.0.0 --depth 1 https://github.com/substrate-developer-hub/substrate-front-end-template
$ cd substrate-front-end-template
$ yarn install
yarn install v1.22.5
[1/5] Validating package.json...
[2/5] Resolving packages...
[3/5] Fetching packages...
info fsevents@2.1.2: The platform "linux" is incompatible with this module.
info "fsevents@2.1.2" is an optional dependency and failed compatibility check. Excluding it from installation.
info fsevents@1.2.13: The platform "linux" is incompatible with this module.
info "fsevents@1.2.13" is an optional dependency and failed compatibility check. Excluding it from installation.
info fsevents@2.1.3: The platform "linux" is incompatible with this module.
info "fsevents@2.1.3" is an optional dependency and failed compatibility check. Excluding it from installation.
[4/5] Linking dependencies...
warning "react-scripts > @typescript-eslint/eslint-plugin > tsutils@3.17.1" has unmet peer dependency "typescript@>=2.8.0 || >= 3.2.0-dev || >= 3.3.0-dev || >= 3.4.0-dev || >= 3.5.0-dev || >= 3.6.0-dev || >= 3.6.0-beta || >= 3.7.0-dev || >= 3.7.0-beta".
[5/5] Building fresh packages...
Done in 83.31s.
```

Ok that was painless.


## Running our new node

The next page in the tutorial, "Background Information"

> https://substrate.dev/docs/en/tutorials/create-your-first-substrate-chain/background

is a bit out of place here,
just kind of trivia.

Following along on the next page, "Interacting with Your Node":

> https://substrate.dev/docs/en/tutorials/create-your-first-substrate-chain/interact

The instructions say to run

```
./target/release/node-template --dev --tmp

```

but I personally don't like to simply run binaries out of the `target` directory,
so I try:

```
$WASM_BUILD_TOOLCHAIN=nightly-2020-10-05 cargo run --release -- --dev --tmp
```

The output is exciting:

```
Nov 16 00:13:28.538  INFO 🏷  Node name: slim-turn-8420
Nov 16 00:13:28.538  INFO 👤 Role: AUTHORITY
Nov 16 00:13:28.538  INFO 💾 Database: RocksDb at /tmp/substrateQmdqLp/chains/dev/db
Nov 16 00:13:28.538  INFO ⛓  Native runtime: node-template-1 (node-template-1.tx1.au1)
Nov 16 00:13:28.634  INFO 🔨 Initializing Genesis block/state (state: 0xe656…ffd0, header-hash: 0x3844…fe3c)
Nov 16 00:13:28.635  INFO 👴 Loading GRANDPA authority set from genesis on what appears to be first startup.
Nov 16 00:13:28.657  INFO ⏱  Loaded block-time = 6000 milliseconds from genesis on first-launch
Nov 16 00:13:28.658  WARN Using default protocol ID "sup" because none is configured in the chain specs
Nov 16 00:13:28.658  INFO 🏷  Local node identity is: 12D3KooWBmAKFMGa6Dt9oi4Ct1erBgZgYkunYDupASh3L1EaKbpg (legacy representation: 12D3KooWBmAKFMGa6Dt9oi4Ct1erBgZgYkunYDupASh3L1EaKbpg)
Nov 16 00:13:28.669  INFO 📦 Highest known block at #0
Nov 16 00:13:28.669  INFO 〽️ Prometheus server started at 127.0.0.1:9615
Nov 16 00:13:28.670  INFO Listening for new connections on 127.0.0.1:9944.
Nov 16 00:13:30.006  INFO 🙌 Starting consensus session on top of parent 0x3844523584d4b8572c80478e0c69bb79dbdba6416283a1af756e2a8211b8fe3c
Nov 16 00:13:30.012  INFO 🎁 Prepared block for proposing at 1 [hash: 0x0dbc7b803cf6730d0e3b56c48e3d513fbb5298c9087b727bbf7a57d24da66f3d; parent_hash: 0x3844…fe3c; extrinsics (1): [0xa89d…df2b]]
Nov 16 00:13:30.015  INFO 🔖 Pre-sealed block for proposal at 1. Hash now 0x1601051fdd3e7670d2eacce27a59688eb7a1dad690dbce7bdc697810bb64c491, previously 0x0dbc7b803cf6730d0e3b56c48e3d513fbb5298c9087b727bbf7a57d24da66f3d.
Nov 16 00:13:30.016  INFO ✨ Imported #1 (0x1601…c491)
Nov 16 00:13:33.670  INFO 💤 Idle (0 peers), best: #1 (0x1601…c491), finalized #0 (0x3844…fe3c), ⬇ 0 ⬆ 0
```

Those emoji are so silly,
but I love seeing them.

I am relieved that Substrate makes it easy to run a temporary devnet with a single command,
no generating keys,
creating config files,
creating directories.
In my (admittedly limited) experience NEAR also makes this easy,
Nervos does not,
and the development workflow for Ethereum is just not clear at all,
with lots of half-baked options.

Every blockchain should have a single command to spin up a local devnet.

I note the output line

```
Nov 16 00:13:28.669  INFO 〽️ Prometheus server started at 127.0.0.1:9615
```

I don't know much about Prometheus,
but do know it's for collecting metrics.
I hope I can open that port in a web browser and see something interesting.

Now I run the frontend with `yarn start`:

```
Compiled successfully!

You can now view substrate-front-end-template in the browser.

  Local:            http://localhost:8000/substrate-front-end-template
  On Your Network:  http://172.30.0.181:8000/substrate-front-end-template

Note that the development build is not optimized.
To create a production build, use yarn build.
```

Cool.

Now I should be able to open a web browser on port 8000 to see the substrate GUI,
and port 9615 to see the metrics.

I'm running remotely on EC2,
so I need to exit my shell and reconnect with the appropriate port forwarding
in order to tunnel those ports to my local computer:

```
ssh -A <my-server> -L localhost:8000:localhost:8000 -L localhost:9615:localhost:9615
```

I try to open `localhost:8000` on my local computer and see an error:

> Error Connecting to Substrate
> [object Event]

Awesome.
I'm guessing that I need to forward another port,
probably the RPC port for the substrate node.

I establish a new ssh tunnel,
adding port 9944 as well:

```
ssh -A <my-server> -L localhost:8000:localhost:8000 -L localhost:9615:localhost:9615 -L localhost:9944:localhost:9944
```

Now I see the frontend.

It's lovely.

TODO - insert pics

There's so much fun looking stuff to mess with here,
but for now I'm not going to.

I attempt to navigate to `localhost:9516`,
the prometheus address,
but it just returns "not found",
so I guess that's not a prometheus UI,
just a service port of some kind.

Some googling reveals that I can get the server metrics from

> http://localhost:9615/metrics

but it seems if I want a nice metrecs frontend I need to do some more work.

Cool.

Let's build a Substrate smart contract.
