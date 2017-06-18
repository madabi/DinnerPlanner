//
//  SecondViewController.swift
//  DinnerPlanner
//
//  Created by Marco Bibrich on 18.06.17.
//  Copyright © 2017 DinnerPlanner. All rights reserved.
//

import UIKit
import SwiftyJSON

class SecondViewController: UIViewController {

    
    
    @IBOutlet weak var datePickerText: UITextField!
    @IBOutlet weak var locationText: UITextField!
    @IBOutlet weak var groupNameText: UITextField!
    
   
    @IBOutlet weak var radiusText: UILabel!
    @IBAction func radiusSlider(_ sender: UISlider) {
        radiusText.text = String(Int(sender.value))
    }
    
    @IBOutlet weak var frequencyText: UILabel!
    @IBAction func frequencySlider(_ sender: UISlider) {
        switch Int(sender.value){
        case 1:
            frequencyText.text = "Alle 2 Monate"
        case 2:
            frequencyText.text = "Monatlich"
        case 3:
            frequencyText.text = "Alle 2 Wochen"
        case 4:
            frequencyText.text = "Wöchentlich"
        default:
            frequencyText.text = "Wöchentlich"
        }
    
    }
    
    
    let datePicker = UIDatePicker()
    

    @IBOutlet weak var requestButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        makeDatePicker()
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    func makeDatePicker(){
    //datepicker after tutorial: youtube.com/watch?v=_ADJxJ7pjRk#t=426.928552063
        datePicker.datePickerMode = .dateAndTime
        
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target:nil,action: #selector (donePressed))
        // toolbar
        
        
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        toolbar.setItems([doneButton], animated: false)

        
        //connect datepicker with label
        datePickerText.inputAccessoryView = toolbar
        datePickerText.inputView = datePicker
        
    }
    
    func donePressed(){
        //format date
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .full
        dateFormatter.timeStyle = .short
        
        datePickerText.text = dateFormatter.string(from:datePicker.date)
        
        
        self.view.endEditing(true)
    }
    
    @IBAction func startRequest(_ sender: Any) {
        performRequest()

    }
    
    
    
    func performRequest(){
        
        let cityName = "Konstanz"
        let radius = 2000
        
        let urlStr =  "https://maps.googleapis.com/maps/api/place/textsearch/json?query=restaurants+in+\(cityName)&radius=\(radius)&key=AIzaSyC51kVvQ30YBdmhq4ivir2LhF65U50_6C4&sensor=true"
        guard let url = URL(string: urlStr) else {
            print("invalid url")
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { (data:Data?, response: URLResponse?, error: Error?) in
            
            if let error = error{
                print(error)
                return
            }
            
            if let response = response as? HTTPURLResponse{
                
                if response.statusCode >= 400{
                    print("Computer says NO: \(response.statusCode)")
                    return
                }
            }
            else {
                print("no response received")
                return
            }
            
            guard let data = data else {
                print("No data received")
                return
            }
            
            let json = JSON(data:data)
            print("Received JSON: %@", json.description)
            print(json["results"][0])
            
        }
        
        task.resume()
        
    }
    
    
}


