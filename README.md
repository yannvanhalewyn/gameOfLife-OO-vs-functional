Conway's Game of Life -- Functional vs Object Oriented TDD
==============================================

As i was discovering the world of functional programming, I wanted to try and implement a well known problem using a traditional object oriented approach and the functional approach. I would TDD both times and try to apprehend more about the paradigms. I would make an implementation of Conway's Game of Life. I chose ruby for the clear syntax and RSpec. I later also took a crack at an implementation in Clojure!

## Object Oriented
---

Was the familiar approach. Although I felt it was harder to conceive the basic architecture, once I got the ball rolling I managed to solve the problem efficiently. I did run into some bugs that would've been avoided using the functional approach.

## Functional
---

I felt it was easier to abstract this problem into smaller subsets of pure logic rather than chopping it up into collections of data and behavior (OO). That may be because the nature of the problem is heavier on data analysis / manipulation. In OO, I started with the "Cell" class. And what does a "Cell" do exactly? 

**OO me**: "Everything! The cell is the living core of this game. Put all the functionality into this class."

**Functional me**: "Nothing! It's merely a piece of data. It's dead or alive. It shouldn't think, shouldn't be aware of the world around him. The person playing the game should be the judge of what happens with each cell. The player is the one putting and removing cells from the board after analysing it's environment."

Both approaches are valid in my opinion. I simply feel more comfortable with the latter one. I did, however, give the Cell the ability to deduct it's next state in the OO approach, because that's how I felt an OO implementation would look like.

## Findings
---

What blew my mind after finishing the functional approach was that all the functions in the logic.rb (and logic.clj) were pure. Pure! No side-effects, same input will always give the same output. You know: *pure*. And every function in world.rb and cell.rb was impure. They all depended on "hidden" state of the World/Cell class. It is thought that one of the most prominent aspects of Object Oriented Programming is encapsulation. I disagree. C has perfect encapsulation. Having private state and calling it from impure functions does not make it encapsulated, it makes it hidden and dangerous.

This was a ton of fun to make in Clojure since data analysis and manipulation is so important in this game. Clojure takes the cake in that regard in my opinion, it's amazing!

## Tests
---

I did notice that testing in OO was a bit hackier than the functional one. Often I felt the need to test for internal state of my Cell objects. Testing a bunch of pure functions is a piece of cake: Give input, check output. Easy! And fast!