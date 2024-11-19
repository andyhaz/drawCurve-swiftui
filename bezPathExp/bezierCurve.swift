//
//  bezierCurve.swift
//  ACME 2D
//
//  Created by andyhaz on 11/1/24.
//

import AppKit
import Cocoa
import Foundation

class BezierCurve {
    let controlPoints: [(x: Double, y: Double)]

    init(controlPoints: [(x: Double, y: Double)]) {
        self.controlPoints = controlPoints
    }
    
    lazy var curvePoints: [CGPoint] = {
            var points = [CGPoint]()
            for i in 0..<100 {
                let t = Double(i) / 99.0
                let point = self.pointAt(t: t)
                points.append(point)
            }
            return points
        }()
    
    func pointAt(t: Double) -> CGPoint {
        guard controlPoints.count == 4 else {
            fatalError("Bezier curve requires exactly 4 control points.")
        }

        let p0 = controlPoints[0]
        let p1 = controlPoints[1]
        let p2 = controlPoints[2]
        let p3 = controlPoints[3]

        let cX = 3 * (p1.x - p0.x)
        let bX = 3 * (p2.x - p1.x) - cX
        let aX = p3.x - p0.x - cX - bX

        let cY = 3 * (p1.y - p0.y)
        let bY = 3 * (p2.y - p1.y) - cY
        let aY = p3.y - p0.y - cY - bY

        let x = (aX * pow(t, 3)) + (bX * pow(t, 2)) + (cX * t) + p0.x
        let y = (aY * pow(t, 3)) + (bY * pow(t, 2)) + (cY * t) + p0.y

        return CGPoint(x: x, y: y)
    }

    func generatePoints(numPoints: Int) -> [CGPoint] {
        var points = [CGPoint]()
        for i in 0..<numPoints {
            let t = Double(i) / Double(numPoints - 1)
            let point = pointAt(t: t)
            points.append(point)
        }
        return points
    }
}
