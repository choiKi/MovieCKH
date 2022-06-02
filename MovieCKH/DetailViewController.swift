//
//  DetailViewController.swift
//  MovieCKH
//
//  Created by 최기훈 on 2022/03/19.
//

import UIKit
import WebKit

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
       print(textToset3!)
    
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
    
    @IBAction func goNaver(_ sender: UIButton) {
        
    }
    
 
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        guard let nextViewController: WebVC = segue.destination as? WebVC else {
            return
            
        }
        nextViewController.textToSett = textToSet!
    
    }
    
    
    

  

}
