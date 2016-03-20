//
//  DetailVC.swift
//  Challenge
//
//  Created by Daniel Piotrowski on 11.03.16.
//  Copyright © 2016 MeDaPi. All rights reserved.
//

import UIKit


class DetailVC: UIViewController, UIWebViewDelegate {
    
    static var currentRepo: String = "https://www.github.com"
    
    var repo: String = currentRepo
    
    static var navigationItemTitle: String = "Apple Repo"
    
    var title1: String = navigationItemTitle
    
    
    
    @IBOutlet weak var webView: UIWebView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        self.navigationItem.title = title1
        
        loadAdress()
        
        
        
        webView.allowsLinkPreview = true
        webView.scalesPageToFit = true
        webView.goBack()
        
    }
    
    
    
    func loadAdress() {
        
        
        let url = NSURL(string: repo)
        let request = NSURLRequest(URL: url!)
        webView.delegate = self
        
        webView.backgroundColor = UIColor.clearColor()
        webView.loadRequest(request)
        
        
    }
    
    
    
    
    
    
    
    
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}