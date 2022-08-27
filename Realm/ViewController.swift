//
//  ViewController.swift
//  Realm
//
//  Created by Atsuhiro Muroyama on 2022/08/27.
//

import UIKit
import RealmSwift
import SwiftUI
class ViewController: UIViewController {
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var contentTextField: UITextField!
    let realm = try! Realm()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let memo: Memo? = read()
        
        titleTextField.text = memo?.title
        contentTextField.text = memo?.content
        titleTextField.delegate = self
        contentTextField.delegate = self
        
    }
    func read() -> Memo? {
        return realm.objects(Memo.self).first
    }
    @IBAction func save(_ sender: Any) {
        let title: String = titleTextField.text!
        let content: String - contentTextField.text!
        
        let memo: Memo? = read()
        if(memo != nil){
            try! realm.writ{
                memo!.title = title
                memo!.content = content
            }
        }else{
            let newMemo = Memo()
            newMemo.title = title
            newMemo.content = content
            
            try! realm.write {
                realm.add(newMemo)
            }
        }
        let alert:UIAlertController = UIAlertController(title: "成功", message: "保存しました", preferredStyle: .alert)
        alert.addAction(
            UIAlertAction(title: "OK", style: .default, handler: nil)
        )
        
        present(alert, animated: true, completion: nil)
    }
    
}
extension ViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
    }
}
