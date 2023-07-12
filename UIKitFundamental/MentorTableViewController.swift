//
//  MentorTableViewController.swift
//  UIKitFundamental
//
//  Created by Muhammad Irfan on 12/07/23.
//

import UIKit

class MentorTableViewController: UITableViewController {
    

    var mentors = [MentorData]()
    var selectedMentor: MentorData?
    let mentorDataManager = MentorDataManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchData()
    }
    
    func fetchData() {
        guard let results = try? mentorDataManager.fetchAllMentors()
        else {
            print("failed to fetch")
            return
        }
        mentors = results
        tableView.reloadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        fetchData()
    }

    
    @IBAction func addMentor(_ sender: Any) {
        
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return mentors.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "mentorCell", for: indexPath) as! MentorTableViewCell

        // Configure the cell...
        let mentor = mentors[indexPath.row]
        cell.cityLabel.text = mentor.city
        cell.nameLabel.text = mentor.name

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "editMentor", sender: self)
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        100
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "editMentor",
           let indexPath = tableView.indexPathForSelectedRow,
           let destination = segue.destination as? ViewController {
            destination.selectedMentor = mentors[indexPath.row]
           
        }
    }
}
