//
//  MainVC.swift
//  Moody
//
//  Created by Bhagat Singh on 6/11/17.
//  Copyright © 2017 com.bhagat_singh. All rights reserved.
//

import UIKit
import NKOColorPickerView
import Alamofire
import BRYXBanner

class MainVC: UIViewController{

    //IBOutlets
    @IBOutlet weak var doneButton: UIButton!
    @IBOutlet weak var pickerView1: NKOColorPickerView!
    @IBOutlet weak var pickerView2: NKOColorPickerView!
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    
    //Initialisation
    struct color{
        var r : CGFloat = 0
        var g : CGFloat = 0
        var b : CGFloat = 0
    }
    
    var color1 = color(r: 0, g: 0, b: 0)
    var color2 = color(r: 0, g: 0, b: 0)
    var tempColor = color(r: 0, g: 0, b: 0)
    var randomColor1 = color(r: 0, g: 0, b: 0)
    var randomColor2 = color(r: 0, g: 0, b: 0)
    
    var hardwareID : String!
    typealias completed = () -> ()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Initial Setup
        setup()
    }
    
    func setup(){
        
        //Picker View Setup
        pickerView1.color = UIColor(red: CGFloat(drand48()), green: CGFloat(drand48()), blue: CGFloat(drand48()), alpha: CGFloat(drand48()))
        pickerView2.color = UIColor(red: CGFloat(drand48()), green: CGFloat(drand48()), blue: CGFloat(drand48()), alpha: CGFloat(drand48()))
        
        
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
            color1 = getColor(color: pickerView1.color)
            let banner = Banner(title: "Successful", subtitle: "The color was set successfully", backgroundColor: UIColor(red:48.00/255.0, green:174.0/255.0, blue:51.5/255.0, alpha:1.000))
            banner.dismissesOnTap = true
            singleColorCall {
                banner.show(duration: 2.0)
            }
        }
        
        if segmentedControl.selectedSegmentIndex == 1{
            color1 = getColor(color: pickerView1.color)
            color2 = getColor(color: pickerView2.color)
            let banner1 = Banner(title: "Successful", subtitle: "The colors were set successfully", backgroundColor: UIColor(red:48.00/255.0, green:174.0/255.0, blue:51.5/255.0, alpha:1.000))
            banner1.dismissesOnTap = true
            doubleColorCall {
                banner1.show(duration: 1.0)
            }
        }
        
        if segmentedControl.selectedSegmentIndex == 2{
            let banner2 = Banner(title: "Successful", subtitle: "The colors were set successfully", backgroundColor: UIColor(red:48.00/255.0, green:174.0/255.0, blue:51.5/255.0, alpha:1.000))
            banner2.dismissesOnTap = true
            randomColorCall {
                banner2.show(duration: 1.0)
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
            
            randomColor1.r = CGFloat(drand48())
            randomColor1.g = CGFloat(drand48())
            randomColor1.b = CGFloat(drand48())
        
            randomColor2.r = CGFloat(drand48())
            randomColor2.g = CGFloat(drand48())
            randomColor2.b = CGFloat(drand48())
            
            pickerView1.color = UIColor(red: randomColor1.r , green: randomColor1.g, blue: randomColor1.b, alpha: 1.0)
            pickerView2.color = UIColor(red: randomColor2.r , green: randomColor2.g, blue: randomColor2.b, alpha: 1.0)
        }
    }
    
    func singleColorCall(completed: @escaping completed){
        color1.r = round(color1.r * 255)
        color1.g = round(color1.g * 255)
        color1.b = round(color1.b * 255)
        
        Alamofire.request("http://akshaybaweja.com/mood.php?request=set&r1=\(Int(color1.r))&g1=\(Int(color1.g))&b1=\(Int(color1.b))&r2=\(Int(color1.r))&g2=\(Int(color1.g))&b2=\(Int(color1.b))&HID=testdev", method: .get).responseJSON { (response) in
            let result = response.result
            print(result)
            completed()
        }
    }
    
    func doubleColorCall(completed: @escaping completed){
        color1.r = round(color1.r * 255)
        color1.g = round(color1.g * 255)
        color1.b = round(color1.b * 255)
        
        color2.r = round(color2.r * 255)
        color2.g = round(color2.g * 255)
        color2.b = round(color2.b * 255)
        
        Alamofire.request("http://akshaybaweja.com/mood.php?request=set&r1=\(Int(color1.r))&g1=\(Int(color1.g))&b1=\(Int(color1.b))&r2=\(Int(color2.r))&g2=\(Int(color2.g))&b2=\(Int(color2.b))&HID=testdev", method: .get).responseJSON { (response) in
            let result = response.result
            print(result)
            completed()        }
    }
    
    func randomColorCall(completed: @escaping completed){
        
        randomColor1.r = round(randomColor1.r * 255)
        randomColor1.g = round(randomColor1.g * 255)
        randomColor1.b = round(randomColor1.b * 255)
        
        randomColor2.r = round(randomColor2.r * 255)
        randomColor2.g = round(randomColor2.g * 255)
        randomColor2.b = round(randomColor2.b * 255)
        
        
        Alamofire.request("http://akshaybaweja.com/mood.php?request=set&r1=\(Int(randomColor1.r))&g1=\(Int(randomColor1.g))&b1=\(Int(randomColor1.b))&r2=\(Int(randomColor2.r)))&g2=\(Int(randomColor2.g))&b2=\(Int(randomColor2.b))&HID=testdev", method: .get).responseJSON { (response) in
            let result = response.result
            print(result)
            completed()
        }
    }
    
    func getColor(color: UIColor)->color{
        var a : CGFloat = 0.0
        color.getRed(&tempColor.r, green: &tempColor.g, blue: &tempColor.b, alpha: &a)
        return tempColor
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

