//
//  Game.swift
//  GOL
//
//  Created by Fabiola S on 10/19/20.
//

import Foundation

class Game {
    let width: Int
    let height: Int
    var currentState: GameState

    init(width: Int, height: Int) {
        self.width = width
        self.height = height
        let cells = Array(repeating: Cell.makeDeadCell(), count: width * height)
        currentState = GameState(cells: cells)
    }

    func iterate() -> GameState {
        var nextState = currentState
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

}