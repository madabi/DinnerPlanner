//
//  SecondViewController.swift
//  DinnerPlanner
//
//  Created by Marco Bibrich on 18.06.17.
//  Copyright © 2017 DinnerPlanner. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController {

    
    @IBOutlet weak var datePickerText: UITextField!
    @IBOutlet weak var locationText: UITextField!
    @IBOutlet weak var groupNameText: UITextField!
    
    
    let datePicker = UIDatePicker()
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        makeDatePicker()
        
        
        
        //locationText.inputAccessoryView = createToolbarWithDoneButton()
        //groupNameText.inputAccessoryView = createToolbarWithDoneButton()
        
        
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
}


