//
//  CircleButton.swift
//  EnglishName
//
//  Created by Ding on 3/14/16.
//  Copyright © 2016 Ding. All rights reserved.
//

import UIKit


@IBDesignable class TargetLockButton: UIButton {
    
 
    @IBInspectable var allowsTouchTracking : Bool = false
    
    @IBInspectable var circleColor : UIColor! = UIColor.darkGrayColor() {
        didSet{
            circleLayer.strokeColor = circleColor.CGColor
        }
    }
    @IBInspectable var fillColor : UIColor = UIColor.clearColor() {
        didSet{
            circleLayer.fillColor = fillColor.CGColor
        }
    }
    @IBInspectable var circleWidth : CGFloat = 1 {
        didSet{
            circleLayer.lineWidth = circleWidth
        }
    }
    
    private var scaleFactor : CGFloat = 1
    
    
    private var circleLayer: CAShapeLayer!
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        initializer()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        initializer()
    }
    
    private func initializer() {
        
        
        self.backgroundColor = UIColor.clearColor()
        
        
        
        let maskLayer = CAShapeLayer()
        maskLayer.path = UIBezierPath(roundedRect: bounds,
            cornerRadius: bounds.size.width/2).CGPath
        
        
        maskLayer.fillColor = fillColor.CGColor
        maskLayer.strokeColor = circleColor.CGColor
        maskLayer.lineWidth = circleWidth
        maskLayer.miterLimit = 4
        maskLayer.lineCap = kCALineCapRound
        maskLayer.masksToBounds = false
        maskLayer.bounds = self.bounds
        maskLayer.actions = [
            
            "transform": NSNull()
        ]
        
        
        circleLayer = maskLayer

        
        
        
        self.layer.addSublayer(circleLayer)
        
        
        resetPosition()
    }
    
    override func layoutSublayersOfLayer(layer: CALayer) {
        super.layoutSublayersOfLayer(layer)
        
        
    }

    
    private func resetPosition(){
        self.circleLayer.anchorPoint = CGPointMake(0.5, 0.5)
        circleLayer.position = CGPointMake(bounds.size.width/2, bounds.size.height/2)
    }
    
    
    
    override func beginTrackingWithTouch(touch: UITouch, withEvent event: UIEvent?) -> Bool {
        
        let touchCenterLocation = touch.locationInView(self)
        let majorRadius = touch.majorRadius
        
        
        
        let translationAnimation = CABasicAnimation(keyPath: "position")
        translationAnimation.timingFunction = CAMediaTimingFunction(controlPoints: 0.5, -0.8, 0.5, 1.85)
        translationAnimation.duration = 0.4
        translationAnimation.fillMode = kCAFillModeBackwards
        
        translationAnimation.toValue = NSValue(CGPoint : touchCenterLocation)
        translationAnimation.beginTime = CACurrentMediaTime() + 0.05
        
        
        
        let transform = CABasicAnimation(keyPath: "transform")
        transform.timingFunction = CAMediaTimingFunction(controlPoints: 0.5, -0.8, 0.5, 1.85)
        transform.duration = 0.4
        transform.fillMode = kCAFillModeBackwards
        
        var scale = (majorRadius * 3) / circleLayer.bounds.size.width
        
        scale = [scale, 0.2].maxElement()!

        scaleFactor = scale

        transform.toValue = NSValue(CATransform3D: CATransform3DMakeScale(scale, scale, 1))
        transform.beginTime = CACurrentMediaTime() + 0.05
        
        
        circleLayer.ld_applyAnimation(transform)
        circleLayer.ld_applyAnimation(translationAnimation)


        return super.beginTrackingWithTouch(touch, withEvent: event)

    }

    override func continueTrackingWithTouch(touch: UITouch, withEvent event: UIEvent?) -> Bool {
        
        if allowsTouchTracking {
            let touchCenterLocation = touch.locationInView(self)
            circleLayer.position = touchCenterLocation
        }
        
        
        return super.continueTrackingWithTouch(touch, withEvent: event)
    }
    
    
    
    override  func cancelTrackingWithEvent(event: UIEvent?) {
        super.cancelTrackingWithEvent(event)

        resetPositionAnimation()
        
        
    }
    
    override  func endTrackingWithTouch(touch: UITouch?, withEvent event: UIEvent?) {
        
        resetPositionAnimation()
        
        super.endTrackingWithTouch(touch, withEvent: event)
        
    }

    func resetPositionAnimation(){
        
        let transform = CABasicAnimation(keyPath: "transform")
        transform.timingFunction = CAMediaTimingFunction(controlPoints: 0.5, -0.8, 0.5, 1.85)
        transform.duration = 0.5
        transform.fillMode = kCAFillModeBackwards
        
        
        transform.toValue = NSValue(CATransform3D: CATransform3DIdentity)
        transform.beginTime = CACurrentMediaTime() + 0.05
        
        circleLayer.ld_applyAnimation(transform)
        
        resetPosition()
    }

}


private extension CALayer {
    
    func ld_applyAnimation(animation: CABasicAnimation) {
        let copy = animation.copy() as! CABasicAnimation
        
        if copy.fromValue == nil {
            copy.fromValue = self.presentationLayer()!.valueForKeyPath(copy.keyPath!)
        }
        
        self.addAnimation(copy, forKey: copy.keyPath)
        self.setValue(copy.toValue, forKeyPath:copy.keyPath!)
    }

}
