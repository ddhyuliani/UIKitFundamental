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
    
    var selectedMentor: MentorData? = nil
    var paramEdit = 0
    let city = ["Bogor", "Surabaya", "Bandung", "Pamulang", "Cirebon", "Kupang"]
    
    
    override func viewDidLoad(){
        super.viewDidLoad()
        cityPicker.delegate = self
        cityPicker.dataSource = self
        
        if(selectedMentor != nil)
        {
            nameField.text = selectedMentor?.name
            originLabel.text = selectedMentor?.city
        }
        
        if paramEdit == 1 {
            editData()
        }
    }

    @IBAction func saveAction(_ sender: Any) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context: NSManagedObjectContext = appDelegate.persistentContainer.viewContext
        if(selectedMentor == nil)
        {
            let entity = NSEntityDescription.entity(forEntityName: "MentorData", in: context)
            let newNote = MentorData(entity: entity!, insertInto: context)
            newNote.id = Int32(truncating: mentor.count as NSNumber)
            newNote.name = nameField.text
            newNote.city = originLabel.text
            do
            {
                try context.save()
                mentor.append(newNote)
                navigationController?.popViewController(animated: true)
            }
            catch
            {
                print("context save error")
            }
        }
        else //edit
        {
            let request = NSFetchRequest<NSFetchRequestResult>(entityName: "MentorData")
            do {
                let results:NSArray = try context.fetch(request) as NSArray
                for result in results
                {
                    let note = result as! MentorData
                    if(note == selectedMentor)
                    {
                        note.name = nameField.text
                        note.city = originLabel.text
                        try context.save()
                        navigationController?.popViewController(animated: true)
                    }
                }
            }
            catch
            {
                print("Fetch Failed")
            }
        }
    }
    
    
    @IBAction func deleteAction(_ sender: Any) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context: NSManagedObjectContext = appDelegate.persistentContainer.viewContext
        
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "MentorData")
        do {
            let results:NSArray = try context.fetch(request) as NSArray
            for result in results
            {
                let note = result as! MentorData
                if(note == selectedMentor)
                {
                    note.deletedDate = Date()
                    try context.save()
                    navigationController?.popViewController(animated: true)
                }
            }
        }
        catch
        {
            print("Fetch Failed")
        }
    }
    
    func editData(){
        nameField.text = selectedMentor?.name
        originLabel.text = selectedMentor?.city
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

