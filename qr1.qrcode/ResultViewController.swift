//
//  ResultViewController.swift
//  qr1.qrcode
//
//  Created by Bahaeddin Sagar on 7/25/17.
//  Copyright © 2017 Almadar Aljadid. All rights reserved.
//

import UIKit
import Contacts
import ContactsUI

//protocol AddContactViewControllerDelegate {
//    func didFetchContacts(_ contacts: [CNContact])
//}

extension String {
    
    var digits: String {
        return components(separatedBy: CharacterSet.decimalDigits.inverted)
            .joined()
    }
}

class ResultViewController: UIViewController, CNContactPickerDelegate {
    
    
    @IBOutlet var readQR: UIButton!
    @IBOutlet var fill: UIButton!
    @IBOutlet var send: UIButton!
    @IBOutlet var fillSomeoneElse: UIButton!
    
    
    var scanResult = "2323232331111"
    
    @IBOutlet var ResultLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        // Edit button shape
        //readQR.backgroundColor = .clear
        readQR.layer.cornerRadius = 5
        //readQR.layer.borderWidth = 1
        readQR.layer.borderColor = UIColor.black.cgColor
        
        //fill.backgroundColor = .clear
        fill.layer.cornerRadius = 5
        //fill.layer.borderWidth = 1
        fill.layer.borderColor = UIColor.black.cgColor
        
        //send.backgroundColor = .clear
        send.layer.cornerRadius = 5
        //send.layer.borderWidth = 1
        send.layer.borderColor = UIColor.black.cgColor
        
        // fillSomeoneElse.backgroundColor = .clear
        fillSomeoneElse.layer.cornerRadius = 5
        //fillSomeoneElse.layer.borderWidth = 1
        fillSomeoneElse.layer.borderColor = UIColor.black.cgColor
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if scanResult.characters.count != 13 {
            
            ResultLabel.text = "  الكود غير صحيح "
            
            
            let alertController = UIAlertController(title: "خطأ", message: "  الكود غير صحيح ", preferredStyle: UIAlertControllerStyle.alert)
            self.present(alertController, animated: true, completion: nil)
            let delay = DispatchTime.now() + 2 // change 1 to desired number of seconds
            DispatchQueue.main.asyncAfter(deadline: delay) {
                // Your code with delay
                alertController.dismiss(animated: true, completion: nil)
                let _ = self.navigationController?.popViewController(animated: true)
            }
            
            self.present(alertController, animated: true, completion: nil)
            
            
            
        } else {
            
            
            ResultLabel.text = scanResult
        }
        
        
        
        let setting = UIBarButtonItem(image: #imageLiteral(resourceName: "togelicon"), style: .plain, target: self, action: #selector(ViewController.goToSetting))
        
        //let setting = UIBarButtonItem(barButtonSystemItem: .organize, target: self, action: #selector(ViewController.goToSetting))
        self.navigationItem.rightBarButtonItem = setting
        
        self.navigationController?.title = " القارئ السريع "

        
        
        
    }
    
    
    func goToSetting () {
        
        performSegue(withIdentifier: "Settings", sender: self)
        /*
         let myVC = storyboard?.instantiateViewController(withIdentifier: "setting") as! SettingTableViewController
         
         navigationController?.pushViewController(myVC, animated: true)
         
         */
    }
    
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
    @IBAction func ReadAnotherCode(_ sender: Any) {
        
        //Go back to last view
        let _ = self.navigationController?.popViewController(animated: true)
        
        
    }
    @IBAction func FillCard(_ sender: Any) {
        
        
        let alert = UIAlertController(title: "طريقة التعبئة", message: "اختر طريقة التعيئة", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "اتصال", style: .default, handler: { [weak alert] (_) in
            
            let numberToDial = "120,2,"+self.scanResult+"#,,0"
            let dialString = "telprompt://" + numberToDial
            if let escapedDialString = dialString.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) {
                if let dialURL = URL(string: escapedDialString) {
                    if #available(iOS 10.0, *) {
                        UIApplication.shared.open(dialURL)
                    } else {
                        // Fallback on earlier versions
                        UIApplication.shared.openURL(dialURL)
                    }
                }
            }
            
            
            
            
            
        }))
        
        
        alert.addAction(UIAlertAction(title: "USSD", style: .default, handler: { [weak alert] (_) in
            
            
            let numberToDial = "*112*"+self.scanResult+"#"
            
            let pasteBoard = UIPasteboard.general
            pasteBoard.string = numberToDial
            
            let alertController = UIAlertController(title: "تم النسخ", message: "الرجاء فتح تطبيق الهاتف و لصق الكود و الاتصال", preferredStyle: UIAlertControllerStyle.alert)
            self.present(alertController, animated: true, completion: nil)
            let delay = DispatchTime.now() + 2 // change 1 to desired number of seconds
            DispatchQueue.main.asyncAfter(deadline: delay) {
                // Your code with delay
                alertController.dismiss(animated: true, completion: nil)
            }
            
            
            
        }))
        
        
        alert.addAction(UIAlertAction(title: "إلغاء", style: .default, handler: { [weak alert] (_) in
            
            
            
            
            
            
        }))
        
        
        // 4. Present the alert.
        self.present(alert, animated: true, completion: nil)
        
        
        
        
    }
    
    
    @IBAction func Send(_ sender: Any) {
        
        let Message = "الرقم السري لبطاقة التعبئة من المدار الجديد" + "\n" + scanResult + "\n" + "لتعبئة البطاقة  #الرقم السري*112*"
        
        
        displayShareSheet(shareContent: Message)
        
        
    }
    
    
    
    
    @IBAction func fillForSomeoneElse(_ sender: Any) {
        fillfor(number: "")
        
        
    }
    
    
    func fillfor( number : String){
        //1. Create the alert controller.
        let alert = UIAlertController(title: "رقم الهاتف", message: " [091XXXXXX] أدخل رقم الهاتف ", preferredStyle: .alert)
        
        //2. Add the text field. You can configure it however you need.
        alert.addTextField { (textField) in
            textField.text = number
            textField.keyboardType = UIKeyboardType.numberPad
            textField.isSecureTextEntry = false
            
        }
        
        // 3. Grab the value from the text field, and print it when the user clicks OK.
        
        alert.addAction(UIAlertAction(title: "أرسل", style: .default, handler: { [weak alert] (_) in
            guard let number = alert?.textFields![0].text else {
                
                
                return
            }
            if number.characters.count == 10 {
                let numberToDial = "*140*4*4*"+number+"*"+self.scanResult+"#"
                
                let pasteBoard = UIPasteboard.general
                pasteBoard.string = numberToDial
                
                let alertController = UIAlertController(title: "تم النسخ", message: "الرجاء فتح تطبيق الهاتف و لصق الكود و الاتصال", preferredStyle: UIAlertControllerStyle.alert)
                self.present(alertController, animated: true, completion: nil)
                let delay = DispatchTime.now() + 2 // change 1 to desired number of seconds
                DispatchQueue.main.asyncAfter(deadline: delay) {
                    // Your code with delay
                    alertController.dismiss(animated: true, completion: nil)
                }
                
                
                
                
            } else if number.characters.count == 9 {
                let numberToDial = "*140*4*4*"+"0"+number+"*"+self.scanResult+"#"
                
                let pasteBoard = UIPasteboard.general
                pasteBoard.string = numberToDial
                
                let alertController = UIAlertController(title: "تم النسخ", message: "الرجاء فتح تطبيق الهاتف و لصق الكود و الاتصال", preferredStyle: UIAlertControllerStyle.alert)
                self.present(alertController, animated: true, completion: nil)
                let delay = DispatchTime.now() + 2 // change 1 to desired number of seconds
                DispatchQueue.main.asyncAfter(deadline: delay) {
                    // Your code with delay
                    alertController.dismiss(animated: true, completion: nil)
                }
                
                
            }
            
            
            //TODO :
            // Read the number and send the charge it for him
            
            
            
            
        }))
        
        
        alert.addAction(UIAlertAction(title: "أختر من القائمة", style: .default, handler: {[weak alert] (_) in
            let contactPickerViewController = CNContactPickerViewController()
            
            contactPickerViewController.predicateForEnablingContact = NSPredicate(format: "phoneNumber != nil")
            contactPickerViewController.displayedPropertyKeys = [CNContactPhoneNumbersKey]
            contactPickerViewController.delegate = self
            
            self.present(contactPickerViewController, animated: true, completion: nil)
            
            
            
        }))
        
        
        alert.addAction(UIAlertAction(title: "إلغاء", style: .default, handler: { [weak alert] (_) in
            
            
            
        }))
        
        // 4. Present the alert.
        self.present(alert, animated: true, completion: nil)
        
        
    }
    
    
    
    func contactPickerDidCancel(picker: CNContactPickerViewController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
    func contactPicker(_ picker: CNContactPickerViewController, didSelect contactProperty: CNContactProperty) {
        let contact = contactProperty.contact
        let phoneNumber = contactProperty.value as! CNPhoneNumber
        
        print(contact.givenName)
        print(phoneNumber.stringValue)
        DispatchQueue.main.async { [unowned self] in
            self.fillfor(number: phoneNumber.stringValue.digits)
        }
    }
    
    
    func displayShareSheet(shareContent:String) {
        let activityViewController = UIActivityViewController(activityItems: [shareContent as NSString], applicationActivities: nil)
        present(activityViewController, animated: true, completion: {})
    }
    
}



