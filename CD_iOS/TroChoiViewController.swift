//
//  TroChoiViewController.swift
//  ListenEnglish
//
//  Created by Nguyen Hung My on 12/14/16.
//  Copyright © 2016 Nguyen Hung My. All rights reserved.
//

import UIKit
import AVFoundation
import CoreData

class TroChoiViewController: UIViewController {
    
    //Bien luu diem va ten nguoi choi
   
    
    //Khai bao bien messeges
    
    var thongbaochon = UIAlertController(title: "Thong bao", message:
        "BAN CHAC CHAN VOI LUA CHON NAY?", preferredStyle: UIAlertControllerStyle.Alert)
    
    var thongbaochonsai = UIAlertController(title: "Thong bao", message:
        "RAT TIEC BAN KHONG VUOT QUA DUOC CAU HOI NAY!", preferredStyle: UIAlertControllerStyle.Alert)
    
    // Khai bao bien cau hoi va cau tra loi
    var textquestion = [String]()
    var audioquestion = [String]()
    var textanswerA = [String]()
    var textanswerB = [String]()
    var textanswerC = [String]()
    var textanswerD = [String]()
    var arrKQ = [String]()
    var KQDung = String()
    var numberQuestion:Int = 0
    
    var diem:Int = 0
    
    var audioPlayer : AVAudioPlayer!
    
    var timerCount = 60
    var timerRunning = false
    
    
    var thamsoTruyen:NSUserDefaults!
    
    var myString:String = ""
    @IBOutlet weak var lblTen: UILabel!
    
    
    @IBOutlet weak var lblDiem: UILabel!
    

    override func viewDidLoad() {
        thamsoTruyen = NSUserDefaults()
        super.viewDidLoad()
        //print(thamsoTruyen.objectForKey("bien"))
        
       lblTen.text = thamsoTruyen.objectForKey("bien") as? String
        
        
        textquestion.append("kəˌmjuːnɪˈkeɪʃn")
        textquestion.append("kəmˈpjuːtər")
        textquestion.append("ˈdɪkʃəneri")
        textquestion.append("ɪkˈsplɔːrər")
        textquestion.append("ˈfeɪvərɪt")
        
        audioquestion.append("Communication")
        audioquestion.append("Computer")
        audioquestion.append("Dictionary")
        audioquestion.append("Explorer")
        audioquestion.append("Favourite")
        
        textanswerA.append("A:Communication")
        textanswerA.append("A:Computing")
        textanswerA.append("A:Dictionarys")
        textanswerA.append("A:Explorers")
        textanswerA.append("A:Favourites")
        
        
        textanswerB.append("B:Communicate")
        textanswerB.append("B:Computer")
        textanswerB.append("B:Dictionaries")
        textanswerB.append("B:Exploit")
        textanswerB.append("B:Favoris")
        
        textanswerC.append("C:Communities")
        textanswerC.append("C:Commitment")
        textanswerC.append("C:Dictionary")
        textanswerC.append("C:Exploitation")
        textanswerC.append("C:Favourites")
        
        textanswerD.append("D:Communications")
        textanswerD.append("D:Compute")
        textanswerD.append("D:Disribute")
        textanswerD.append("D:Explorer")
        textanswerD.append("D:Favourite")
        
        
        
        //Bien dap an
        arrKQ.append("A")
        arrKQ.append("B")
        arrKQ.append("C")
        arrKQ.append("D")
        arrKQ.append("D")
        
        
   
        
        
        //Load cau hoi 
        HienThiCauHoi(0)
        
        //HighScore
        
        
        // Do any additional setup after loading the view.
                thongbaochonsai.addAction(UIAlertAction(title: "CHOI LAI", style: .Default, handler:
            {
                action in
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let controller = storyboard.instantiateViewControllerWithIdentifier("test")
                self.presentViewController(controller, animated: true, completion:nil)
                
                let appDel:AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
                let context:NSManagedObjectContext = appDel.managedObjectContext
                
                let newUser = NSEntityDescription.insertNewObjectForEntityForName("NguoiChoi", inManagedObjectContext: context) as NSManagedObject
                newUser.setValue(self.thamsoTruyen.objectForKey("bien") as! String, forKey: "ten")
                newUser.setValue(self.diem, forKey: "diem")
                
                do{
                    //let result =
                    try context.save()
                    print(self.diem)
                    print("luu user thanh cong: ")
                }
                catch{
                    print("save fail")
                }
                
                // insert
                /*let appDel:AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
                let context:NSManagedObjectContext = appDel.managedObjectContext
                let newUser = NSEntityDescription.insertNewObjectForEntityForName("NguoiChoi", inManagedObjectContext: context) as NSManagedObject
                newUser.setValue(self.thamsoTruyen.objectForKey("bien") as! String, forKey: "ten")
                
                do{
                    //let result =
                    try context.save()
                    print("done")
                    print(self.thamsoTruyen.objectForKey("bien"))
                }
                catch{
                    print("save fail")
                }*/

                
        }))
        thongbaochon.addAction(UIAlertAction(title: "No", style: UIAlertActionStyle.Default,handler:
            {
                action in
                if self.numberQuestion == 4{
                    self.numberQuestion = 0
                }
                
        }))
        
        thongbaochon.addAction(UIAlertAction(title: "Yes", style: .Default, handler:
            {
                action in
                self.numberQuestion = self.numberQuestion + 1
                //print(self.numberQuestion)
                self.HienThiCauHoi(self.numberQuestion)
                
                
                self.diem = self.diem + 1
                self.myString = String(self.diem)
                self.lblDiem.text = self.myString
                
                if self.numberQuestion == 4{
                    self.numberQuestion = 0
                }
                
                //Chay dong ho
                
                self.lblDongHo.text = ""
                if self.timerCount == 0 {
                    self.timerRunning = false
                }
                
                if self.timerRunning == false {
                    
                    _ = NSTimer.scheduledTimerWithTimeInterval(1.0, target: self, selector: #selector(TroChoiViewController.Counting), userInfo: nil, repeats: true)
                    
                    self.timerRunning = true
                }

                
        }))
    }
    
    //Button cau tra loi
    @IBAction func btnAnswerA(sender: AnyObject) {
        
        if KQDung == "A" {
            
            self.presentViewController(thongbaochon, animated: true, completion: nil)
            
        }
        else{
           self.presentViewController(thongbaochonsai, animated: false, completion: nil)
            
            ChangeColorWrongAnswer(numberQuestion)
        }
    }
    
    @IBAction func btnAnswerB(sender: AnyObject) {
        
        if KQDung == "B" {
            self.presentViewController(thongbaochon, animated: true, completion: nil)
           
        }
        else{
            self.presentViewController(thongbaochonsai, animated: false, completion: nil)
            
            ChangeColorWrongAnswer(numberQuestion)
        }
    }
    
    @IBAction func btnAnswerC(sender: AnyObject) {
        
        if KQDung == "C" {
            self.presentViewController(thongbaochon, animated: true, completion: nil)
        }
        else{
            self.presentViewController(thongbaochonsai, animated: false, completion: nil)
            
            ChangeColorWrongAnswer(numberQuestion)
        }
    }
    
    @IBAction func btnAnswerD(sender: AnyObject) {
        
        if KQDung == "D" {
            self.presentViewController(thongbaochon, animated: true, completion: nil)
        }
        else{
            self.presentViewController(thongbaochonsai, animated: false, completion: nil)
            
            ChangeColorWrongAnswer(numberQuestion)
        }
    }
    
    
    //Outlet cau tra loi
    @IBOutlet weak var lblAnswerA: UIButton!
    
    @IBOutlet weak var lblAnswerB: UIButton!
    
    @IBOutlet weak var lblAnswerC: UIButton!
    
    @IBOutlet weak var lblAnswerD: UIButton!
    
    
    
    //Label hien thi phien am
    @IBOutlet weak var lblPhienAm: UILabel!
    
    //Ham to mau dap an dung
    
    func ChangeColorWrongAnswer(quesID:Int) {
        let realQuesID = numberQuestion
        
            if arrKQ[realQuesID] == "A" {
                lblAnswerA.backgroundColor = UIColor.redColor()
            } else if arrKQ[realQuesID] == "B" {
                lblAnswerB.backgroundColor = UIColor.redColor()
            } else if arrKQ[realQuesID] == "C" {
                lblAnswerC.backgroundColor = UIColor.redColor()
            } else {
                lblAnswerD.backgroundColor = UIColor.redColor()
        }
    }

    
    //Ham hien thi cau hoi
    
    func HienThiCauHoi(QuestionID:Int){
        lblAnswerA.setTitle(String(textanswerA[QuestionID]), forState: .Normal)
        lblAnswerB.setTitle(String(textanswerB[QuestionID]), forState: .Normal)
        lblAnswerC.setTitle(String(textanswerC[QuestionID]), forState: .Normal)
        lblAnswerD.setTitle(String(textanswerD[QuestionID]), forState: .Normal)
        lblPhienAm.text = textquestion[QuestionID]
        
        KQDung = arrKQ[QuestionID]
        
        lblAnswerA.backgroundColor = UIColor.orangeColor()
        lblAnswerB.backgroundColor = UIColor.orangeColor()
        lblAnswerC.backgroundColor = UIColor.orangeColor()
        lblAnswerD.backgroundColor = UIColor.orangeColor()
        // set question Number
        
        
        
        
        let audioPath = NSBundle.mainBundle().pathForResource(audioquestion[QuestionID], ofType: "mp3")
        
        if audioPath != nil{
            let audioFileURL = NSURL.fileURLWithPath(audioPath!)
            
            do{
                
                try audioPlayer = AVAudioPlayer(contentsOfURL: audioFileURL)
               
            }catch{
                print("ko choi dc")
            }
            
        }

    }

    @IBAction func btnPlay(sender: AnyObject) {
        
        
        
        //Chay am thanh
        
        audioPlayer.play()
        
        //An nut play
        //let disableMyButton = sender as? UIButton
        //disableMyButton!.enabled = false
    }
    //Dong ho dem gio
    
    @IBOutlet weak var lblDongHo: UILabel!
    
    
    func Counting() {
        if timerCount > 0 {
            lblDongHo.text = "\(timerCount)"
            timerCount -= 1
        } else {
            lblDongHo.text = "Finish!"
            
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
