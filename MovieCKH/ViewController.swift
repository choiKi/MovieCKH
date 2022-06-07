//
//  ViewController.swift
//  MovieCKH
//
//  Created by 최기훈 on 2022/02/02.
//
import WebKit
import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var movieData: MovieDAta?
    
    @IBOutlet weak var tableView: UITableView!
    
    
    let cellIdentifier: String = "cell"
    var movieURL = "http://kobis.or.kr/kobisopenapi/webservice/rest/boxoffice/searchDailyBoxOfficeList.json?key=482e9514e94a582b2267324135d4f7b3&targetDt="
    
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
        guard let url = URL(string: movieURL) else { return }
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { data, response, error in
                if error != nil {
                    print(error!)
                    return
                }
                guard let JSONdata = data else { return }
                    // let dataString = String(data: JSONdata, encoding: .utf8)
                    //  print(dataString!)
                    
                    let decoder = JSONDecoder()
                    do {
                        let decodeData = try decoder.decode(MovieDAta.self, from: JSONdata)
                        
                        self.movieData = decodeData
                        DispatchQueue.main.async {
                            self.tableView.reloadData()
                        }
                        
                    }catch{
                        print(error)
                    }
            }
        task.resume()
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! MyTableViewCell
        
        cell.movieName.text = movieData?.boxOfficeResult.dailyBoxOfficeList[indexPath.row].movieNm
        
        if movieData?.boxOfficeResult.dailyBoxOfficeList[indexPath.row].rankOldAndNew == "NEW" {
            cell.movieRank.text = movieData?.boxOfficeResult.dailyBoxOfficeList[indexPath.row].rankOldAndNew
            cell.movieRank.textColor = .red
            cell.ifNew = movieData?.boxOfficeResult.dailyBoxOfficeList[indexPath.row].rank ?? "NEW"
        }else {
            cell.movieRank.text = movieData?.boxOfficeResult.dailyBoxOfficeList[indexPath.row].rank
        }
        
        cell.auCnt.text = movieData?.boxOfficeResult.dailyBoxOfficeList[indexPath.row].audiCnt
        cell.openDt.text = movieData?.boxOfficeResult.dailyBoxOfficeList[indexPath.row].openDt
        cell.audiAcc.text = movieData?.boxOfficeResult.dailyBoxOfficeList[indexPath.row].audiAcc
       
        
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
        nextViewController.textToset3 = cell.audiAcc?.text
        nextViewController.textToset4 = cell.openDt?.text
        nextViewController.textToSet5 = cell.ifNew
    }
    
    
}

class MapViewController: UIViewController {
    
    @IBOutlet weak var mapView : WKWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let urlKorString = "https://m.map.naver.com/search2/search.naver?query=영화관&sm=hty&style=v5"
        
        let urlString = urlKorString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        guard let url = URL(string: urlString) else {return}
        let request = URLRequest(url: url)
        mapView.load(request)
        
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
    let audiAcc: String
    let rank: String
    let openDt: String
    let rankOldAndNew: String
}


