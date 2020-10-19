//
//  Cell.swift
//  GOL
//
//  Created by Fabiola S on 10/19/20.
//

import Foundation

struct Cell {
    var isAlive = false

    static func makeDeadCell() -> Cell {
        return Cell(isAlive: false)
    }

    static func makeLiveCell() -> Cell {
        return Cell(isAlive: true)
    }
}
