//
//  JFJSExport.swift
//  JFJavaScript
//
//  Created by apple on 16/11/2.
//  Copyright © 2016年 pengjf. All rights reserved.
//

import UIKit
import JavaScriptCore

@objc protocol JFObjectJSExportDelegate:JSExport {
    // js调用App的微信支付功能 演示最基本的用法
    func wxPay(_ orderNo: String)
    
    // js调用App的微信分享功能 演示字典参数的使用
     func wxShare(_ dict: [String: AnyObject])
    
    func hello()
    //js调用app的提示框
    func showDialog(_ title: String, message: String)
    //js执行app方法后的回掉
    func callHandler(_ handleFuncName: String)
    
}
@objc class JFJSExport: NSObject,JFObjectJSExportDelegate {

    weak var context:JSContext?
    
    func wxPay(_ orderNo: String) {
        
        print("订单号：", orderNo)
        
        // 调起微信支付逻辑
    }
    
    func wxShare(_ dict: [String: AnyObject]) {
        
        print("分享信息：", dict)
        
        // 调起微信分享逻辑
    }
    func hello(){
        print("hello world")
    }
    func showDialog(_ title: String, message: String){
        let alert = UIAlertView.init(title: "文星提示", message: "你的账号多了1000000000000", delegate: nil, cancelButtonTitle: "知道了")
        alert.show()
        
    }
    func callHandler(_ handleFuncName: String) {
        let handleFunc = self.context?.objectForKeyedSubscript("\(handleFuncName)")
        let dict = ["name":"seen","age":18] as [String : Any]
        
        let handle = handleFunc?.call(withArguments: [dict])
        
        print("\(handle)-------test")
    }
}
