public protocol State {
    mutating func update()
    mutating func handleInput()
    mutating func enter()
    mutating func exit()
    func change(id: String)
}

internal struct emptyState: State {
    mutating func update() {}

    mutating func handleInput() {}

    mutating func enter() {}

    mutating func exit() {}

    func change(id: String) {}
}


public struct stateMachine {
    var states: [String: State] = [:]
    var currentState:State = emptyState()
    var getCurrentState: State {
        get { return currentState }
    }
}

extension stateMachine {
    public mutating func add(id: String, state: State) {
        states[id] = state
    }
}

extension stateMachine {
    public mutating func remove(id: String) {
        states.removeValue(forKey: id)
    }
}

extension stateMachine {
    public mutating func clear() {
        states.removeAll()
    }
}

extension stateMachine {
    public mutating func change(id: String) {
        currentState.exit()
        guard var nextState:State = states[id] else {
            assertionFailure("No state found!")
            return
        } 
        nextState.enter()
        currentState = nextState
    }
}

extension stateMachine {
    public mutating func update() {
        currentState.update()
    }
}

extension stateMachine {
    public mutating func handleInput() {
        currentState.handleInput()
    }
}