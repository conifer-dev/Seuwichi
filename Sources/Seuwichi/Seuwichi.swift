public protocol State {
    mutating func update()
    mutating func handleInput()
    mutating func enter()
    mutating func exit()
    func change(id: String)
}

public struct emptyState: State {
    public mutating func update() {}

    public mutating func handleInput() {}

    public mutating func enter() {}

    public mutating func exit() {}

    public func change(id: String) {}
}


public struct stateMachine {
    public var states: [String: State] = [:] // Dictionary that holds all states created by user.
    public var currentState:State = emptyState() // Empty state is used when state machine is initialised to avoid all the null checks.
    public var getCurrentState: State { // Returns what state we're currently in.
        get { return currentState }
    }

    public init() { }
}

extension stateMachine {
    /// Add a new state to the state machine.
    public mutating func add(id: String, state: State) {
        states[id] = state
    }
}

extension stateMachine {
    /// Remove any state from the state machine.
    public mutating func remove(id: String) {
        states.removeValue(forKey: id)
    }
}

extension stateMachine {
    /// Remove all states from the state machine.
    public mutating func clear() {
        states.removeAll()
    }
}

extension stateMachine {
    /// Change from current state to another one present in the state machines dictionary.
    public mutating func change(id: String) {
        currentState.exit()
        guard var nextState:State = states[id] else {
            assertionFailure("No state found! Please ensure you're passing the correct State ID!")
            return
        } 
        nextState.enter()
        currentState = nextState
    }
}

extension stateMachine {
    /// States own update function.
    public mutating func update() {
        currentState.update()
    }
}

extension stateMachine {
    /// States own input handling.
    public mutating func handleInput() {
        currentState.handleInput()
    }
}