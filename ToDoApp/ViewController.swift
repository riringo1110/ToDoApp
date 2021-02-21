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
    
    var currentToDoArray = [String]()
    var currentDateArray = [String]()
    
    let saveData = UserDefaults.standard
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        table.dataSource = self
        table.delegate = self
        
        toDoArray = ["りんご", "ごりら"]
        dateArray = ["", ""]
        
        //もしUserDefaultsに中身あったら読み込む
        if saveData.object(forKey: "toDoArray") != nil {
            //UserDefaultsの中身をArrayに表示
            toDoArray = saveData.array(forKey: "toDoArray") as! [String]
        }
        if saveData.object(forKey: "dateArray") != nil{
                dateArray = saveData.array(forKey: "dateArray") as! [String]
            }
        
        //書いてたものがあればアペンドするよ
        if toDoList != nil{
            toDoArray.append(toDoList)
            saveData.set(toDoArray, forKey: "toDoarray")
            
            dateArray.append(date)
            saveData.setValue(dateArray, forKey: "dateArray")
        }
            currentToDoArray = toDoArray
            currentDateArray = dateArray
        }
    
    
    //アラート
    override func viewDidAppear(_ animated: Bool) {
        if toDoList != nil {
            let alert: UIAlertController = UIAlertController(
                title:"追加されました",
                message: "",
                preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK",style:.default,handler:nil))
            present(alert,animated: true,completion: nil)
        }
    }
    
    //    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
    //        tableView.deselectRow(at: indexPath, animated: true)
    //    }
    //セルの数を設定
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return currentToDoArray.count
    }
    
    //ID付きのcellを取得してセルのLableに表示させるよ
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = currentToDoArray [indexPath.row]
        cell.detailTextLabel?.text = currentDateArray [indexPath.row]
        return cell
    }
    
    //削除機能
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == UITableViewCell.EditingStyle.delete {
            currentToDoArray.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath as IndexPath], with: UITableView.RowAnimation.automatic)
            //currentDateArray.remove(at: indexPath.row)
            //tableView.deleteRows(at: [indexPath as IndexPath], with: UITableView.RowAnimation.automatic)
        }
    }
    
}





