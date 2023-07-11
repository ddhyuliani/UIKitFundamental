//
//  MentorDataTableViewController.swift
//  UIKitFundamental
//
//  Created by Dini on 11/07/23.
//

import UIKit
import CoreData


class MentorDataTableViewController: UITableViewController {
    var selectedMentor: MentorData?
    private var mentors = [MentorData]()
    
    let mentorDataManager = MentorDataManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchData()
    }
    
    private func fetchData() {
        DispatchQueue.global(qos: .background).async {
            guard let results = try? self.mentorDataManager.fetchAllMentors() else {
                print("Failed to fetch data")
                return
            }
            self.mentors = results
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let mentorCell = tableView.dequeueReusableCell(withIdentifier: CellIdentifier.mentorCell, for: indexPath) as! MentorTableViewCell
        let mentor = mentors[indexPath.row]
        mentorCell.nameLabel.text = mentor.name
        mentorCell.originCity.text = mentor.city ?? "no city"
        
        return mentorCell
        
    }
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return mentors.count
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        fetchData()
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: SegueIdentifier.editMentor, sender: self)
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == SegueIdentifier.editMentor,
           let indexPath = tableView.indexPathForSelectedRow,
           let noteDetail = segue.destination as? ViewController {
            noteDetail.selectedMentor = mentors[indexPath.row]
            tableView.deselectRow(at: indexPath, animated: true)
        }
    }
}
