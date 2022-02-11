//
//  ViewController.swift
//  MovieCKH
//
//  Created by 최기훈 on 2022/02/02.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    
    @IBOutlet weak var tableView: UITableView!
    
    let cellIdentifier: String = "cell"
    let movieURL = "https://kobis.or.kr/kobisopenapi/webservice/rest/boxoffice/searchDailyBoxOfficeList.json?key=482e9514e94a582b2267324135d4f7b3&targetDt=20220201"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        self.tableView.delegate = self
        self.tableView.dataSource  = self
        
        getData()
    }

    func getData() {
        if let url = URL(string: movieURL) {
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { data, response, error in
                if error != nil {
                    print(error!)
                    return
                }
                if let JSONdata = data {
                    let dataString = String(data: JSONdata, encoding: .utf8)
                    print(dataString!)
                }
            }
            task.resume()
        }
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! MyTableViewCell
        
        cell.movieName.text = indexPath.description
        
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}

struct MovieDAta: Codable {
    let boxOfficeResult: BoxOfficeResult
}
struct BoxOfficeResult: Codable{
    let dailyBoxOfficeList: [DailyBoxOfficeList]
}
struct DailyBoxOfficeList: Codable {
    let movieNM: String
    let audiCnt: String
}


