//
//  DDVC.swift
//  MovieCKH
//
//  Created by 최기훈 on 2022/05/31.
//

import Foundation
import UIKit
import WebKit

class WebVC: UIViewController{
    
    @IBOutlet weak var webView: WKWebView!
    @IBOutlet weak var movieName: UILabel!
    
    
    var textToSett: String = ""
    
    override func viewDidLoad() {
        
        super.viewDidLoad()

        let urlKorString = "https://search.naver.com/search.naver?where=nexearch&sm=tab_etc&mra=bkEw&pkid=68&os=11842142&qvt=0&query=" + textToSett
        let urlString = urlKorString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        guard let url = URL(string: urlString) else {return}
        let request = URLRequest(url: url)
        webView?.load(request)
            
    }
    
    
}
