//
//  ViewController.swift
//  GiftTest
//
//  Created by xxx on 2020/10/14.
//

import UIKit

class ViewController: UIViewController {

    let step = 20
    var count = 0
    var beginPoint = CGPoint.zero //每次手指开始的地方，如(180,230)
    var panPoint = CGPoint.zero //每次拖拽手势开始的地方，如(0,0)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        
        let button = UIButton(type: .custom)
        button.frame = CGRect(x: 100, y: 100, width: 200, height: 30)
        button.setTitle("panGesture", for: .normal)
        button.setTitleColor(UIColor.red, for: .normal)
        button.backgroundColor = UIColor.orange
        button.addTarget(self, action: #selector(pan), for: .touchUpInside)
        view.addSubview(button)
        
        let button2 = UIButton(type: .custom)
        button2.frame = CGRect(x: 100, y: 150, width: 200, height: 30)
        button2.setTitle("touchmoved", for: .normal)
        button2.setTitleColor(UIColor.red, for: .normal)
        button2.backgroundColor = UIColor.orange
        button2.addTarget(self, action: #selector(moved), for: .touchUpInside)
        view.addSubview(button2)
        
    }
    
    @objc func pan() {
        self.navigationController?.pushViewController(PanGestureViewController(), animated: true)
    }
    @objc func moved() {
        self.navigationController?.pushViewController(TouchMovedViewController(), animated: true)
    }
    
}

