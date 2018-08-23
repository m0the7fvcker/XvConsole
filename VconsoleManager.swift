//
//  VconsoleManager.swift
//  Docs
//
//  Created by maxiao on 2018/8/21.
//  Copyright © 2018年 mark'sTheme. All rights reserved.
//

import WebKit

public class VconsoleManager {
    
    public static var switchState: Bool = false
    
    public class func startInjecting(for webView: WKWebView?) {
        
        guard switchState else { return }
        guard let webView = webView else { return }
        
        let injectionvConsoleJS = "var body = document.getElementsByTagName('BODY').item(0);var script1= document.createElement(\"script\");script1.type = \"text/javascript\";script1.src=\"https://cdn.bootcss.com/vConsole/3.2.0/vconsole.min.js\";body.appendChild(script1);"
        let injectionJQuery = "var script = document.createElement(\"script\");script.src = \"//url.com/jquery.js\";var s = document.getElementsByTagName(\"script\")[0];s.parentNode.insertBefore(script, s);"
        let injectionvConsoleHelper = "var script=$('<script>function initvConsole() {if(window.vConsole) {window.vConsole.showSwitch();return;} window.vConsole = new window.VConsole();} function showSwitch() {window.vConsole.showSwitch();}function hideSwitch() {window.vConsole.hideSwitch();}</script>');$('body').append(script);"
        
        webView.evaluateJavaScript(injectionvConsoleJS + injectionJQuery + injectionvConsoleHelper, completionHandler: nil)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            webView.evaluateJavaScript("initvConsole();", completionHandler: nil)
        }
    }
}


