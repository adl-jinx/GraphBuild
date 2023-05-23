////
////  Overlay.swift
////  GraphBuilder
////
////  Created by Antonio De Luca on 16/05/23.
////
//
//import Foundation
//
//
//
//   
//    .chartOverlay{ proxy in
//                   GeometryReader { geometry in
//                       Rectangle().fill(.clear).contentShape(Rectangle())
//                           .gesture(
//                               DragGesture()
//                                   .onChanged { value in
//                                       // Convert the gesture location to the coordiante space of the plot area.
//                                       let origin = geometry[proxy.plotAreaFrame].origin
//                                       let location = CGPoint(
//                                           x: value.location.x - origin.x,
//                                           y: value.location.y - origin.y
//                                       )
//                                       // Get the x () and y () value from the location.
//                                       
//                                       let (timeStamp, _) = proxy.value(at: location, as: (Double, Int).self)!
//                                       
//                                       let closestTimestamp = dataPoints.min { a, b in
//                                           let aDistance = abs(Double(a.timeStamp) - timeStamp)
//                                           let bDistance = abs(Double(b.timeStamp) - timeStamp)
//                                           return aDistance < bDistance
//                                       }?.timeStamp
//                                       
//                                       if let closestTimestamp = closestTimestamp {
//                                           xm = closestTimestamp
//                                           ym = dataPoints.first(where: { $0.timeStamp == closestTimestamp })?.rabbits ?? 0
//                                       }
//                                       
//                                   })
//                   } // Geometry Reader
//               } // Overlay End
