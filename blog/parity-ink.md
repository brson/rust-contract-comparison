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

The "so you want to builda smart contract docs"
cover a few more concepts and then says

> Good luck!

It's not obvious what to do next,
but the docs do indicate that the state of the ecosystem is early,
so it's pretty expected.
So we have to create our own game plan.

The game plan:

- create a substrate devnet with the contracts pallet
- write an ink contract
- test that ink contract on our local devnet

If we can accomplish that within this blog post I'll be happy.

I'm kinda excited that writing a smart contract here first involves creating my own personal blockchain.
I hope that it is easy to do,
and that having my own blockchain gives me lots of control during development.


## Creating a blockchain with substrate
