//
//  WebViewController.swift
//  UiTableViewController Test 02
//
//  Created by D7703_02 on 2018. 6. 29..
//  Copyright © 2018년 황지성. All rights reserved.
//

import UIKit

class WebViewController: UIViewController,UIWebViewDelegate {

    @IBOutlet weak var txtUrl: UITextField!
    @IBOutlet weak var myWeb: UIWebView!
    @IBOutlet weak var myActivity: UIActivityIndicatorView!
    
    func loadWebPage(_ url: String) {
        let myUrl = URL(string: url)
        let myRequest = URLRequest(url: myUrl!)
        myWeb.loadRequest(myRequest)
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        myWeb.delegate = self
        loadWebPage("https://www.naver.com")
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func webViewDidStartLoad(_ webView: UIWebView) {
        myActivity.startAnimating()
    }
    func webViewDidFinishLoad(_ webView: UIWebView) {
        myActivity.stopAnimating()
    }
    func cherkUrl(_ url: String) -> String {
        var strUrl = url
        let flag = strUrl.hasPrefix("http://")
        if !flag {
            strUrl = "http://" + strUrl
        }
        return strUrl
    }
    
    @IBAction func btGoUrl(_ sender: UIButton) {
      
    }
    
    @IBAction func btGoS1(_ sender: UIButton) {
          loadWebPage("https://github.com/Hwangjiseong/DIT-Food-Finder-Map-Geocoding")
    }
    
    @IBAction func btGos2(_ sender: UIButton) {
        loadWebPage("https://www.google.co.kr")
    }
    
    @IBAction func btHtml(_ sender: UIButton) {
        let htmlString = "<h1> HTML String </h1><p> String 변수를 이용한 웹페이지</p> <p><a href=\"https://github.com/Hwangjiseong/DIT-Food-Finder-Map-Geocoding\">Hwang</a>으로 이동</p>"
        myWeb.loadHTMLString(htmlString, baseURL: nil)
       
    }
   
    
    @IBAction func btStop(_ sender: UIBarButtonItem) {
        myWeb.stopLoading()
    }
    @IBAction func btRefresh(_ sender: UIBarButtonItem) {
        myWeb.reload()
    }
    @IBAction func btRewind(_ sender: UIBarButtonItem) {
        myWeb.goBack()
    }
    @IBAction func btForward(_ sender: UIBarButtonItem) {
        myWeb.goForward()
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
