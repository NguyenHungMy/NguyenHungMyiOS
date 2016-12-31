//
//  NhapTenNguoiChoiViewController.swift
//  ListenEnglish
//
//  Created by Nguyen Hung My on 12/14/16.
//  Copyright © 2016 Nguyen Hung My. All rights reserved.
//

import UIKit
import CoreData

class NhapTenNguoiChoiViewController: UIViewController {

    var warning = UIAlertController(title: "Thong bao", message:
        "Ban phai nhap ten truoc khi bat dau!", preferredStyle: UIAlertControllerStyle.Alert)
    
    @IBOutlet weak var txtTen: UITextField!
    
    
    var thamsoTruyen:NSUserDefaults!
    
    
    @IBAction func btnDangNhap(sender: AnyObject) {
        
        let whitespaceSet = NSCharacterSet.whitespaceCharacterSet()
        let contain = txtTen.text
        if contain!.stringByTrimmingCharactersInSet(whitespaceSet).isEmpty {
            self.presentViewController(warning, animated: true, completion: nil)
            print("rong")
        }
        
        else{
            thamsoTruyen.setObject(txtTen.text!, forKey: "bien")
            print(txtTen.text!)
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let controller = storyboard.instantiateViewControllerWithIdentifier("trochoi")
            self.presentViewController(controller, animated: true, completion:nil)
            
        }
        
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        thamsoTruyen = NSUserDefaults()
   
        warning.addAction(UIAlertAction(title: "OK", style: .Default, handler: { action in
            
        }))
        
        // Do any additional setup after loading the view.
    }
    
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        //thamsoTruyen.setObject(txtTen.text, forKey: "bien")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}
