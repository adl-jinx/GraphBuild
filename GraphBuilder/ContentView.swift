/*
        ContentView.swift + Building the logic
        GraphBuilder
        Created by Antonio De Luca on 16/05/23.
    
        This app is only to show the potentiality of Swift Charts, the system takes a series of points and plot a graph in a frame.
 
        There is a geometry reader, with a rectangle and a proxy to track user touch, once the user drag the finger on the graph it will calculate with a simple algorithm the closest point and store it in the
 
*/
 
 
 
 
import SwiftUI
import Charts

struct ContentView: View {
    
    // State variable to store the cycles value, initialized as 0
    @State var cdpX: Double = 0
    
    // State variable to store the movement value, initialized as 0
    @State var cdpY: Double = 0
    
    // State variable to store the closest data point to the user's touch, initially it's nil because no touch has occurred yet
    @State private var closestDataPoint: DataPoint? = nil
    
    var body: some View {
        // An array of DataPoint objects to be displayed on the chart
        let dataPoints: [DataPoint] = [
            DataPoint(pointX: 1, pointY: 1),
            DataPoint(pointX: 2, pointY: 2),
            DataPoint(pointX: 3, pointY: 25),
            DataPoint(pointX: 4, pointY: 4)
        ]
        
        // The Chart view that will contain the LineMarks and PointMarks
        Chart {
            // For each data point in the array
            ForEach(dataPoints) { dataPoint in
                // Create a LineMark at the x and y coordinates of the data point
                LineMark(
                    x: .value("X", dataPoint.pointX),
                    y: .value("Y", dataPoint.pointY)
                )
                
                // If the current data point is the one closest to the user's touch
                if dataPoint.pointY == closestDataPoint?.pointY {
                    // Create a PointMark at the x and y coordinates of the data point
                    PointMark(
                        x: .value("frate", dataPoint.pointX),
                        y: .value("frate", dataPoint.pointY))
                }
            }
        }
        .frame(width: 320, height: 320)  // Set the size of the Chart view
        .chartOverlay { proxy in
            // GeometryReader gives us access to the size and position of the Chart view
            GeometryReader { geometry in
                // An invisible rectangle that will detect touch gestures
                Rectangle()
                    .fill(Color.clear)  // Make it invisible
                    .contentShape(Rectangle())  // Allow it to detect touches anywhere inside the rectangle
                    .gesture(
                        // The gesture we're interested in is a drag (touch and move)
                        DragGesture()
                            .onChanged { value in  // When the drag gesture changes (when the user moves their finger)
                                // Get the top-left corner of the plot area
                                let origin = geometry[proxy.plotAreaFrame].origin
                                
                                // Calculate the location of the user's touch relative to the plot area
                                let location = CGPoint(
                                    x: value.location.x - origin.x,
                                    y: value.location.y - origin.y
                                )
                                
                                // Try to get the x (timeStamp) and y (unused) values at the touch location
                                if let (pointX, _) = proxy.value(at: location, as: (Double, Double).self) {
                                    // Find the data point that has the closest timeStamp to the one at the touch location
                                    self.closestDataPoint = dataPoints.min { a, b in
                                        let aDistance = abs(a.pointX - pointX)
                                        let bDistance = abs(b.pointX - pointX)
                                        return aDistance < bDistance
                                    }
                                    
                                    // If we found a closest data point
                                    if let closestDataPoint = self.closestDataPoint {
                                        // Update the cycles state variable with the timeStamp of the closest data point
                                        self.cdpX = Double(closestDataPoint.pointX)
                                        
                                        // Update the movement state variable with the y value of the closest data point
                                        self.cdpY = closestDataPoint.pointY
                                        
                                        // Print the closest data point to the console for debugging but doens't print anything.
                                        print(closestDataPoint)
                                        print("cdpX, \(cdpX)")
                                        print("cdpY, \(cdpY)")
                                        print("location touched, \(location)")
                                    }
                                }
                                
                            
                                
                            }
                    )
            }
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
