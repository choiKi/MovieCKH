//
//  ViewController.swift
//  MovieCKH
//
//  Created by 최기훈 on 2022/02/02.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var movieData: MovieDAta?
    
    @IBOutlet weak var tableView: UITableView!
    
    
    let cellIdentifier: String = "cell"
    var movieURL = "http://kobis.or.kr/kobisopenapi/webservice/rest/boxoffice/searchDailyBoxOfficeList.json?key=f5eef3421c602c6cb7ea224104795888&targetDt="
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        self.tableView.delegate = self
        self.tableView.dataSource  = self
        
        movieURL += makeYesterdayString()
        
        getData()
    }
    
    func makeYesterdayString() -> String {
        let yesterDay = Calendar.current.date(byAdding: .day, value: -1, to: Date())!
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyymmdd"
        let yesterDayString = dateFormatter.string(from: yesterDay)
        return yesterDayString
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
                   // let dataString = String(data: JSONdata, encoding: .utf8)
                   // print(dataString!)
                    
                    let decoder = JSONDecoder()
                    do {
                        let decodeData = try decoder.decode(MovieDAta.self, from: JSONdata)
                        
                        print(decodeData.boxOfficeResult.dailyBoxOfficeList[0].movieNm)
                        print(decodeData.boxOfficeResult.dailyBoxOfficeList[0].audiCnt)
                        print(decodeData.boxOfficeResult.dailyBoxOfficeList[0].rank)

                        self.movieData = decodeData
                        
                        DispatchQueue.main.async {
                            self.tableView.reloadData()
                        }
                        
                    }catch{
                        print(error)
                    }
                }
            }
            task.resume()
        }
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! MyTableViewCell
        
        cell.movieName.text = movieData?.boxOfficeResult.dailyBoxOfficeList[indexPath.row].movieNm
        cell.movieRank.text = movieData?.boxOfficeResult.dailyBoxOfficeList[indexPath.row].rank
        cell.auCnt.text = movieData?.boxOfficeResult.dailyBoxOfficeList[indexPath.row].audiCnt
        cell.openDt.text = movieData?.boxOfficeResult.dailyBoxOfficeList[indexPath.row].openDt
        
        
        return cell
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
    
        guard let nextViewController: DetailViewController = segue.destination as? DetailViewController else {
            return
        }
        guard let cell: MyTableViewCell = sender as? MyTableViewCell else {
            return
        }
        nextViewController.textToSet = cell.movieName?.text
        nextViewController.textToSet2 = cell.movieRank?.text
        nextViewController.textToset3 = cell.auCnt?.text
        nextViewController.textToset4 = cell.openDt?.text
    }
    
    
}

struct MovieDAta: Codable {
    let boxOfficeResult: BoxOfficeResult
}
struct BoxOfficeResult: Codable{
    let dailyBoxOfficeList: [DailyBoxOfficeList]
}
struct DailyBoxOfficeList: Codable {
    let movieNm: String
    let audiCnt: String
    let rank: String
    let openDt: String
}


