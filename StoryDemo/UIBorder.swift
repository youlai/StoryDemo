import UIKit
import Foundation

struct UIBorderSideType: OptionSet {
    var rawValue: Int
    init(rawValue: Int) {
        self.rawValue = rawValue
    }
    
    static var UIBorderSideTypeAll: UIBorderSideType = UIBorderSideType(rawValue: 0)
    static var UIBorderSideTypeLeft: UIBorderSideType = UIBorderSideType(rawValue: 1 << 0)
    static var UIBorderSideTypeRight: UIBorderSideType = UIBorderSideType(rawValue: 1 << 1)
    static var UIBorderSideTypeTop: UIBorderSideType = UIBorderSideType(rawValue: 1 << 2)
    static var UIBorderSideTypeBottom: UIBorderSideType = UIBorderSideType(rawValue: 1 << 3)
}

extension UIView {
    
    @discardableResult
    func border(color: UIColor, width: CGFloat, type: UIBorderSideType,cornerRadius:CGFloat) -> Self {
        
        if type.contains(UIBorderSideType.UIBorderSideTypeAll) {
            self.layer.borderColor = color.cgColor
            self.layer.borderWidth = width
            self.layer.cornerRadius = cornerRadius
            return self
        }
        
        if type.contains(UIBorderSideType.UIBorderSideTypeLeft) {
            self.layer.addSublayer(self.addLine(originPoint: CGPoint.zero, toPoint: CGPoint(x: 0, y: self.frame.size.height), color: color, width: width))
        }
        
        if type.contains(UIBorderSideType.UIBorderSideTypeRight) {
            self.layer.addSublayer(self.addLine(originPoint: CGPoint(x: self.frame.size.width, y: 0), toPoint: CGPoint(x: self.frame.size.width, y: self.frame.size.height), color: color, width: width))
        }
        
        if type.contains(UIBorderSideType.UIBorderSideTypeTop) {
            self.layer.addSublayer(self.addLine(originPoint: CGPoint(x: 0, y: 0), toPoint: CGPoint(x: self.frame.size.width, y: 0), color: color, width: width))
        }
        
        if type.contains(UIBorderSideType.UIBorderSideTypeBottom) {
            self.layer.addSublayer(self.addLine(originPoint: CGPoint(x: 0, y: self.frame.size.height), toPoint: CGPoint(x: self.frame.size.width, y: self.frame.size.height), color: color, width: width))
        }
        return self
    }
    
    func addLine(originPoint: CGPoint, toPoint: CGPoint, color: UIColor, width: CGFloat) -> CAShapeLayer {
        let bezierPath = UIBezierPath()
        bezierPath.move(to: originPoint)
        bezierPath.addLine(to: toPoint)
        
        let shapeLayer = CAShapeLayer()
        // 线宽度
        shapeLayer.lineWidth = width;
        shapeLayer.strokeColor = color.cgColor
        shapeLayer.fillColor = UIColor.clear.cgColor
        // 添加路径
        shapeLayer.path = bezierPath.cgPath
        return shapeLayer
    }
    ///加载XIB文件
    public class func initWithXibName(xib:String) -> Any? {
        guard let nibs:Array = Bundle.main.loadNibNamed(xib, owner: nil, options: nil)else{
            return nil;
        }
        return nibs[0] ;
    }
    var x: CGFloat {
        get { return frame.origin.x }
        set(newValue) {
            var tempFrame: CGRect = frame
            tempFrame.origin.x    = newValue
            frame                 = tempFrame
        }
    }
    
    var y: CGFloat {
        get { return frame.origin.y }
        set(newValue) {
            var tempFrame: CGRect = frame
            tempFrame.origin.y    = newValue
            frame                 = tempFrame
        }
    }
    
    var height: CGFloat {
        get { return frame.size.height }
        set(newValue) {
            var tempFrame: CGRect = frame
            tempFrame.size.height = newValue
            frame                 = tempFrame
        }
    }
    
    var width: CGFloat {
        get { return frame.size.width }
        set(newValue) {
            var tempFrame: CGRect = frame
            tempFrame.size.width  = newValue
            frame = tempFrame
        }
    }
    
    var size: CGSize {
        get { return frame.size }
        set(newValue) {
            var tempFrame: CGRect = frame
            tempFrame.size        = newValue
            frame                 = tempFrame
        }
    }
    
    var centerX: CGFloat {
        get { return center.x }
        set(newValue) {
            var tempCenter: CGPoint = center
            tempCenter.x            = newValue
            center                  = tempCenter
        }
    }
    
    var centerY: CGFloat {
        get { return center.y }
        set(newValue) {
            var tempCenter: CGPoint = center
            tempCenter.y            = newValue
            center                  = tempCenter;
        }
    }
    
    var centerRect: CGRect {
        return CGRect(x: bounds.midX, y: bounds.midY, width: 0, height: 0)
    }
}
