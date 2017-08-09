//
//  ViewController.swift
//  qr1.qrcode
//
//  Created by Bahaeddin Sagar on 7/25/17.
//  Copyright © 2017 Almadar Aljadid. All rights reserved.
//

import UIKit
import AVFoundation




class ViewController: UIViewController  {
    
    @IBOutlet var scan: UIButton!
    @IBOutlet var testdata: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.hidesBackButton = true;

        
        /* this is disabled until they need authentication with the phonenumber
         
         
        //get Verification ID
        let verificationID = UserDefaults.standard.string(forKey: "authVerificationID")
        let verificationCode = UserDefaults.standard.string(forKey: "authVerificationCode")
        
        if verificationCode == nil || verificationID == nil || verificationCode == "" || verificationID == "" {
            performSegue(withIdentifier: "ActivatationScene", sender: self)
            
         
         /*   we now use perform segue
         
         
             let myVC = self.storyboard?.instantiateViewController(withIdentifier: "Activate") as! AuthViewController
             
             self.navigationController?.pushViewController(myVC, animated: true)
             */
            
            
        }
        */
        
        // Do any additional setup after loading the view.
        //scan.backgroundColor = .clear
        scan.layer.cornerRadius = 5
        //scan.layer.borderWidth = 1
        scan.layer.borderColor = UIColor.black.cgColor
               
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let setting = UIBarButtonItem(image: #imageLiteral(resourceName: "togelicon"), style: .plain, target: self, action: #selector(ViewController.goToSetting))
        
        //let setting = UIBarButtonItem(barButtonSystemItem: .organize, target: self, action: #selector(ViewController.goToSetting))
        self.navigationItem.rightBarButtonItem = setting
        
        self.navigationController?.title = " القارئ السريع "
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
       
        
    }
    
    func goToSetting () {
        
        performSegue(withIdentifier: "Setting", sender: self)
        /*
         let myVC = storyboard?.instantiateViewController(withIdentifier: "setting") as! SettingTableViewController
         
         navigationController?.pushViewController(myVC, animated: true)
         
         */
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
