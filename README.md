# Seuwichi 스위치 - Plain simple State Machine.

About
=====
*A very simplistic state machine system* for Swift while mainly used with [Raylib on Swift.](https://github.com/STREGAsGate/Raylib)

Seuwichi allows you to easily create, manage and transition states at ease without any complexities. It was created with ease of usability in mind.

Seuwichi is a Korean word for *"Switch"* (for example: light switch.). The reason for the name is rather simple, a switch allows us to change from a one state to another.

Instructions
=====
Setting up Seuwichi is very easy and using it is even easier!

Make sure you added Seuwichi as your dependency package and imported to your file!

```swift
.package(url: "https://github.com/conifer-dev/Seuwichi.git", .branch("main"))
```

```swift
import Seuwichi
```

Firstly, our state machine has to be initialised! Once initialised, the state machine is set to a void state that represents an empty state that will be no longer part of the state machine upon changing the state.

```swift
var myStateMachine = StateMachine() // Initialisation of our state machine
```

Now we have to create a new state and add it to our state machine. It's very easy to do!
```swift
struct MenuState: State {
    mutating func update() { 
        // handle your update here... 
    }
    
    mutating func render() {
        // handle your render here... 
    }

    mutating func onEnter() {
        // any functionalities/initialisation you want to happen when you enter/switch to the state...
    }

    mutating func onExit() {
        // any functionalities/initialisation you want to happen when you exit/switch from the state...
    }
}

struct GameState: State {
    mutating func update() { 
        // handle your update here... 
    }
    
    mutating func render() {
        // handle your render here... 
    }

    mutating func onEnter() {
        // any functionalities/initialisation you want to happen when you enter/switch to the state...
    }

    mutating func onExit() {
        // any functionalities/initialisation you want to happen when you exit/switch from the state...
    }
}
```
Here we have two newly created (and empty for example purposes) states using the "State" protocol, every state has to adopt the State protocol! Now we have to add them to our state machine!

```swift
myStateManager.insertState(gameState(), withID: "gameState") // Adding our newly created state to our state machine. All states are stored within a dictionary.
myStateManager.insertState(menuState(), withID: "menuState")
```
Now that our state has been successfully added, we're ready to change our states! To change our state all we need to do is pass through a `.changeState()` function to our state machine.

```swift
myStateMachine.changeState(id: "gameStart") // .changeState() function takes in a single parameter "id" that looks into our dictionary of states previously added.
// Beware that attempting to change to a state that does not exist will result in an error!
```
And you're done! You've successfully created a state machine, added a state to the machine and changed the state! It's as simple as that.
Down below we will explain thorougly each function (and those not mentioned above) and what they do.

### State Machine Functions

| Function    | Example               | Description                                                                                                                                                                               |
| ----------|-----------------------|-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| __.insertState(_ state: State, withID id: String)__ | `myStateMachine.changeState(id: "gameStart")`  | Adds a newly created state to our state machine.
| __.removeState(id: String)__ | `myStateMachine.removeState("menuState")`   | Removes the passed state ID from our state machine.  |
| __.clearStates()__   | `myStateMachine.clearStates()` | Removes all entries of States previously added to our state machine.                                              |
| __.changeState(id: String)__ | `myStateMachine.changeState(id: "gameState")`  | Changing to a passed through game state (ID). This will automatically call states own .onEnter() function. Passing through nonexistent ID will result in an error! Make sure you added your state to the state machine prior to changing.| 

### State Functions

| Function | Description |
|---|---|
| __.update()__ | All updates within the state are called here e.g. player movement. |
| __.render()__ | All rendering within the state are called here e.g. player sprite or a menu state. |
| __.onEnter()__ | onEnter function is called in on every state change, therefore its useful to use onEnter to initialise your code or set your animation to reflect what animation state your entity will be in. |
| __.onExit()__ | The opposite of onEnter(). This function will be also called during the change of states |

Closing notes
=====
This state machine is **very** simple, and I hope that many new programmers/game devs can look at the code and understand how to create one themselves, but also use it if they feel like it. This was mainly created for my own purposes as I re-create one of my Love2D games in [Raylib on Swift.](https://github.com/STREGAsGate/Raylib). Please feel free to send PRs on how to improve Seuwichi and perhaps how to make it even more *Swifty*.

Creating this state machine taught me a little bit more about protocols which was also the objective of this project.
