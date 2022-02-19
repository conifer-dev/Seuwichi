<p align="center">
  <img src="https://i.imgur.com/uYwVATH.png" />
</p>

# About
*A very simplistic state machine system* for Swift while mainly used with [Raylib on Swift.](https://github.com/STREGAsGate/Raylib)

Seuwichi allows you to easily create, manage and transition states at ease without any complexities. It was created with ease of usability in mind.

Seuwichi is a Korean word for *"Switch"* (for example: light switch.). The reason for the name is rather simple, a switch allows us to change from a one state to another.

Instructions
=====
Setting up Seuwichi is very easy and using it is even easier!

Firstly make sure you added Seuwichi as your dependency package!

```swift
.package(url: "https://github.com/conifer-dev/Seuwichi.git", .branch("main"))
```

Firstly, our state machine has to be initialised! Once initialised, the state machine is set to a void state that represents an empty state that will be no longer part of the state machine upon changing the state.

```swift
var myStateManager = stateMachine() // Initialisation of our state manager
```

Now we have to create a new state and add it to our state manager. It's very easy to do!
```swift
struct Menu: State {
    mutating func update() { 
        // handle your update here... 
    }

    mutating func onEnter() {
        // any functionalities/initialisation you want to happen when you enter/switch to the state...
    }

    mutating func onExit() {
        // any functionalities/initialisation you want to happen when you exit/switch from the state...
    }
}

struct Game: State {
    mutating func update() { 
        // handle your update here... 
    }

    mutating func onEnter() {
        // any functionalities/initialisation you want to happen when you enter/switch to the state...
    }

    mutating func onExit() {
        // any functionalities/initialisation you want to happen when you exit/switch from the state...
    }
}
```
Here we have two newly created (and empty for example purposes) states using the "State" protocol, every state has to adopt the State protocol! Now we have to add them to our state manager/machine!

```swift
myStateManager.add(id: "game", state: Game()) // Adding our newly created state to our state machine/manager. All states are stored within a dictionary.
myStateManager.add(id: "game", state: Menu())
```
Now that our state has been successfully added, we're ready to change our states when needed!