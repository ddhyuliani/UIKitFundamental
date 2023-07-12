//
//  ViewController.swift
//  UIKitFundamental
//
//  Created by Dini on 11/07/23.
//

import UIKit


class ViewController: UIViewController {
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet var mentorView: UIView!
    @IBOutlet weak var cityPickerView: UIPickerView!
    @IBOutlet weak var nameTextField: UITextField!
    
    let cities = ["Bandung", "Bogor", "Jakarta", "Surabaya"]
    
    var mentorDataManager = MentorDataManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        cityPickerView.delegate = self
        cityPickerView.dataSource = self
    }
    
    func saveMentor(){
        let name = nameTextField.text
        let city = cityLabel.text
        let newMentor = mentorDataManager.createMentor(withName: name, city: city)
        
        do {
            try mentorDataManager.saveMentor(newMentor)
        } catch {
            print("save data error")
        }
    }
    
    @IBAction func deleteMentor(_ sender: Any) {
        if mentorView.backgroundColor != .red {
            mentorView.backgroundColor = .red
        } else {
            mentorView.backgroundColor = .white
        }
        
    }
    @IBAction func saveAction(_ sender: Any) {
        saveMentor()
    }
}

extension ViewController: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        cities[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        cityLabel.text = cities[row]
    }
}

extension ViewController: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        cities.count
    }
}


