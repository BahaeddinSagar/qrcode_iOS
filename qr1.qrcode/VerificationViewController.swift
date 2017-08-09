//
//  VerificationViewController.swift
//  qr1.qrcode
//
//  Created by Bahaeddin Sagar on 7/31/17.
//  Copyright © 2017 Almadar Aljadid. All rights reserved.
//

import UIKit
import FirebaseAuth

class VerificationViewController: UIViewController, UITextViewDelegate {
    
    @IBOutlet var signin: UIButton!
    @IBOutlet var confirmationCodeTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        let tap = UITapGestureRecognizer(target: self, action: #selector(AuthViewController.onTouchGesture))
        self.view.addGestureRecognizer(tap)
        
        //signin.backgroundColor = .clear
        signin.layer.cornerRadius = 5
        //signin.layer.borderWidth = 1
        signin.layer.borderColor = UIColor.black.cgColor
        
        confirmationCodeTextField.delegate = self as? UITextFieldDelegate
    }
    func onTouchGesture(){
        self.view.endEditing(true)
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func signIn(_ signiner: Any) {
        let verificationID = UserDefaults.standard.string(forKey: "authVerificationID")
        let verificationCode = confirmationCodeTextField.text!
        
        let credential = PhoneAuthProvider.provider().credential(
            withVerificationID: verificationID!,
            verificationCode: verificationCode)
        
        Auth.auth().signIn(with: credential) { (user, error) in
            if error != nil {
                // ...
                return
            }
            
            // User is signed in
            // ...
            
            UserDefaults.standard.set(verificationCode, forKey: "authVerificationCode")
            
            self.performSegue(withIdentifier: "MainScreen", sender: self)
            
            /*
            let myVC = self.storyboard?.instantiateViewController(withIdentifier: "MainActivity") as! ViewController
            
            self.navigationController?.pushViewController(myVC, animated: true)
            */
            
        }
        
        
        
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        
        let regEX = "^(?:|[0-9]{0,4})?$"
        let newstring = confirmationCodeTextField.text! + string
        if newstring.range(of: regEX, options:.regularExpression) != nil {
            return true
        } else {
            return false
        }
    }

}

/*
 // MARK: - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 override func prepare(for segue: UIStoryboardSegue, signiner: Any?) {
 // Get the new view controller using segue.destinationViewController.
 // Pass the selected object to the new view controller.
 }
 */


