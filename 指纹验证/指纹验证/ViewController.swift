//
//  ViewController.swift
//  指纹验证
//
//  Created by ai on 16/8/24.
//  Copyright © 2016年 Ai University. All rights reserved.
//

import UIKit
import LocalAuthentication

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.FingerprintRecognition()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func FingerprintRecognition() {
        let context = LAContext()
        var error: NSError?
        if context.canEvaluatePolicy(LAPolicy.DeviceOwnerAuthenticationWithBiometrics, error: &error) {
            print("touchID 可用")
            context.evaluatePolicy(LAPolicy.DeviceOwnerAuthenticationWithBiometrics, localizedReason: "指纹识别", reply: { (success: Bool, localError: NSError?) in
                if success {
                    print("指纹识别成功")
                } else {
                    print("touchID 可用 \(localError)")
                }
            })
        } else {
            print("touchID 不可用 \(error)")
        }
        
    }
}

