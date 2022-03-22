//
//  DetailViewController.swift
//  MovieCKH
//
//  Created by 최기훈 on 2022/03/19.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var movieName: UILabel!
    
    var textToSet: String?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        view.backgroundColor = .systemGray
    }
    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(animated)
        movieName.text = self.textToSet
      
        
    }
    

  

}
