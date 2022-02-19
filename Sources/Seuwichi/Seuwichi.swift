public protocol State {
    mutating func update()
    mutating func render()
    mutating func onEnter()
    mutating func onExit()
}

internal struct voidState: State {
    mutating func update() { }

    mutating func render() { }

    mutating func onEnter() { }

    mutating func onExit() { }
}


public struct StateMachine {
    private var states: [String: State] = [:] // Dictionary that holds all states created by user.
    private var currentState:State = voidState() // Void state is used when state machine is initialised to avoid all the unnecessary null checks.
    public var getCurrentState: State { // Returns what state we're currently in.
        get { return currentState}
    }

    public init() { }
}

extension StateMachine {
    /// Add a new state to the state machine.
    public mutating func add(id: String, state: State) {
        states[id] = state
    }
}

extension StateMachine {
    /// Remove any state from the state machine.
    public mutating func remove(id: String) {
        states.removeValue(forKey: id)
    }
}

extension StateMachine {
    /// Remove all states from the state machine.
    public mutating func clear() {
        states.removeAll()
    }
}

extension StateMachine {
    /// Change from current state to another one present in the state machines dictionary.
    public mutating func change(id: String) {
        currentState.onExit()
        guard var nextState:State = states[id] else {
            assertionFailure("No state found! Please ensure you're passing the correct State ID!")
            return
        } 
        nextState.onEnter()
        currentState = nextState
    }
}

extension StateMachine {
    /// States own update function.
    public mutating func update() {
        currentState.update()
    }
}

extension StateMachine {
    /// State render function.
    public mutating func render() {
        currentState.render()
    }
}