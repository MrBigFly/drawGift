//
//  PanGestureViewController.swift
//  GiftTest
//
//  Created by xxx on 2020/10/14.
//
import UIKit
class PanGestureViewController: UIViewController{
    let step = 20
    var beginPoint = CGPoint.zero //每次手指开始的地方，如(180,230)
    var panPoint = CGPoint.zero //每次拖拽手势开始的地方，如(0,0)
    var timer: Timer?
    var array: [CGPoint] = []
    var index: Int = 0
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        timer?.invalidate()
        timer = nil
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        
        let button = UIButton(type: .custom)
        button.frame = CGRect(x: 100, y: 100, width: 100, height: 30)
        button.setTitle("清空", for: .normal)
        button.setTitleColor(UIColor.red, for: .normal)
        button.backgroundColor = UIColor.orange
        button.addTarget(self, action: #selector(clear), for: .touchUpInside)
        view.addSubview(button)
        
        let button2 = UIButton(type: .custom)
        button2.frame = CGRect(x: 210, y: 100, width: 100, height: 30)
        button2.setTitle("计数", for: .normal)
        button2.setTitleColor(UIColor.red, for: .normal)
        button2.backgroundColor = UIColor.orange
        button2.addTarget(self, action: #selector(printCount), for: .touchUpInside)
        view.addSubview(button2)
        
        let button3 = UIButton(type: .custom)
        button3.frame = CGRect(x: 100, y: 140, width: 240, height: 30)
        button3.setTitle("展示别人发送的礼物动画", for: .normal)
        button3.setTitleColor(UIColor.red, for: .normal)
        button3.backgroundColor = UIColor.orange
        button3.addTarget(self, action: #selector(showGiftAnimation), for: .touchUpInside)
        view.addSubview(button3)
        
        let panGes = UIPanGestureRecognizer(target: self, action: #selector(panAction(ges:)))
        panGes.maximumNumberOfTouches = 1
        view.addGestureRecognizer(panGes)
        
        timer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(drawImgView), userInfo: nil, repeats: true)
    }
    
    @objc func clear() {
        clearImgViews()
        timer?.fireDate = Date.distantFuture
        index = 0
    }
    @objc func printCount(sender: UIButton) {
        var count  = 0
        for v in view.subviews where v is UIImageView {
            count = count + 1
        }
        sender.setTitle("计数：\(count)", for: .normal)
    }
    
    @objc func showGiftAnimation() {
        clearImgViews()
        getArray()
        index = 0
        timer?.fireDate = Date()
    }
    
    @objc func drawImgView() {
        if index > array.count - 1 {
            timer?.fireDate = Date.distantFuture
            return
        }
        let point = array[index]
        let imgv = UIImageView()
        imgv.image = UIImage(named: "heart")
        imgv.bounds = CGRect(x: 0, y: 0, width: 20, height: 20)
        imgv.frame.origin = point
        self.view.addSubview(imgv)
        index = index + 1
    }
    
    func clearImgViews() {
        for v in view.subviews where v is UIImageView {
            v.removeFromSuperview()
        }
    }
    
    func getArray() {
        //let jsonStr = ""
        //let jsonData = ""
        array = []
        let items = [["x":"100","y":"200"], ["x":"140","y":"200"], ["x":"180","y":"200"], ["x":"220","y":"200"],
                     ["x":"220","y":"230"], ["x":"200","y":"250"], ["x":"180","y":"270"], ["x":"160","y":"290"], ["x":"140","y":"310"], ["x":"120","y":"330"]]
        for item in items {
            let xStr: String = item["x"] ?? "0"
            let yStr: String = item["y"] ?? "0"
            let point = CGPoint(x: Int(xStr) ?? 0, y: Int(yStr) ?? 0)
            if point != .zero {
                array.append(point)
            }
        }
    }
    
    func myAbs(num: Int) -> Int {
        return num >= 0 ? num : -num
    }
    
    func addView(at point: CGPoint) {
        let imgv = UIImageView()
        imgv.image = UIImage(named: "heart")
        imgv.bounds = CGRect(x: 0, y: 0, width: 20, height: 20)
        imgv.frame.origin = point
        self.view.addSubview(imgv)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch: UITouch = touches.first!
        let currentP: CGPoint = touch.location(in: self.view)
        //print("beginP: \(currentP)")
        beginPoint = currentP
    }
    
    @objc func panAction(ges: UIPanGestureRecognizer) {
        let currentP: CGPoint = ges.translation(in: self.view)
        //print("pangesP: \(currentP)")
        let dx = myAbs(num: Int(currentP.x - panPoint.x))
        let dy = myAbs(num: Int(currentP.y - panPoint.y))
        let drawPoint = CGPoint(x: beginPoint.x + currentP.x, y: beginPoint.y + currentP.y)
        if dx*dx + dy*dy > 2*step*step {
            addView(at: drawPoint)
            panPoint = currentP
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch: UITouch = touches.first!
        let currentP: CGPoint = touch.location(in: self.view)
        let preP: CGPoint = touch.previousLocation(in: self.view)
        //print("currentP: \(currentP)")
        //print("currentP: \(currentP),preP: \(preP)")

//        let offsetX = currentP.x-preP.x
//        let offsetY = currentP.y-preP.y

        //self.transform = CGAffineTransformTranslate(self.transform, offsetX, offsetY)
    }
}
