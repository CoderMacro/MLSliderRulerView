


//
//  MLSliderRuler.swift
//  MLSilderRulerView
//
//  Created by Macro on 2018/1/25.
//  Copyright © 2018年 CodeMarco. All rights reserved.
//

import UIKit

protocol MLSliderRulerViewDelegate: class {
    func sliderRulerView(ruler: UIView, rulervalue: CGFloat)
}

class MLSliderRulerView: UIView {
    
    weak var delegate: MLSliderRulerViewDelegate?
    
    var valueLabelFont = UIFont.systemFont(ofSize: 14) {
        didSet {
            valueLabel.font = valueLabelFont
        }
    }
    
    var rulerHeight: CGFloat = 50.0 {
        didSet {
            rulerScrollView.frame = CGRect(x: 0, y: frame.size.height - rulerHeight, width: frame.size.width, height: rulerHeight)
            rulerScrollView.drawRuler()
        }
    }
    
    private var rulerScrollView = MLSliderRulerScrollView()
    private let markLine = CALayer()
    private let valueLabel = UILabel()
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        rulerScrollView.frame = CGRect(x: 0, y: frame.size.height - rulerHeight, width: frame.size.width, height: rulerHeight)
        rulerScrollView.showsHorizontalScrollIndicator = false
        rulerScrollView.delegate = self
        addSubview(rulerScrollView)
        
        markLine.backgroundColor = UIColor.black.withAlphaComponent(0.4).cgColor
        markLine.cornerRadius = 4
        markLine.frame = CGRect(origin: CGPoint.zero, size: CGSize(width: 8, height: rulerScrollView.bounds.height + 8))
        markLine.position = CGPoint(x: bounds.midX, y: rulerScrollView.bounds.midY + rulerScrollView.frame.minY)
        layer.addSublayer(markLine)
        
        valueLabel.font = UIFont.systemFont(ofSize: 15)
        valueLabel.textAlignment = .center
        valueLabel.textColor = UIColor.black
        valueLabel.frame = CGRect(x: 0, y: rulerScrollView.frame.minY - 30, width: bounds.width, height: 20)
        valueLabel.text = "163 cm"
        addSubview(valueLabel)
        
        rulerScrollView.layer.cornerRadius = min(rulerScrollView.bounds.size.height, rulerScrollView.bounds.size.width) / 2
        
//        rulerScrollView.layer.cornerRadius = min(rulerScrollView.bounds.size.height, rulerScrollView.bounds.size.width) / 2
//        rulerScrollView.layer.shadowColor = UIColor.black.cgColor
//        rulerScrollView.layer.shadowOffset = CGSize(width: 2, height: 4)
//        rulerScrollView.layer.shadowRadius = rulerScrollView.layer.cornerRadius
//        rulerScrollView.layer.shadowOpacity = Float(0.5)
//        rulerScrollView.layer.shadowPath = UIBezierPath(roundedRect: rulerScrollView.bounds, byRoundingCorners: .allCorners, cornerRadii: CGSize(width: 8, height: 8)).cgPath
//        rulerScrollView.layer.shouldRasterize = true
//        rulerScrollView.layer.rasterizationScale = UIScreen.main.scale
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        
        rulerScrollView.drawRuler()
        
    }
    
    
    
    
    func animationRebound() {
        
        let offSetX = rulerScrollView.contentOffset.x + bounds.width / 2 - DISTANCELEFTANDRIGHT
        var oX = (offSetX / DISTANCEVALUE) * rulerScrollView.rulerAverage
        
        oX = round(oX)
        
        
        let offX = (oX / rulerScrollView.rulerAverage) * DISTANCEVALUE + DISTANCELEFTANDRIGHT - frame.size.width / 2;
        
        rulerScrollView.setContentOffset(CGPoint(x: offX, y: 0), animated: true)
        
    }
}

extension MLSliderRulerView: UIScrollViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        let offSetX = scrollView.contentOffset.x + bounds.size.width / 2 - DISTANCELEFTANDRIGHT
        let ruleValue = (offSetX / DISTANCEVALUE) * rulerScrollView.rulerAverage
        
        let valuetext = "\(round(ruleValue) + rulerScrollView.minValue) cm"
        
        if valuetext != valueLabel.text {
            valueLabel.text = valuetext
        }
        
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        animationRebound()
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        animationRebound()
    }
    
}


