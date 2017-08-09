//
//  AuthViewController.swift
//  qr1.qrcode
//
//  Created by Bahaeddin Sagar on 7/31/17.
//  Copyright © 2017 Almadar Aljadid. All rights reserved.
//

import UIKit
import FirebaseAuth

class AuthViewController: UIViewController , UITextFieldDelegate {
    
    @IBOutlet var send: UIButton!
    @IBOutlet var phoneNumberTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.hidesBackButton = true;
        
       
        
        // Do any additional setup after loading the view.
        let tap = UITapGestureRecognizer(target: self, action: #selector(AuthViewController.onTouchGesture))
        self.view.addGestureRecognizer(tap)
        
        //send.backgroundColor = .clear
        send.layer.cornerRadius = 5
        //send.layer.borderWidth = 1
        send.layer.borderColor = UIColor.black.cgColor
        
        
    }
    func onTouchGesture(){
        self.view.endEditing(true)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func hide(_ sender: Any) {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to:nil, from:nil, for:nil)
        
    }
    
    
    @IBAction func goToAuth(_ sender: Any) {
        
        var phoneNumber = phoneNumberTextField.text!
        if phoneNumber.characters.count == 7 {
            // number is XXXXXXX
            phoneNumber = "+21891" + phoneNumber
            Auth(phoneNumber: phoneNumber)

        }else  if phoneNumber.characters.count == 9 {
            // number is 91XXXXXXX
            phoneNumber = "+218" + phoneNumber
            Auth(phoneNumber: phoneNumber)
            
        }else  if phoneNumber.characters.count == 10 {
            // number is 091XXXXXXX
            phoneNumber.remove(at: phoneNumber.startIndex)
            phoneNumber = "+218" + phoneNumber
            Auth(phoneNumber: phoneNumber)
            
        }else  if phoneNumber.characters.count == 12 {
            // number is 21891XXXXXXX
            phoneNumber = "+" + phoneNumber
            Auth(phoneNumber: phoneNumber)
            
        }else  {
            let alertController = UIAlertController(title: "خطأ", message: "  رقم الهاتف غير صحيح ", preferredStyle: UIAlertControllerStyle.alert)
            self.present(alertController, animated: true, completion: nil)
            let delay = DispatchTime.now() + 2 // change 1 to desired number of seconds
            DispatchQueue.main.asyncAfter(deadline: delay) {
                // Your code with delay
                alertController.dismiss(animated: true, completion: nil)
                let _ = self.navigationController?.popViewController(animated: true)
                
            }
            
        }
    }
    
    
    func Auth ( phoneNumber : String) {
        
        PhoneAuthProvider.provider().verifyPhoneNumber(phoneNumber) { (verificationID, error) in
            if let error = error {
                //self.showMessagePrompt(error.localizedDescription)
                print(error)
                return
            }
            // Sign in using the verificationID and the code sent to the user
            // ...
            UserDefaults.standard.set(verificationID, forKey: "authVerificationID")
            
            let myVC = self.storyboard?.instantiateViewController(withIdentifier: "Verification") as! VerificationViewController
            
            self.navigationController?.pushViewController(myVC, animated: true)
            
            
        }
        
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        
        let regEX = "^(?:|[0-9]{0,13})?$"
        let newstring = textField.text! + string
        if newstring.range(of: regEX, options:.regularExpression) != nil {
            return true
        } else {
            return false
        }
    }

    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
