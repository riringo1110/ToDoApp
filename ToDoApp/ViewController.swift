//
//  ViewController.swift
//  ToDoApp
//
//  Created by Ririko Nagaishi on 2021/02/17.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet var table: UITableView!
    
    
    var toDoList: String!
    var date: String!
    
    var toDoArray = [String]()
    var dateArray = [String]()
    
    let saveData = UserDefaults.standard
    
    
//    override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(animated)
//
//    }
    
    override func viewDidAppear(_ animated: Bool) {
        if saveData.object(forKey: "todoArray") != nil {
            //UserDefaultsの中身をArrayに表示
            toDoArray = saveData.array(forKey: "todoArray") as! [String]
            
            if saveData.object(forKey: "dateArray") != nil{
                dateArray = saveData.array(forKey: "dateArray") as! [String]
            }
        }
        table.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        table.dataSource = self
        table.delegate = self
        
        toDoArray = ["りんご", "ごりら"]
        dateArray = ["", ""]
        
        //もしUserDefaultsに中身あったら読み込む
        
    }
    
    //セルの数を設定
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return toDoArray.count
    }
    
    //ID付きのcellを取得してセルのLableに表示させるよ
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = toDoArray [indexPath.row]
        cell.detailTextLabel?.text = dateArray [indexPath.row]
        
        return cell
    }
    
    //削除機能
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == UITableViewCell.EditingStyle.delete {
            toDoArray.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath as IndexPath], with: UITableView.RowAnimation.automatic)
            dateArray.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath as IndexPath], with: UITableView.RowAnimation.automatic)
        }
    }
}

 
