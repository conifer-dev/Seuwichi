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
    public var states: [String: State] = [:]
    public var currentState:State = emptyState()
    public var getCurrentState: State {
        get { return currentState }
    }

    public init(currentState: State) {
        self.currentState = currentState
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
            assertionFailure("No state found! Please ensure you're passing the correct State ID!")
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