//
//  DiemCaoViewController.swift
//  CD_iOS
//
//  Created by Nguyen Hung My on 12/16/16.
//  Copyright © 2016 Nguyen Hung My. All rights reserved.
//

import UIKit
import CoreData

class DiemCaoViewController: UIViewController {

    // Label nguoi choi
    @IBOutlet weak var lblNguoiChoi1: UILabel!
    @IBOutlet weak var lblNguoiChoi2: UILabel!
    @IBOutlet weak var lblNguoiChoi3: UILabel!
    @IBOutlet weak var lblNguoiChoi4: UILabel!
    @IBOutlet weak var lblNguoiChoi5: UILabel!
    
    // Label diem
    @IBOutlet weak var lblDiem1: UILabel!
    @IBOutlet weak var lblDiem2: UILabel!
    @IBOutlet weak var lblDiem3: UILabel!
    @IBOutlet weak var lblDiem5: UILabel!
    @IBOutlet weak var lblDiem4: UILabel!
    
    var arrPlayer = [String]()
    var arrScore = [String]()
    var thamsoTruyen:NSUserDefaults!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        thamsoTruyen = NSUserDefaults()
        
        let appDel:AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let context:NSManagedObjectContext = appDel.managedObjectContext
        
        let request = NSFetchRequest(entityName: "NguoiChoi")
        request.returnsObjectsAsFaults = false
        // create predecate
        
        request.sortDescriptors = [NSSortDescriptor(key: "diem", ascending : false)]
        
        
        do {
            let results = try context.executeFetchRequest(request)
            if results.count == 0 {
                
            }
            var count=0
            for result:AnyObject in results {
                let text = String(result.valueForKey("ten") as! String)
                count = count + 1
                if count > 5 {
                    break
                }
                print(text)
                print(String(result.valueForKey("diem") as! Int))
                arrPlayer.append(text)
                arrScore.append(String(result.valueForKey("diem") as! Int))
            }
            SetLabel(results.count)
        }
        catch{
            print("select fail")
        }
        
    }
    func SetLabel(count:Int) {
        if count == 0 {
        }
        else if count == 1 {
            lblNguoiChoi1.text = arrPlayer[0]
            lblDiem1.text = arrScore[0]
        } else if count == 2 {
            lblNguoiChoi1.text = arrPlayer[0]
            lblNguoiChoi2.text = arrPlayer[1]
            lblDiem1.text = arrScore[0]
            lblDiem2.text = arrScore[1]
        } else if count == 3 {
            lblNguoiChoi1.text = arrPlayer[0]
            lblNguoiChoi2.text = arrPlayer[1]
            lblNguoiChoi3.text = arrPlayer[2]
            lblDiem1.text = arrScore[0]
            lblDiem2.text = arrScore[1]
            lblDiem1.text = arrScore[2]
        } else if count == 4 {
            lblNguoiChoi1.text = arrPlayer[0]
            lblNguoiChoi2.text = arrPlayer[1]
            lblNguoiChoi3.text = arrPlayer[2]
            lblNguoiChoi4.text = arrPlayer[3]
            lblDiem1.text = arrScore[0]
            lblDiem2.text = arrScore[1]
            lblDiem3.text = arrScore[2]
            lblDiem4.text = arrScore[3]
        } else {
            lblNguoiChoi1.text = arrPlayer[0]
            lblNguoiChoi2.text = arrPlayer[1]
            lblNguoiChoi3.text = arrPlayer[2]
            lblNguoiChoi4.text = arrPlayer[3]
            lblNguoiChoi5.text = arrPlayer[4]
            lblDiem1.text = arrScore[0]
            lblDiem2.text = arrScore[1]
            lblDiem3.text = arrScore[2]
            lblDiem4.text = arrScore[3]
            lblDiem5.text = arrScore[4]
        }
    }
}
