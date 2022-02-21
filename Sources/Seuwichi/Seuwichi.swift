public protocol State {
    func update()
    func render()
    func onEnter()
    func onExit()
}

internal class voidState: State {
    func update() { }

    func render() { }

    func onEnter() { }

    func onExit() { }
}

open class StateMachine {
    private var states: [String: State] = [:] // Dictionary that holds all states created by user.
    public private(set) var _currentState: State = voidState() // Void state is used when state machine is initialised to avoid all the unnecessary null checks.
    public var getCurrentState: State {_currentState} // Returns what state we're currently in.


    public init() { }

    /// Add a new state to the state machine.
    public func insertState(_ state: State, withID id: String) {
        self.states[id] = state
    }

    /// Remove any state from the state machine.
    public func removeState(id: String) {
        self.states.removeValue(forKey: id)
    }

    /// Remove all states from the state machine.
    public func clearStates() {
        self.states.removeAll()
    }

    /// States own update function.
    public func update() {
        self._currentState.update()
    }

    /// State render function.
    public func render() {
        self._currentState.render()
    }
    
    /// Change from current state to another one present in the state machines dictionary.
    public func changeState(id: String) {
        self._currentState.onExit()
        guard let nextState:State = states[id] else {
            assertionFailure("No state found! Please ensure you're passing the correct State ID!")
            return
        } 
        nextState.onEnter()
        self._currentState = nextState
    }

    deinit {
        self.clearStates()
    }
}