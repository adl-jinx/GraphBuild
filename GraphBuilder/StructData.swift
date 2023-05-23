//
//  StructData.swift
//  GraphBuilder
//
//  Created by Antonio De Luca on 16/05/23.
//

import Foundation

public struct DataPoint: Identifiable {
    public var id = UUID()
    public var x: Double
    public var y: Double
}



public let dataPoints: [DataPoint] = [
DataPoint(x: 1, y: 1),
DataPoint(x: 2, y: 2),
DataPoint(x: 3, y: 3),
DataPoint(x: 4, y: 4)
]
