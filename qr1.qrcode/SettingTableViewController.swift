//
//  SettingTableViewController.swift
//  qr1.qrcode
//
//  Created by Bahaeddin Sagar on 7/26/17.
//  Copyright © 2017 Almadar Aljadid. All rights reserved.
//

import UIKit

class SettingTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 4
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            
            var string = "1- لايحتاج التطبيق الي الاتصال بالانترنت ."
            string = string + "\n" + "2- ليعمل هذا التطبيق بالشكل الصحيح يجب اعطائه كافة الصلاحيات بعض الاجهزة"
            let alert = UIAlertController(title: " تنبيه ", message: string, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: " موافق " , style: .default, handler: { [weak alert] (_) in
                
            }))
            
            self.present(alert, animated: true, completion: nil)
            
        }
        if indexPath.row == 1 {
            let alert = UIAlertController(title: "اللغة", message: "قريبا الاصدار الجديد باللغة العربية والانجليزية" , preferredStyle: .alert)
            
            alert.addAction(UIAlertAction(title: " موافق " , style: .default, handler: { [weak alert] (_) in
                
            }))

            self.present(alert, animated: true, completion: nil)
            
        }
        if indexPath.row == 2 {
            
            var string = "جميع الحقوق محفوظة للمدار الجديد 2017 ©"
            string = string + " \n " + "الاصدار 1.2"
            let alert = UIAlertController(title: "حول البرنامج", message: string, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: " موافق " , style: .default, handler: { [weak alert] (_) in
                
            }))

            
            self.present(alert, animated: true, completion: nil)
            
        }
        if indexPath.row == 3 {
            let Message = "\nننصحك بتحميل تطبيق القارئ السريع من المدار الجديد\n\n" + " URL OF APP HERE \n\n"
            
            
            displayShareSheet(shareContent: Message)
 
        }
        
        
        
        
    }

    
    
    func displayShareSheet(shareContent:String) {
        let activityViewController = UIActivityViewController(activityItems: [shareContent as NSString], applicationActivities: nil)
        present(activityViewController, animated: true, completion: {})
    }
    
    
    
    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

    
   

    
    
}
