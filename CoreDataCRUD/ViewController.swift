//
//  ViewController.swift
//  CoreDataCRUD
//
//  Created by Filip Rutkowski on 25/01/2023.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    
    @IBOutlet weak var table: UITableView!
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3;
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1;
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = table.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! TableDataTableViewCell;
//        cell.pesel.text = "aaa"
//        cell.name.text = "name"
//        cell.surname.text = "surname"
        return cell;
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


    @IBAction func addPersonButton(_ sender: Any) {
       
        let defaultAction = UIAlertAction(title: "Zapisz",
                                          style: .default) { (action) in
            // Respond to user selection of the action.
           }
           let cancelAction = UIAlertAction(title: "Anuluj",
                                style: .cancel) { (action) in
            // Respond to user selection of the action.
           }
           
           // Create and configure the alert controller.
        let alert = UIAlertController(title: "Dodaj osobę:", message: "",
               
                 preferredStyle: .alert)
            alert.addTextField(configurationHandler: { textField in
                textField.placeholder = "PESEL"
                })
            alert.addTextField(configurationHandler: { textField in
                textField.placeholder = "Imie"
                })
            alert.addTextField(configurationHandler: { textField in
                textField.placeholder = "Nazwisko"
                })
            alert.addAction(defaultAction)
            alert.addAction(cancelAction)
                
           self.present(alert, animated: true) {
              // The alert was presented
           }
    }
}

