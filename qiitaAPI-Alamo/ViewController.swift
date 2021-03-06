//
//  ViewController.swift
//  qiitaAPI-Alamo
//
//  Created by 高橋蓮 on 2022/02/21.
//
import UIKit
import Alamofire

class ArticleListViewController: UIViewController {
    
    @IBOutlet weak var articleListTableView: UITableView!
    
    let decoder: JSONDecoder = JSONDecoder()
    var articles = [Article]()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        delegete()
        getQiitaArticles()
    }
    
    private func delegete() {
        articleListTableView.delegate = self
        articleListTableView.dataSource = self
    }
    
//MARK: -GetInfo using Alamofire
    private func getQiitaArticles() {
        AF.request("https://qiita.com/api/v2/items").responseJSON { response in
            switch response.result {
            case .success:
                do {
                    self.articles = try self.decoder.decode([Article].self, from: response.data!)
                    self.articleListTableView.reloadData()
                } catch {
                    print("デコードに失敗しました")
                }
            case .failure(let error):
                print("error", error)
            }
        }
    }
}

//MARK: - UITableViewDelegate
extension ArticleListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        articles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "articleCell", for: indexPath)
        cell.textLabel?.text = articles[indexPath.row].title
        return cell
    }
}
