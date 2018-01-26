//
//  ViewController.swift
//  MLSilderRulerView
//
//  Created by Macro on 2018/1/25.
//  Copyright © 2018年 CodeMarco. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let rulerV = MLSliderRulerView(frame: CGRect(x: 70, y: 200, width: UIScreen.main.bounds.width - 140, height: 200))
        
//        rulerV.showRulerScrollView(with: 200, average: 0.1, currentValue: 16.5)
        
        view.addSubview(rulerV)
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

