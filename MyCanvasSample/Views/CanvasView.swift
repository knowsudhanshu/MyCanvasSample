//
//  CanvasView.swift
//  MyCanvasSample
//
//  Created by Sudhanshu Sudhanshu on 08/01/19.
//  Copyright © 2019 Sudhanshu Sudhanshu. All rights reserved.
//

import UIKit

struct Line {
    let width: Float
    let color: CGColor
    var points: [CGPoint]
}

class CanvasView: UIView {
    
    fileprivate var lineWidth: Float = 1
    func setLineWidth(_ width: Float) {
        lineWidth = width
    }
    
    fileprivate var strokeColor = UIColor.black.cgColor
    func setStrokeColor(_ color: UIColor) {
        strokeColor = color.cgColor
    }
    
    func undo() {
        _ = lines.popLast()
        setNeedsDisplay()
    }
    
    func clear() {
        lines.removeAll()
        setNeedsDisplay()
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        guard let context = UIGraphicsGetCurrentContext() else { return }
        
        lines.forEach { (line) in
            context.setStrokeColor(line.color)
            context.setLineWidth(CGFloat(line.width))
            context.setLineCap(.round)

            for (index, point) in line.points.enumerated() {
                if index == 0 {
                    context.move(to: point)
                }else {
                    context.addLine(to: point)
                }
            }
            context.strokePath()
        }
        
    }
    
    var lines = [Line]()
    
    // Gesture Recgnizers
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        lines.append(Line(width: lineWidth, color: strokeColor, points: []))
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        guard let point = touches.first?.location(in: nil) else { return }
        
        guard var lastLine = lines.popLast() else { return }
        lastLine.points.append(point)
        
        lines.append(lastLine)
        
        setNeedsDisplay()
    }
}
