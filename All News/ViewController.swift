//
//  ViewController.swift
//  All News
//
//  Created by Mustafa Yusuf on 07/03/17.
//  Copyright © 2017 Mustafa Yusuf. All rights reserved.
//

import UIKit
import FillableLoaders

class ViewController: UIViewController {
    
    @IBOutlet var loaderView: UIView!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        /*let x = CGRect(origin: loaderView.center, size: CGSize(width: 100, height: 100))
        let path = CGPath(rect: x, transform: nil)//CGPath(rect: loaderView.bounds, transform: nil)
        
        
        let loader = WavesLoader.createLoader(with: path)//WavesLoader.createLoader(with: path, on: loaderView)
        
        loader.loaderColor = UIColor.red
        loader.showLoader()*/
        
        
        x()
        
    }

    func x() {
        let starPath = UIBezierPath()
        
        starPath.move(to: CGPoint(x: 180,y: 25))
        starPath.addLine(to: CGPoint(x: 195.16, y: 43.53))
        starPath.addLine(to: CGPoint(x: 220.9, y: 49.88))
        starPath.addLine(to: CGPoint(x: 204.54, y: 67.67))
        starPath.addLine(to: CGPoint(x: 205.27, y: 90.12))
        starPath.addLine(to: CGPoint(x: 180, y: 82.6))
        starPath.addLine(to: CGPoint(x: 154.73, y: 90.12))
        starPath.addLine(to: CGPoint(x: 155.46, y: 67.67))
        starPath.addLine(to: CGPoint(x: 139.1, y: 49.88))
        starPath.addLine(to: CGPoint(x: 164.84, y: 43.53))
        starPath.close()
        UIColor.gray.setFill()
        starPath.fill()
        let myPath = starPath.cgPath
        
        let myLoader = WavesLoader.showProgressBasedLoader(with: myPath)
        myLoader.progress = 100
        myLoader.duration = TimeInterval.abs(100)
        myLoader.loaderColor = UIColor.red
        myLoader.loaderBackgroundColor = UIColor.black
        myLoader.showLoader()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

