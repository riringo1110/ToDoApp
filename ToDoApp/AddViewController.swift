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
    
    
    @IBAction func datePicker(_ sender: UIDatePicker) {
        let format = DateFormatter ()
        format.dateFormat = "MM/dd HH:mm"
        date = format.string (from: sender.date)
    
    }
    
    
    @IBAction func save() {
        var toDoArray = [String]()
        var dateArray = [String]()
        
        if saveData.object(forKey: "todoArray") != nil {
            //UserDefaultsの中身をArrayに表示
            toDoArray = saveData.array(forKey: "todoArray") as! [String]
            
            if saveData.object(forKey: "dateArray") != nil{
                dateArray = saveData.array(forKey: "dateArray") as! [String]
            }
        }
        toDoList = textField.text
        
        toDoArray.append(toDoList)
        dateArray.append(date)
       
        saveData.set(toDoArray, forKey: "todoArray")
        saveData.set(dateArray, forKey: "dateArray")
        
        
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
