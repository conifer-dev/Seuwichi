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
    public private(set) var _currentState: State = voidState() // Void state is used when state machine is initialised to avoid all the unnecessary null checks.
    public var getCurrentState: State {_currentState} // Returns what state we're currently in.


    public init() { }

    /// Add a new state to the state machine.
    public mutating func insertState(_ state: State, withID id: String) {
        states[id] = state
    }

    /// Remove any state from the state machine.
    public mutating func removeState(id: String) {
        states.removeValue(forKey: id)
    }

    /// Remove all states from the state machine.
    public mutating func clearStates() {
        states.removeAll()
    }
}

extension StateMachine {
    /// Change from current state to another one present in the state machines dictionary.
    public mutating func changeState(id: String) {
        _currentState.onExit()
        guard var nextState:State = states[id] else {
            assertionFailure("No state found! Please ensure you're passing the correct State ID!")
            return
        } 
        nextState.onEnter()
        _currentState = nextState
    }
}

extension StateMachine {
    /// States own update function.
    public mutating func update() {
        _currentState.update()
    }
}

extension StateMachine {
    /// State render function.
    public mutating func render() {
        _currentState.render()
    }
}