//
//  ViewController.swift
//  UIKitFundamental
//
//  Created by Dini on 11/07/23.
//

import UIKit
import CoreData


class ViewController: UIViewController {
    
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var originLabel: UILabel!
    @IBOutlet weak var cityPicker: UIPickerView!
    @IBOutlet weak var deleteButton: UIButton!
    
    var selectedMentor: MentorData? = nil
    let city = ["Bogor", "Surabaya", "Bandung", "Pamulang", "Cirebon", "Kupang"]
    
    var onSave: ((MentorData) -> Void)?
    var onDelete: ((MentorData) -> Void)?
    
    let mentorDataManager = MentorDataManager()
    
    override func viewDidLoad(){
        super.viewDidLoad()
        cityPicker.delegate = self
        cityPicker.dataSource = self
        
        if(selectedMentor != nil)
        {
            nameField.text = selectedMentor?.name
            originLabel.text = selectedMentor?.city
        } else {
            deleteButton.isHidden = true
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        saveMentorData()
    }
    
    private func saveMentorData() {
        guard let name = nameField.text,
              let city = originLabel.text
        else {
            print("Invalid input")
            return
        }
        
        do {
            if let selectedMentor = selectedMentor { // Update existing mentor
                try mentorDataManager.updateMentor(selectedMentor, withName: name, city: city)
            } else { // Create new mentor
                let newMentor = mentorDataManager.createMentor(withName: name, city: city)
                try mentorDataManager.saveMentor(newMentor)
                onSave?(newMentor)
            }
        } catch {
            print("Context save error")
        }
    }
    
    @IBAction func saveAction(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    
    @IBAction func deleteAction(_ sender: Any) {
        if let selectedMentor = selectedMentor {
            do {
                try mentorDataManager.deleteMentor(selectedMentor)
                onDelete?(selectedMentor)
                navigationController?.popViewController(animated: true)
            } catch {
                print("Delete error")
            }
        }
    }
    
}

extension ViewController: UIPickerViewDelegate{
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return city[row]
    }
}

extension ViewController: UIPickerViewDataSource{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return city.count
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        originLabel.text = city[row]
    }
    
    
}

