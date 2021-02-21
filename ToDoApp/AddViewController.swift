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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //textFieldのデリゲートはViewControllerに書く
        textField.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
            super.viewWillAppear(animated)
    }
    
    //Segueを準備するときのメソッド
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toList" {
            let ViewController = segue.destination as! ViewController
            ViewController.toDoList = self.toDoList
            if date != nil {
                ViewController.date = self.date
            }else{
                ViewController.date = ""
            }
        }
    }
    
    //データをリスト画面に受け渡す
    func performSegueToList() {
        performSegue(withIdentifier: "toList", sender: nil)
    }
    
    //Keyboard閉じる
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        
        return true
    }
    
    @IBAction func save() {
        
        //toDoListに入力内容を入れる
        toDoList = textField.text
       
        //dateWheelsの設定
        dateWheels.datePickerMode = .date
        datePicker.dateStyle = .short
        datePicker.timeStyle = .short
        datePicker.dateFormat =  DateFormatter.dateFormat(fromTemplate: "yyyy/MM/dd", options: 0, locale: Locale(identifier: "eng_JP"))
        let selectedDate = datePicker.string(from: dateWheels.date)
        date = selectedDate
        
        // UserDefaultsに書き込み
        saveData.set(toDoList, forKey: "todo")
        saveData.set(date, forKey: "date")

        performSegueToList()
    }
  
//    @IBAction func datePicker(_ sender: UIDatePicker) {
//            let format = DateFormatter ()
//            format.dateFormat = "yyyy/MM/dd"
//        date = format.string (from: sender.date)
//    }
    
    @IBAction func cancel() {
        self.dismiss(animated: true, completion: nil)
    }
}
