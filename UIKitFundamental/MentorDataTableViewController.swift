//
//  MentorDataTableViewController.swift
//  UIKitFundamental
//
//  Created by Dini on 11/07/23.
//

import UIKit
import CoreData

var mentor = [MentorData]()


class MentorDataTableViewController: UITableViewController {
    var selectedMentor: MentorData?
    var firstLoad = true
    var selectedIndex: Int = 0
    
    func nonDeletedMentor() -> [MentorData] {
        var noDeleteMentorList = [MentorData]()
        for data in mentor
        {
            if(data.deletedDate == nil)
            {
                noDeleteMentorList.append(data)
            }
        }
        return noDeleteMentorList
    }
    
    override func viewDidLoad() {
        if(firstLoad)
        {
            firstLoad = false
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            let context: NSManagedObjectContext = appDelegate.persistentContainer.viewContext
            let request = NSFetchRequest<NSFetchRequestResult>(entityName: "MentorData")
            do {
                let results:NSArray = try context.fetch(request) as NSArray
                for result in results
                {
                    let note = result as! MentorData
                    mentor.append(note)
                }
            }
            catch
            {
                print("Fetch Failed")
            }
        }
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let mentorCell = tableView.dequeueReusableCell(withIdentifier: "mentorCell", for: indexPath) as! MentorTableViewCell
        
        let thisData: MentorData!
        thisData = nonDeletedMentor()[indexPath.row]

        mentorCell.nameLabel.text = thisData.name
        mentorCell.originCity.text = thisData.city ?? "no city"
        return mentorCell
        
    }
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return nonDeletedMentor().count
    }
    
    override func viewDidAppear(_ animated: Bool) {
        tableView.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "editMentor", sender: self)
//        let VC = storyboard?.instantiateViewController(withIdentifier: "detailMentor") as! ViewController
//        VC.selectedMentor = mentor[indexPath.row]
//        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "editMentor")
        {
            let indexPath = tableView.indexPathForSelectedRow!
//            tableView.indexPathForSelectedRow
            let noteDetail = segue.destination as? ViewController

            let selectedNote : MentorData!
            selectedNote = nonDeletedMentor()[indexPath.row]
            noteDetail!.selectedMentor = selectedMentor
            noteDetail?.paramEdit = 1

            tableView.deselectRow(at: indexPath, animated: true)
        }
    }
}
