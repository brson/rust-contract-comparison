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
It's a typical non-technical blockchain chat,
filled with speculators.
I leave.

[dt]: https://t.me/dfinity/


## What we're gonna do

For this first look we're going to install the tools and try to implement a contract
we've implemented before in solidity, near, and ink, [the big announcement][tba].

This is a simple program that lets the caller bid to set a singleton string message.


## Starting by doing some actual research!

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

I read a blog post by DFINITY's Johan Granström:
[A Closer Look at Software Canisters, an Evolution of Smart Contracts].

[canblog]: https://medium.com/dfinity/software-canisters-an-evolution-of-smart-contracts-internet-computer-f1f92f1bfffb

Many of the capabilities described here sound similar to other smart contract platforms.
A few that stand out to me though:

- The memory space of a wasm cannister is saved and restored every execution!
  This should makes it behave as if it were a long-running process,
  even though each invocation may happen long 
  This suggests that all persistent state doesn't have to be written to special storage types,
  or maybe none does.
  It also suggests some complex and perhaps inefficient storage requirements.
  No merkle trees and light nodes at all maybe?
  I don't know enough about blockchain storage tech to guess.

- Full nodes are run by data centers.
  This probably allows it to be fast and store a lot of data,
  but reduces the decentralization.
  This is probably the fate of all smart contract blockchains though &mdash;
  Ethereum is already too big for most people to run on their own.
  It's not clear if full nodes need permission to join the network.

- Still no mention on gas!




## Installing the tools

Following the [quick start docs][qsd].

[qsd]: https://sdk.dfinity.org/docs/quickstart/quickstart-intro.html

I'm doing [local development][ldev],
not connecting to any testnet.

[ldev]: https://sdk.dfinity.org/docs/quickstart/local-quickstart.html

The 



## Aimee upgrades her `dfx`

Aimee has previously installed `dfx`.
Today when she ran `dfx new firsttest` to create a DFINITY project,
she had a confusing experience.

This is what she saw:

```
Aimees-MacBook-Pro:dfinity-project aimeez$ dfx new firsttest

The DFINITY Canister SDK sends anonymous usage data to DFINITY Stiftung by
default. If you wish to disable this behavior, then please set the environment
variable DFX_TELEMETRY_DISABLED=1. Learn more at https://sdk.dfinity.org.

Fetching manifest https://sdk.dfinity.org/manifest.json
⠋ Checking for latest dfx version...
You seem to be running an outdated version of dfx.

You are strongly encouraged to upgrade by running 'dfx upgrade'!
  Version v0.6.20 installed successfully.
Creating new project "firsttest"...
CREATE       firsttest/src/firsttest_assets/assets/sample-asset.txt (24B)...
CREATE       firsttest/src/firsttest/main.mo (107B)...
CREATE       firsttest/dfx.json (484B)...
CREATE       firsttest/.gitignore (165B)...
⠐ Checking for latest dfx version...
CREATE       firsttest/src/firsttest_assets/public/index.js (149B)...
CREATE       firsttest/package.json (288B)...
CREATE       firsttest/webpack.config.js (2.15KB)...
⠉ Checking for latest dfx version...
⠒ Checking for latest dfx version...
⠠ Installing node dependencies...
⠤ Checking for latest dfx version...
⠖ Installing node dependencies...

> fsevents@1.2.13 install /Users/aimeez/github/dfinity-project/firsttest/node_modules/watchpack-chokidar2/node_modules/fsevents
> node install.js
⠤ Checking for latest dfx version...
⠖ Checking for latest dfx version...
⠒ Checking for latest dfx version...
⠁ Checking for latest dfx version...
npm WARN firsttest_assets@0.1.0 No repository field.
npm WARN firsttest_assets@0.1.0 No license field.

⠙ Checking for latest dfx version...

13 packages are looking for funding
  run `npm fund` for details

found 1 high severity vulnerability
⠒ Checking for latest dfx version...
⠂ Checking for latest dfx version...

===============================================================================
        Welcome to the internet computer developer community!
                        You're using dfx 0.6.20

            ▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄                ▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄       
          ▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄          ▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄    
        ▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄      ▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄  
       ▄▄▄▄▄▄▄▄▄▄▀▀▀▀▀▄▄▄▄▄▄▄▄▄▄▄▄  ▄▄▄▄▄▄▄▄▄▄▄▄▀▀▀▀▀▀▄▄▄▄▄▄▄▄▄▄ 
      ▄▄▄▄▄▄▄▄▀         ▀▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▀         ▀▄▄▄▄▄▄▄▄▄
     ▄▄▄▄▄▄▄▄▀            ▀▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▀             ▄▄▄▄▄▄▄▄
     ▄▄▄▄▄▄▄▄               ▀▄▄▄▄▄▄▄▄▄▄▄▄▀                ▄▄▄▄▄▄▄
     ▄▄▄▄▄▄▄▄                ▄▄▄▄▄▄▄▄▄▄▄▄                 ▄▄▄▄▄▄▄
     ▄▄▄▄▄▄▄▄               ▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄              ▄▄▄▄▄▄▄▄
      ▄▄▄▄▄▄▄▄           ▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄          ▄▄▄▄▄▄▄▄▀
      ▀▄▄▄▄▄▄▄▄▄▄     ▄▄▄▄▄▄▄▄▄▄▄▄▀ ▀▄▄▄▄▄▄▄▄▄▄▄▄    ▄▄▄▄▄▄▄▄▄▄▄ 
       ▀▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▀     ▀▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▀  
         ▀▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▀         ▀▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄    
           ▀▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▀▀             ▀▀▄▄▄▄▄▄▄▄▄▄▄▄▄▄▀      
              ▀▀▀▀▀▀▀▀▀▀▀                    ▀▀▀▀▀▀▀▀▀▀▀         
     


To learn more before you start coding, see the documentation available online:

- Quick Start: https://sdk.dfinity.org/docs/quickstart/quickstart-intro.html
- SDK Developer Tools: https://sdk.dfinity.org/docs/developers-guide/sdk-guide.html
- Motoko Language Guide: https://sdk.dfinity.org/docs/language-guide/motoko.html
- Motoko Quick Reference: https://sdk.dfinity.org/docs/language-guide/language-manual.html

If you want to work on programs right away, try the following commands to get started:

    cd firsttest
    dfx help
    dfx new --help

===============================================================================
```

This is a mess.

Several things appear to be going wrong here.

- The command has printed "you are strongly encouraged to upgrade by running 'dfx upgrade',
  then it goes on to just do the upgrade on its own, saying
  "Version v0.6.0 installed successfully".

- Ever after checking for and installing a `dfx` upgrade,
  some process continues "Checking for latest dfx version".

- The `dfx` version check is happening _in parallel_
  to the creation and build of the "firsttest" project,
  causing a confusing interleaving of messages.

- Even when not interrupted by other messages,
  the "Checking for latest dfx version" message,
  which is accompanied by a unicode spinner,
  and should only appear once while the spinner changes,
  is printed repeatedly.

After some careful reading we think we understand everything that happened.

We note that Aimee _already had_ version `dfx` 0.6.20 installed,
but that `dfx` said it updated to 0.6.20.
We don't know if anything changed about `dfx` or if it just got
confused and reinstalled itself.

We try the suggested `dfx upgrade`,
and as we expected it does nothing.
So `dfx new firsttest` suggested we run a command,
then ran that command for us,
and when we ran the suggested command,
it did nothing.

Now we are curious about how the output of `dfx new firsttest`
will change if we run it again,
without requiring an update,
so we delete the new "firsttest" directory and try again:

```
$ dfx new firsttest
Fetching manifest https://sdk.dfinity.org/manifest.json
Creating new project "firsttest"...
CREATE       firsttest/src/firsttest_assets/assets/sample-asset.txt (24B)...
CREATE       firsttest/src/firsttest/main.mo (107B)...
CREATE       firsttest/dfx.json (484B)...
CREATE       firsttest/.gitignore (165B)...
CREATE       firsttest/README.md (1.16KB)...
CREATE       firsttest/src/firsttest_assets/public/index.js (149B)...
CREATE       firsttest/package.json (288B)...
CREATE       firsttest/webpack.config.js (2.15KB)...
⠒ Installing node dependencies...
⠁ Installing node dependencies...
npm WARN deprecated resolve-url@0.2.1: https://github.com/lydell/resolve-url#deprecated
⠁ Installing node dependencies...
⠋ Installing node dependencies...

> fsevents@1.2.13 install /Users/aimeez/github/dfinity-project/firsttest/node_modules/watchpack-chokidar2/node_modules/fsevents
> node install.js
⠒ Installing node dependencies...
⠲ Installing node dependencies...
⠉ Installing node dependencies...
⠲ Installing node dependencies...
npm WARN firsttest_assets@0.1.0 No repository field.
npm WARN firsttest_assets@0.1.0 No license field.

⠄ Installing node dependencies...

13 packages are looking for funding
  run `npm fund` for details

found 1 high severity vulnerability
⠄ Installing node dependencies...


   ╭─────────────────────────────────────────────────────────────────╮
   │                                                                 │
   │      New patch version of npm available! 6.14.8 → 6.14.11       │
   │   Changelog: https://github.com/npm/cli/releases/tag/v6.14.11   │
   │                Run npm install -g npm to update!                │
   │                                                                 │
   ╰─────────────────────────────────────────────────────────────────╯
  Done.
Creating git repository...

===============================================================================
        Welcome to the internet computer developer community!
                        You're using dfx 0.6.20

            ▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄                ▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄       
          ▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄          ▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄    
        ▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄      ▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄  
       ▄▄▄▄▄▄▄▄▄▄▀▀▀▀▀▄▄▄▄▄▄▄▄▄▄▄▄  ▄▄▄▄▄▄▄▄▄▄▄▄▀▀▀▀▀▀▄▄▄▄▄▄▄▄▄▄ 
      ▄▄▄▄▄▄▄▄▀         ▀▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▀         ▀▄▄▄▄▄▄▄▄▄
     ▄▄▄▄▄▄▄▄▀            ▀▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▀             ▄▄▄▄▄▄▄▄
     ▄▄▄▄▄▄▄▄               ▀▄▄▄▄▄▄▄▄▄▄▄▄▀                ▄▄▄▄▄▄▄
     ▄▄▄▄▄▄▄▄                ▄▄▄▄▄▄▄▄▄▄▄▄                 ▄▄▄▄▄▄▄
     ▄▄▄▄▄▄▄▄               ▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄              ▄▄▄▄▄▄▄▄
      ▄▄▄▄▄▄▄▄           ▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄          ▄▄▄▄▄▄▄▄▀
      ▀▄▄▄▄▄▄▄▄▄▄     ▄▄▄▄▄▄▄▄▄▄▄▄▀ ▀▄▄▄▄▄▄▄▄▄▄▄▄    ▄▄▄▄▄▄▄▄▄▄▄ 
       ▀▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▀     ▀▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▀  
         ▀▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▀         ▀▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄    
           ▀▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▀▀             ▀▀▄▄▄▄▄▄▄▄▄▄▄▄▄▄▀      
              ▀▀▀▀▀▀▀▀▀▀▀                    ▀▀▀▀▀▀▀▀▀▀▀         
     


To learn more before you start coding, see the documentation available online:

- Quick Start: https://sdk.dfinity.org/docs/quickstart/quickstart-intro.html
- SDK Developer Tools: https://sdk.dfinity.org/docs/developers-guide/sdk-guide.html
- Motoko Language Guide: https://sdk.dfinity.org/docs/language-guide/motoko.html
- Motoko Quick Reference: https://sdk.dfinity.org/docs/language-guide/language-manual.html

If you want to work on programs right away, try the following commands to get started:

    cd firsttest
    dfx help
    dfx new --help

===============================================================================
```

So nothing about checking for updates this time.
Good.
It still has a problem with its spinner+status message output,
where "Installing node dependencies..." is printed repeatedly.

This is on a mac,
so perhaps it's a platform-specific bug.

The final thing that is striking about this command
is that it prints a massive welcome greeting:
huge logo, links to docs, basic commands.

This is perfectly fine for something on first run,
but I don't ever want to see this again.

It's obvious though that this is not something that happens only on first run,
since we've seen this message multiple times.

We notice one other problem with the banner:
it is not colored correctly on this terminal.




I wonder if `dfx` is one of the tools with code available
under the GitHub org,
whether I can look at the code and try to fix some of these issues.

TODO