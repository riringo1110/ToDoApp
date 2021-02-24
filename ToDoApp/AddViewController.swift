//
//  AddViewController.swift
//  ToDoApp
//
//  Created by Ririko Nagaishi on 2021/02/17.
//

import UIKit
class AddViewController: UIViewController, UITextFieldDelegate {
    
    
    @IBOutlet var textField: UITextField!
    @IBOutlet var dateWheels: UIDatePicker!
    
    var toDoList: String!
    var date: String!
    
    
    
    var datePicker = DateFormatter()
    let saveData: UserDefaults = UserDefaults.standard
    
    var observer: NSKeyValueObservation?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //textFieldのデリゲートはViewControllerに書く
        textField.delegate = self      
    }
    
    
    //    //データをリスト画面に受け渡す
    //    func toList() {
    //        performSegue(withIdentifier: "toList", sender: nil)
    //        //self.dismiss(animated: true, completion: nil)
    //    }
    
//    //Segueを準備するときのメソッド
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if segue.identifier == "toList" {
//            let ViewController = segue.destination as! ViewController
//            ViewController.toDoArray = self.toDoArray
//            if date != nil {
//                ViewController.dateArray = self.dateArray
//            }else{
//                ViewController.date = ""
//
//            }
//        }
//    }
    
    @IBAction func datePicker(_ sender: UIDatePicker) {
        let format = DateFormatter ()
        format.dateFormat = "yyyy/MM/dd"
        date = format.string (from: sender.date)
    }
    
    
    @IBAction func save() {
        var toDoArray = [String]()
        var dateArray = [String]()
        
        if saveData.object(forKey: "todoArray") != nil {
            //UserDefaultsの中身をArrayに表示
            toDoArray = saveData.array(forKey: "todoArray") as! [String]
            print(toDoArray)
            
            if saveData.object(forKey: "dateArray") != nil{
                dateArray = saveData.array(forKey: "dateArray") as! [String]
            }
        }
        toDoList = textField.text
        date = datePicker.dateFormat
        
        toDoArray.append(toDoList)
        dateArray.append(date)
        saveData.set(toDoArray, forKey: "todoArray")
        saveData.setValue(dateArray, forKey: "dateArray")
        
        //アラート
        let alert: UIAlertController = UIAlertController(title:"追加されました", message: "", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK",style:.default,handler:{ action in
            // 押された時のアクション
            self.dismiss(animated: true, completion: nil)
        }))
        present(alert,animated: true,completion: nil)
    }
    
    @IBAction func cancel() {
        self.dismiss(animated: true, completion: nil)
    }
    //Keyboard閉じる
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        
        return true
    }
    
}
