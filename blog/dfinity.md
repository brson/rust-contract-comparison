# First look at programming for DFINITY

Continuing our adventure exploring programmable Rust blockchains,
this time we're going to dive into [DFINITY].

[DFINITY]: https://github.com/dfinity

TODO

I have been vaguelly aware of DFINITY for a while,
but have thought it was not ready for a close look
since the GitHub seems to be missing the big pieces of a blockchain &mdash;
the full node does not appear to be open source yet.

I generally join any technical chat for Rust blockchain projects I follow.
I peek into [DFINITY's telegram][dt],
via the link on their website.
It's a typical non-technical blockchain chat.
I leave.

[dt]: https://t.me/dfinity/


## What we're gonna do

For this first look we're going to install the tools and try to implement a contract
we've implemented before in solidity, near, and ink, [the big announcement][tba].

This is a simple program that lets the caller bid to set a singleton string message.


## Starting be doing some actual research!

Myself,
when I start a project,
I usually just jump in,
without informing myself of anything at all really.
This time though,
we have watched [an entire YouTube playlist][ytpl]
about "building on the Internet Computer".

[ytpl]: https://www.youtube.com/playlist?list=PLuhDt1vhGcrejCmYeB1uqgl9Y3f6MCyFp

It's an extremely basic series,
but I did have some takeaways:
mostly,
that programming for DFINITY appears to look a lot like traditional programming,
and _not_ like Solidity-descendant smart contract programming.
Gas was not mentioned at all,
and I am curious whether that means the programmer doesn't neeed to worry about gas,
or whether they chose to gloss over that subject.
They are using a custom smart contract language, [Motoko].
It looks like a mashup of a number of languages,
with some clear Rust influence,
though not one single obvious inspiration.
It is modeling its contract interactions as actors,
using the async/await model,
which so far appears to be a good fit.
The code I've seen in the video reads pretty easily.

[Motoko]: https://sdk.dfinity.org/docs/language-guide/motoko.html
