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
    var selectedMentor: MentorData?
    
    var mentorDataManager = MentorDataManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        cityPickerView.delegate = self
        cityPickerView.dataSource = self
        
        if (selectedMentor != nil){
            nameTextField.text = selectedMentor?.name
            cityLabel.text = selectedMentor?.city
        } else {
            
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        saveMentor()
    }
    
    func saveMentor(){
        let name = nameTextField.text
        var city = cityLabel.text
        let newMentor = mentorDataManager.createMentor(withName: name, city: city)
        
        if cityLabel.text == "" {
            city = cities[0]
        }
        
        do {
            if let selectedMentor = selectedMentor {
                try mentorDataManager.updateMentor(selectedMentor, withName: name, city: city)
            } else {
                try mentorDataManager.saveMentor(newMentor)
            }
            
        } catch {
            print("save data error")
        }
        
    }
    
    @IBAction func deleteMentor(_ sender: Any) {
        if let selectedMentor = selectedMentor {
            do {
                try mentorDataManager.deleteMentor(selectedMentor)
                navigationController?.popViewController(animated: true)
            } catch {
                print("error nich")
            }
        }
        if mentorView.backgroundColor != .red {
            mentorView.backgroundColor = .red
        } else {
            mentorView.backgroundColor = .white
        }
    }
    @IBAction func saveAction(_ sender: Any) {
        navigationController?.popViewController(animated: true)
//        saveMentor()
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


