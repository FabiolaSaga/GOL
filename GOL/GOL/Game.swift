//
//  Game.swift
//  GOL
//
//  Created by Fabiola S on 10/19/20.
//

import Foundation


typealias GameStateObserver = ((GameState) -> Void)?

class Game {
    let width: Int
    let height: Int
    var currentState: GameState
    var timer: Timer?
    var generationCount: Int

    init(width: Int, height: Int) {
        self.width = width
        self.height = height
        self.generationCount = 0
        let cells = Array(repeating: Cell.makeDeadCell(), count: width * height)
        currentState = GameState(cells: cells)
    }
    
    // Set up the observer with a random pattern and start the timer which will update the view after each iteration
    func start(gameSpeed: Double, _ observer: GameStateObserver) {
        observer?(randomize())
        timer = Timer.scheduledTimer(withTimeInterval: gameSpeed, repeats: true) { _ in
            observer?(self.iterate())
        }
    }
    
    // Generate a random pattern of alive/dead cells
    @discardableResult
    func randomize() -> GameState {
        generationCount = 0
        let maxItems = width * height - 1
        for point in 0...maxItems {
            currentState[point] = Cell.makeDeadCell()
        }
        
        let initialStatePoints = self.generateRandom(between: 0...maxItems, count: maxItems/8)
        
        for point in initialStatePoints {
            currentState[point] = Cell.makeLiveCell()
        }
        
        return self.currentState
    }
    
    // Stop the execution of the game by deactivating the timer
    @discardableResult
    func stop() -> GameState {
        timer?.invalidate()
        return self.currentState
    }
    
    // Clear the game board by removing points and deactivating the timer
    @discardableResult
    func clear() -> GameState {
        generationCount = 0
        for point in 0...624 {
            currentState[point] = Cell.makeDeadCell()
        }
        
        timer?.invalidate()
        return self.currentState
    }
    
    // MARK: - Presets
    // Methods that run preset configurations on the game board
    
    @discardableResult
    func runPreset1() -> GameState {
        generationCount = 0
        for point in 0...624 {
            currentState[point] = Cell.makeDeadCell()
        }
        
        for point in 0...24 {
            currentState[point] = Cell.makeLiveCell()
        }
        
        return self.currentState
    }
    
    @discardableResult
    func runPreset2() -> GameState {
        generationCount = 0
        for point in 0...624 {
            currentState[point] = Cell.makeDeadCell()
        }
        
        for point in 0...200 {
            if point % 2 == 0 {
                currentState[point] = Cell.makeLiveCell()
            }
        }
        
        return self.currentState
    }
    
    @discardableResult
    func runPreset3() -> GameState {
        generationCount = 0
        for point in 0...624 {
            currentState[point] = Cell.makeDeadCell()
        }
        
        for point in 300...600 {
            currentState[point] = Cell.makeLiveCell()
        }
        
        return self.currentState
    }
    
    @discardableResult
    func runPreset4() -> GameState {
        generationCount = 0
        for point in 0...624 {
            currentState[point] = Cell.makeDeadCell()
        }
        
        for point in 0...624 {
            if point % 2 == 0 {
                currentState[point] = Cell.makeLiveCell()
            }
        }
        
        return self.currentState
    }
    
    // MARK: - Core Game Logic

    func iterate() -> GameState {
        var nextState = currentState
        self.generationCount += 1
        for i in 0...width - 1 {
            for j in 0...height - 1 {
                let positionInTheArray = j * width + i
                nextState[positionInTheArray] = Cell(isAlive: state(x: i, y: j))
            }
        }

        self.currentState = nextState
        return nextState
    }

    func state(x: Int, y: Int) -> Bool {
        let numberOfAliveNeighbours = aliveNeighborCountAt(x: x, y: y)
        let position = x + y*width

        let wasPreviouslyAlive = currentState[position].isAlive
        if wasPreviouslyAlive {
            return numberOfAliveNeighbours == 2 || numberOfAliveNeighbours == 3
        } else {
            return numberOfAliveNeighbours == 3
        }
    }

    func aliveNeighborCountAt(x: Int, y: Int) -> Int {
        var numberOfAliveNeighbours = 0
        for i in x-1...x+1 {
            for j in y-1...y+1 {
                if (i == x && y == j) || (i >= width) || (i < 0) || (j < 0) { continue }

                let index = j*width + i

                guard index >= 0 && index < width*height else { continue }
                if currentState[index].isAlive {
                    numberOfAliveNeighbours += 1
                }
            }
        }
        return numberOfAliveNeighbours
    }
    
    func setInitialState(_ state: GameState) {
        currentState = state
    }

    @discardableResult
    func generateInitialState() -> GameState {
        let maxItems = width * height - 1
        let initialStatePoints = self.generateRandom(between: 0...maxItems, count: maxItems/8)

        for point in initialStatePoints {
            currentState[point] = Cell.makeLiveCell()
        }

        return self.currentState
    }
    
    private func generateRandom(between range: ClosedRange<Int>, count: Int) -> [Int] {
            return Array(0...count).map { _ in
                Int.random(in: range)
            }
        }

}
