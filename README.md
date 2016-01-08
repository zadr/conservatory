**Q.** What is this pile of code?

**A.** Conservatory is a creative framework written in Swift. Our goal is to help you create and explore images, sounds, and videos, digitally. We're still taking our first steps towards figuring out what all that should mean, so, hang on and enjoy the ride!

**A.** Open Conservatory.xcworkspace! In there, you'll find a playground to play with, and the framework to experiment with. From there, create something! And share it with us (and everyone else, too, if you're okay with that)!

**Q.** How can I get involved?

**A.** Open Conservatory.xcworkspace! In there, you'll find a playground to play with, and the framework to experiment with. From there, create something! And share it with us (and everyone else, too, if you're okay with that)!


**Q.** Thats great, but, not really what I had in mind.

**A.** Hm. Well. Feedback is super important. Like, really, really important. If you've madesomething (or given up because we messed up badly and things are crashing, or worse, wrote a confusing framework), send us your thoughts!


**Q.** Cool beans. How can I do that?

**A.** Filing an issue is probably the quickest way to get in touch about anything that needs to be changed. You can tweet at us @{handle} if you like. There should probably be an IRC channel somewhere, too.


**Q.** What about actually contributing changes?

**A.** If you want to send in a pull request to add new things (or to fix bugs, correct typos, add sample code, or whatever else), that would be pretty great.


Please know that pull requests aren't't required, and telling us about a problem is always, always appreciated.


**Q.** What if I'm not sure where to start with that?

**A.** Please get in touch (try creating a new ticket or commenting on one that exists) and we'll be happy to try and help you out!


**Q.** What if I know exactly what to do and want to fix a bug?

**A.** Same thing! We can always point you in the right direction of the codebase, or at least let you know if someone else is working (or has worked) on something similar (and where to find their work).


**Q.** How did you come up with this API?

**A.** I sat at my desk, and, thought about it. I like most of whats shipped, but I could be talked into changing any of it. Pretty boring story, eh?

Basically, you have things. Things have attributes that help describe their appearance. Some other thing has the ability to draw a thing. And, there's some glue to hold it all together.

A few quick rules of thumb:

Inputs ('things') and Components ('attributes') are platform-agnostic. Ideally, they won't depend on anything outside of Conservatory. This isn't the case right now (`Darwin` or `Glibc` are imported for math functions, `UIKit` or `AppKit` are imported to load images.)

Outputs ('other thing') may be platform-specific; `CGRenderer` relies on CoreGraphics to run, while StringRenderer doesn't have any external dependencies. A future OpenGL-based renderer could be cross-platform. Outputs shouldn't provide any API that isn't defined in the Renderer protocol.

Any bridging ('glue') that needs to happen between Conservatory and native platforms should take place in a Bridging file; for example, CGBridging helps Conservatory and CoreGraphics talk to each other.


**Q.** Is it Conservatory documented anywhere that isn't in your head?

**A.** \*Pauses*

That's a good question. I'm glad you asked. Most of the classes and functions are documented.

\*Pauses again*

There isn't much in the way of sample code. We're working on that! In the meantime, please feel free to file issues or tweet at us if any problems or confusion come up.

We consider this documentation particularly important, and hard problem. Conservatory is a tool to help you creating things, and we feel that most documentation fails to encourage people to explore and experiment -- and we don't want to discourage anyone right off the bat.


**Q.** Is there a Code of Conduct?

**A.** Yes. This project follows the Contributor Covenant v1.3.0. You can find the full text in CONDUCT, or online at http://contributor-covenant.org/version/1/3/0/.


**Q.** What is this code licensed as?

**A.** Everything in Cotton Duck is released under a 2-clause BSD license. You can read it in the LICENSE file, and find out more about its requiements online at https://tldrlegal.com/license/bsd-2-clause-license-(freebsd)



**Q.** This is cool! What made you write this?

**A.** Creating things is fun. I had some really awesome art teachers in high school, and art professors in college. They all had fine arts backgrounds, are incredible at what they do, and, were (are!) open to exploring new mediums in digital art.

(And most importantly at the time, they were all willing to let me mess around in the computer labs for class credit).

Also, [HotCocoa::Graphics](https://github.com/HotCocoa/HotCocoaGraphics), [processing.js](http://processingjs.org) and [NodeBox](https://www.nodebox.net) are all awesome, but, can't be (easily) used from Xcode Playgrounds, and writing all this seemed like the easiest way to fix that.


**Q.** Can I make things animate?

**A.** Nope, not yet. Soon, though.


**Q.** Can I make beeps and boops?

**A.** Nope, not yet. Soon, though.


**Q.** What does a monad look like?

**A.** A burrito, who's shell is gluten-free. And is dripping with guac and sour cream. If you need help visualizing this, fly to San Francisco, and take BART to 24th Street station, and then go to the first taqueria you see after exiting the station.

