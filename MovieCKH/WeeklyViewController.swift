//
//  WeeklyViewController.swift
//  MovieCKH
//
//  Created by 최기훈 on 2022/03/28.
//

import UIKit

class WeeklyViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var weekMovieData: MovieData?
    
    @IBOutlet weak var tableView: UITableView!
    
    let cellIdentifier: String = "cell"
    var movieURL = "http://kobis.or.kr/kobisopenapi/webservice/rest/boxoffice/searchWeeklyBoxOfficeList.json?key=482e9514e94a582b2267324135d4f7b3&targetDt="
    
   
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.delegate = self
        self.tableView.dataSource  = self
        
        movieURL += makeYesterdayString()
        
        getData()
        // Do any additional setup after loading the view.
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
                        let decodeData = try decoder.decode(MovieData.self, from: JSONdata)
                        
                        print(decodeData.boxOfficeResult.weeklyBoxOfficeList[0].movieNm)
                        print(decodeData.boxOfficeResult.weeklyBoxOfficeList[0].audiCnt)
                        print(decodeData.boxOfficeResult.weeklyBoxOfficeList[0].rank)

                        self.weekMovieData = decodeData
                        
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
        
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! WeekMyTableViewCell
        
        cell.movieName.text = weekMovieData?.boxOfficeResult.weeklyBoxOfficeList[indexPath.row].movieNm
        if weekMovieData?.boxOfficeResult.weeklyBoxOfficeList[indexPath.row].rankOldAndNew == "NEW" {
            cell.movieRank.text = weekMovieData?.boxOfficeResult.weeklyBoxOfficeList[indexPath.row].rankOldAndNew
            cell.movieRank.textColor = .red
            cell.ifNew = weekMovieData?.boxOfficeResult.weeklyBoxOfficeList[indexPath.row].rank ?? "NEW"
        }else {
            cell.movieRank.text = weekMovieData?.boxOfficeResult.weeklyBoxOfficeList[indexPath.row].rank
        }
        cell.auCnt.text = weekMovieData?.boxOfficeResult.weeklyBoxOfficeList[indexPath.row].audiCnt
        cell.openDt.text = weekMovieData?.boxOfficeResult.weeklyBoxOfficeList[indexPath.row].openDt
        cell.audiAcc.text = weekMovieData?.boxOfficeResult.weeklyBoxOfficeList[indexPath.row].audiAcc
        
        return cell
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
    
        guard let nextViewController: WeekDetailViewController = segue.destination as? WeekDetailViewController else {
            return
        }
        guard let cell: WeekMyTableViewCell = sender as? WeekMyTableViewCell else {
            return
        }
        nextViewController.textToSet = cell.movieName?.text
        nextViewController.textToSet2 = cell.movieRank?.text
        nextViewController.textToset3 = cell.audiAcc?.text
        nextViewController.textToset4 = cell.openDt?.text
        nextViewController.textToSet5 = cell.ifNew
    }
    
    

    

}

struct MovieData: Codable {
    let boxOfficeResult: WeekBoxOfficeResult
}
struct WeekBoxOfficeResult: Codable{
    let weeklyBoxOfficeList: [WeeklyBoxOfficeList]
}
struct WeeklyBoxOfficeList: Codable {
    let movieNm: String
    let audiCnt: String
    let rank: String
    let openDt: String
    let audiAcc: String
    let rankOldAndNew: String
}

