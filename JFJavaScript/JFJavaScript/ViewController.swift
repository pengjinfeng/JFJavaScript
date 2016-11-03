//
//  ViewController.swift
//  JFJavaScript
//
//  Created by apple on 16/11/2.
//  Copyright © 2016年 pengjf. All rights reserved.
//
/*
 1. JSValue: 代表一个JavaScript实体，一个JSValue可以表示很多JavaScript原始类型例如boolean, integers, doubles，甚至包括对象和函数。
 2. JSContext: 代表JavaScript的运行环境，你需要用JSContext来执行JavaScript代码。所有的JSValue都是捆绑在一个JSContext上的。
 2. JSExport: 这是一个协议，可以用这个协议来将原生对象导出给JavaScript，这样原生对象的属性或方法就成为了JavaScript的属性或方法，非常神奇。
 
 原文链接：http://www.jianshu.com/p/59242a92d4f2
 著作权归作者所有，转载请联系作者获得授权，并标注“简书作者”。*/
import UIKit
import JavaScriptCore


class ViewController: UIViewController,UIWebViewDelegate {

    
    @IBOutlet weak var web:UIWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.web.delegate = self
        let url = Bundle.main.url(forResource: "index", withExtension: "html")
        let request = URLRequest(url: url!)
        
        // 加载网络Html页面 请设置允许Http请求
        //let url = NSURL(string: "http://www.mayanlong.com");
        //let request = NSURLRequest(URL: url!)
        
        self.web.loadRequest(request)
      
        //下一步我们想做的就是点击这个按钮我们可以使用swift 的printf来打印一个输出语句这样也就简单的实现了js与swift的交互
        
       
        
    }

    func webViewDidFinishLoad(_ webView: UIWebView) {
//        demo4()
        demo5()
    }
    
    func demo1(){
        //获取context，也就是获取运行环境，只有context可以运行js代码
        let context:JSContext = self.web.value(forKeyPath: "documentView.webView.mainFrame.javaScriptContext") as! JSContext
        context.evaluateScript("test1()")
        
    }
    //使用swift代码执行带参数的JS
    func demo2() {
        let context:JSContext = self.web.value(forKeyPath: "documentView.webView.mainFrame.javaScriptContext") as! JSContext
        context.evaluateScript("test3(3,4)")
    }
    //执行swift中的js代码
    func demo3() {
        let context:JSContext = self.web.value(forKeyPath: "documentView.webView.mainFrame.javaScriptContext") as! JSContext
        let jsCode:String = "alert(\"这是swift种的js代码被调用了\")"
        context.evaluateScript(jsCode)
    }
    //js调用swift方法
    func demo4() {
        let context = web.value(forKeyPath: "documentView.webView.mainFrame.javaScriptContext") as! JSContext
        let model = JFJSExport()
      
        context.setObject(model, forKeyedSubscript: "WebViewJavascriptBridge" as (NSCopying & NSObjectProtocol)!)
    }
    //js调用带参数的swift方法
    func demo5() {
        let context:JSContext = self.web.value(forKeyPath: "documentView.webView.mainFrame.javaScriptContext") as! JSContext
        let model = JFJSExport()
        model.context = context
        
        context.setObject(model, forKeyedSubscript: "WebViewJavascriptBridge" as (NSCopying & NSObjectProtocol)!)
        
        context.exceptionHandler = { (context, exception) in
            print("exception：", exception)
        }
    }

    
      override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

