//
//  ContentView.swift
//  GraphBuilder
//
//  Created by Antonio De Luca on 16/05/23.
//

import SwiftUI
import Charts

struct ContentView: View {
    
    var body: some View {
        
        let dataPoints: [DataPoint] = [
            DataPoint(x: 1, y: 1),
            DataPoint(x: 2, y: 2),
            DataPoint(x: 3, y: 3),
            DataPoint(x: 4, y: 4)
        ]
        
        Chart(dataPoints) {dataPoint in
            LineMark(
                x: .value("X", dataPoint.x),
                y: .value("Y", dataPoint.y)
            )
            PointMark(
                x: .value("", dataPoint.x),
                y: .value("", dataPoint.y)
            ).foregroundStyle(Color.red)
        }
        
        .frame(width: 320, height: 320)
        
        
// This sets up the chart overlay modifier, allowing you to add additional content or behavior on top of the chart.
        .chartOverlay { proxy in

// 1. GeometryReader -> Creates a container that provides geometry information about the size and position of the chart.
// 2. Rectable() -> Draws an invisible rectangle to capture touch events. The contentShape modifier makes the rectangle respond to touch events as if it were visible.
            
            GeometryReader { geometry in
                Rectangle().fill(Color.clear).contentShape(Rectangle())
                    .gesture(
                        DragGesture()
                            .onChanged { value in
                                
                                // Convert the gesture location to the coordinate space of the plot area.
                                // Retrieves the origin (top-left corner) of the plot area frame relative to the geometry container.
                                
                                let origin = geometry[proxy.plotAreaFrame].origin
                                let location = CGPoint(
                                    x: value.location.x - origin.x,
                                    y: value.location.y - origin.y
                                )
                                
                                // Get the x (date) and y (price) value from the location.
                                
                                if let (x, y) = proxy.value(at: location, as: (Double, Double).self) {
                                    print("Location: \(x), \(y)")
                                    
                                    let closestTimestamp = dataPoints.min { a, b in
                                        let aDistance = abs(Double(a.x) - x)
                                        let bDistance = abs(Double(b.x) - x)
                                        print("aDistance: \(aDistance)")
                                        print("bDistance: \(bDistance)")
                                        return aDistance < bDistance
                                        
                                        
                                    }?.x
                                    
                                if let closestTimestamp = closestTimestamp {
                                    // Do something with the closest timestamp
                                    
                                    print("Closest Timestamp: \(closestTimestamp)")
                                    }
                                }
                            }
                    )
            }
        }
    }
}
// var body: some View <->








struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
