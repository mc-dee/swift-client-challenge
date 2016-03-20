//
//  FirstVC.swift
//  Challenge
//
//  Created by Daniel Piotrowski on 12.03.16.
//  Copyright © 2016 MeDaPi. All rights reserved.
//

import UIKit

class FirstVC: UIViewController {

    
    
    
    
    @IBOutlet weak var textField: UITextField!
    
    
    @IBAction func repoBTNPressed(sender: AnyObject) {
        
         let text = (textField.text?.stringByReplacingOccurrencesOfString(" ", withString: ""))! as String
        let text1 = text.stringByReplacingOccurrencesOfString(".", withString: "")
        
        
        if textField.text == "" {
            
            textField.placeholder = "bitte gib etwas ein..."
            
            print("bin im if")
            
        } else {
            
            
            TableViewController.user1 = text1
            
            print("bin im else")
            print(text)
            self.performSegueWithIdentifier("firstSegue", sender: self)
        }
        
        
        
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        textField.becomeFirstResponder()
        
        

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
