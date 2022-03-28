//
//  DetailViewController.swift
//  MovieCKH
//
//  Created by 최기훈 on 2022/03/19.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var movieName: UILabel!
    @IBOutlet weak var rank: UILabel!
    @IBOutlet weak var auCnt: UILabel!
    @IBOutlet weak var openDt: UILabel!
    
    var textToSet: String?
    var textToSet2: String?
    var textToset3: String?
    var textToset4: String?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
      
        
    
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(animated)
        movieName.text = self.textToSet
        rank.text = "\(self.textToSet2!) 위"
        auCnt.text = "\(self.textToset3!) 명"
        openDt.text = self.textToset4
        
      
        
    }
    @IBAction func touchBackButton() {
        dismiss(animated: true, completion: nil)
    }
    

  

}
