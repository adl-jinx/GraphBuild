//
//  StructData.swift
//  GraphBuilder
//
//  Created by Antonio De Luca on 16/05/23.
//

import Foundation

public struct DataPoint: Identifiable {
    public var id = UUID()
    public var pointX: Double
    public var pointY: Double
}



public let dataPoints: [DataPoint] = [
DataPoint(pointX: 1, pointY: 1),
DataPoint(pointX: 2, pointY: 2),
DataPoint(pointX: 3, pointY: 3),
DataPoint(pointX: 4, pointY: 4)
]
