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
    
    var toDoArray = [String]()
    var dateArray = [String]()
    
    var datePicker = DateFormatter()
    let saveData: UserDefaults = UserDefaults.standard
    
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
    
    //Segueを準備するときのメソッド
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toList" {
            let ViewController = segue.destination as! ViewController
            ViewController.toDoArray = self.toDoArray
            if date != nil {
                ViewController.dateArray = self.dateArray
            }else{
                ViewController.date = ""
                
            }
        }
    }
    
    @IBAction func save() {
        
        toDoList = textField.text
        date = datePicker.dateFormat
        
        toDoArray.append(toDoList)
        dateArray.append(date)
        saveData.set(toDoArray, forKey: "todoArray")
        saveData.setValue(dateArray, forKey: "dateArray")
        
        self.dismiss(animated: true, completion: nil)
        //書いてたものがあればアペンドするよ
//        if toDoList != nil{
//            toDoArray.append(toDoList)
//            saveData.set(toDoArray, forKey: "todoArray")
//
//            if date != nil{
//                dateArray.append(date)
//                saveData.setValue(dateArray, forKey: "dateArray")
//                print("ok")
//
               
        
        
        //アラート
//        override func viewDidAppear(_ animated: Bool) {
//            if toDoList != nil {
                let alert: UIAlertController = UIAlertController(title:"追加されました", message: "", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK",style:.default,handler:{ action in
                    // 押された時のアクション
                    self.dismiss(animated: true, completion: nil)
                }))
                present(alert,animated: true,completion: nil)
            }
    
    @IBAction func datePicker(_ sender: UIDatePicker) {
        let format = DateFormatter ()
        format.dateFormat = "yyyy/MM/dd"
        date = format.string (from: sender.date)
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
