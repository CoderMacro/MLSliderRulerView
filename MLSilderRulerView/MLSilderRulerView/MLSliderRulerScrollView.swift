//
//  MLSliderRuler.swift
//  MLSilderRulerView
//
//  Created by Macro on 2018/1/25.
//  Copyright © 2018年 CodeMarco. All rights reserved.
//

import UIKit

let DISTANCELEFTANDRIGHT: CGFloat = 8.0 // 标尺左右距离
let DISTANCEVALUE: CGFloat = 8.0 // 每隔刻度实际长度8个点
let DISTANCETOPANDBOTTOM: CGFloat = 5.0 // 标尺上下距离

class MLSliderRulerScrollView: UIScrollView {
    
    var rulerValue: CGFloat = 160
    
    var maxValue: CGFloat = 220
    var minValue: CGFloat = 100
    
    var rulerCount: Int {
        return Int(maxValue - minValue)
    }
    
    var rulerAverage: CGFloat = 1
    
    /// 是否显示最小刻度
    var isShowShortSymbol = true
    /// 居中显示模式
    var isSmallModel: Bool = true
    
    var binary: Int = 10
    
    var ruleFont = UIFont.systemFont(ofSize: 12)
    
    /// 长刻度颜色
    var longSymbolColor = UIColor.black {
        didSet {
            longSymbol.strokeColor = longSymbolColor.cgColor
        }
    }
    /// 中等刻度颜色
    var middleSymbolColor = UIColor.gray {
        didSet {
            middleSymbol.strokeColor = middleSymbolColor.cgColor
        }
    }
    /// 短刻度颜色
    var shortSymbolColor = UIColor.lightGray {
        didSet {
            shortSymbol.strokeColor = shortSymbolColor.cgColor
        }
    }
    
    /// 长刻度
    fileprivate lazy var longSymbol: CAShapeLayer = {
        let shapeLayer = CAShapeLayer()
        shapeLayer.strokeColor = longSymbolColor.cgColor
        shapeLayer.fillColor = UIColor.clear.cgColor
        shapeLayer.lineWidth = 0.8
        shapeLayer.lineCap = kCALineCapButt
        return shapeLayer
    }()
    
    /// 中等刻度
    fileprivate lazy var middleSymbol: CAShapeLayer = {
        let shapeLayer = CAShapeLayer()
        shapeLayer.strokeColor = middleSymbolColor.cgColor
        shapeLayer.fillColor = UIColor.clear.cgColor
        shapeLayer.lineWidth = 0.6
        shapeLayer.lineCap = kCALineCapButt
        return shapeLayer
    }()
    
    /// 短刻度
    fileprivate lazy var shortSymbol: CAShapeLayer = {
        let shapeLayer = CAShapeLayer()
        shapeLayer.strokeColor = shortSymbolColor.cgColor
        shapeLayer.fillColor = UIColor.clear.cgColor
        shapeLayer.lineWidth = 0.5
        shapeLayer.lineCap = kCALineCapButt
        return shapeLayer
    }()
    
    

    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupsubviews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupsubviews() {
        layer.addSublayer(shortSymbol)
        layer.addSublayer(middleSymbol)
        layer.addSublayer(longSymbol)
        backgroundColor = UIColor(red: 250/255.0, green: 250/255.0, blue: 250/255.0, alpha: 1)
        
        
    }
    
    
    func drawRuler() {
        
        /// 重绘之前移除所有的
        layer.sublayers?.forEach({ (sublayer) in
            
            if sublayer.isKind(of: CATextLayer.self) {
                sublayer.removeFromSuperlayer()
            }
        })
        
        let longPathRef = CGMutablePath()
        let middlePathRef = CGMutablePath()
        let shortPathRef = CGMutablePath()
        
        for idx in 0 ... rulerCount {
            
            let i = CGFloat(idx)
            
            let rule = CATextLayer()
            rule.foregroundColor = UIColor.lightGray.cgColor
            rule.font = ruleFont
            rule.fontSize = ruleFont.pointSize
            rule.contentsScale = UIScreen.main.scale
            rule.string = String(format: "%.0f", (i + minValue) * rulerAverage)
            
            let textSize = (rule.string as! NSString).size(withAttributes: [NSAttributedStringKey.font : ruleFont])
            rule.bounds = CGRect(origin: CGPoint.zero, size: textSize)
            
            if idx % Int(binary) == 0 {
                
                longPathRef.move(to: CGPoint(x: DISTANCELEFTANDRIGHT + DISTANCEVALUE * i , y: DISTANCETOPANDBOTTOM + textSize.height + 5))
                longPathRef.addLine(to: CGPoint(x: DISTANCELEFTANDRIGHT + DISTANCEVALUE * i, y: bounds.height - DISTANCETOPANDBOTTOM))
                rule.position = CGPoint(x: DISTANCELEFTANDRIGHT + DISTANCEVALUE * i, y: 5 + textSize.height / 2)
                layer.addSublayer(rule)
                
            } else if idx % Int(binary / 2) == 0 {
                
                middlePathRef.move(to: CGPoint(x: DISTANCELEFTANDRIGHT + DISTANCEVALUE * i , y: DISTANCETOPANDBOTTOM + textSize.height + 10))
                middlePathRef.addLine(to: CGPoint(x: DISTANCELEFTANDRIGHT + DISTANCEVALUE * i, y: bounds.height - DISTANCETOPANDBOTTOM))
                
                
            } else if isShowShortSymbol == true {
                
                shortPathRef.move(to: CGPoint(x: DISTANCELEFTANDRIGHT + DISTANCEVALUE * i , y: DISTANCETOPANDBOTTOM + textSize.height + 15))
                shortPathRef.addLine(to: CGPoint(x: DISTANCELEFTANDRIGHT + DISTANCEVALUE * i, y: bounds.height - DISTANCETOPANDBOTTOM))
                
            }
        }
        
        shortSymbol.path = shortPathRef
        middleSymbol.path = middlePathRef
        longSymbol.path = longPathRef
        

    
        
        if (isSmallModel) {
            
            contentInset = UIEdgeInsetsMake(0, bounds.width / 2 - DISTANCELEFTANDRIGHT, 0, bounds.width / 2 - DISTANCELEFTANDRIGHT)
            contentOffset = CGPoint(x: DISTANCEVALUE * ((rulerValue - minValue) / rulerAverage) - bounds.width + (bounds.width / 2 + DISTANCELEFTANDRIGHT), y: 0)
            
        } else {
            contentOffset = CGPoint(x: DISTANCEVALUE * ((rulerValue - minValue) / rulerAverage) - bounds.width / 2.0 + DISTANCELEFTANDRIGHT, y: 0)
        }
        
        contentSize = CGSize(width: CGFloat(rulerCount) * DISTANCEVALUE + DISTANCELEFTANDRIGHT * 2, height: bounds.height)
        
    }
    
    /*
     // Only override draw() if you perform custom drawing.
     // An empty implementation adversely affects performance during animation.
     override func draw(_ rect: CGRect) {
     // Drawing code
     }
     */
    
}
