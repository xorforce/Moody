//
//  ViewController.swift
//  Moody
//
//  Created by Bhagat Singh on 6/11/17.
//  Copyright © 2017 com.bhagat_singh. All rights reserved.
//

import UIKit
import NKOColorPickerView
import Alamofire

class ViewController: UIViewController{

    //IBOutlets
    @IBOutlet weak var doneButton: UIButton!
    @IBOutlet weak var pickerView1: NKOColorPickerView!
    @IBOutlet weak var pickerView2: NKOColorPickerView!
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    
    //Initialisation
    var r : CGFloat = 0
    var g : CGFloat = 0
    var b : CGFloat = 0
    var a : CGFloat = 0
    var r1 : CGFloat = 0
    var g1 : CGFloat = 0
    var b1 : CGFloat = 0
    var a1 : CGFloat = 0
    var r2 : CGFloat = 0
    var g2 : CGFloat = 0
    var b2 : CGFloat = 0
    var a2 : CGFloat = 0
    var hardwareID : Double = 0
    typealias completed = () -> ()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Initial Setup
        setup()
    }
    
    func setup(){
        
        //Picker View Setup
        pickerView1.color = .red
        pickerView2.color = .blue
        
        //Segmented Control Setup
        segmentedControl.selectedSegmentIndex = 0
        
        //Button UI Setup
        doneButton.layer.borderColor = UIColor(red: 227/255, green: 180/255, blue: 74/255, alpha: 1.0).cgColor
        doneButton.layer.borderWidth = 1.5
        doneButton.layer.cornerRadius = 20.0
        
        //Other setup
        pickerView2.isHidden = true
    }
    
    @IBAction func doneButtonPressed(_ sender: Any) {
        if segmentedControl.selectedSegmentIndex == 0{
            getColor(color: pickerView1.color)
            singleColorCall {
                //do something
            }
        }
        
        if segmentedControl.selectedSegmentIndex == 1{
            doubleColorCall {
                //do something
            }
        }
        
        if segmentedControl.selectedSegmentIndex == 2{
            randomColorCall {
                //do something
            }
        }
    }
    
    
    @IBAction func segmentedControlChangedValue(_ sender: Any) {
        if segmentedControl.selectedSegmentIndex == 0{
            pickerView2.isHidden = true
        }
        
        if segmentedControl.selectedSegmentIndex == 1{
            pickerView2.isHidden = false
        }
        
        if segmentedControl.selectedSegmentIndex == 2{
            pickerView2.isHidden = false
            pickerView1.color = UIColor(red: CGFloat(arc4random_uniform(256)), green: CGFloat(arc4random_uniform(256)), blue: CGFloat(arc4random_uniform(256)), alpha: 1.0)
            pickerView2.color = UIColor(red: CGFloat(arc4random_uniform(256)), green: CGFloat(arc4random_uniform(256)), blue: CGFloat(arc4random_uniform(256)), alpha: 1.0)
        }
    }
    
    func singleColorCall(completed: @escaping completed){
        Alamofire.request("https://akshaybaweja.com/mood.php?request=set&HID=\(hardwareID)&r1=\(r1)&g1=\(g1)&b1=\(b1)&r2=\(r1)&g2=\(g1)&b2=\(b1)", method: .get).responseJSON { (response) in
            let result = response.result
        }
    }
    
    func doubleColorCall(completed: @escaping completed){
        Alamofire.request("https://akshaybaweja.com/mood.php?request=set&HID=\(hardwareID)&r1=\(r1)&g1=\(g1)&b1=\(b1)&r2=\(r2)&g2=\(g2)&b2=\(b2)", method: .get).responseJSON { (response) in
            let result = response.result
        }
    }
    
    func randomColorCall(completed: @escaping completed){
        Alamofire.request("https://akshaybaweja.com/mood.php?request=set&HID=\(hardwareID)&r1=\(r1)&g1=\(g1)&b1=\(b1)&r2=\(r2)&g2=\(g2)&b2=\(b2)", method: .get).responseJSON { (response) in
            let result = response.result
        }
    }
    
    func getColor(color: UIColor)->(Double, Double, Double){
        color.getRed(&r, green: &g, blue: &b, alpha: &a)
        return ((Double(round(r*100)/100)), Double(round(g*100)/100), Double(round(b*100)/100))
        
    }
    
  }


extension UIColor{
    var coreImageColor: CIColor{
        return CIColor(color:self)
    }
    var components: (red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat){
        let coreImageColor = self.coreImageColor
        return (coreImageColor.red, coreImageColor.green, coreImageColor.blue, coreImageColor.alpha)
    }
}

