//
//  ViewController.swift
//  CoreDataCRUD
//
//  Created by Filip Rutkowski on 25/01/2023.
//
import CoreData
import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
     
    
    @IBOutlet weak var table: UITableView!
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext   // właściwość
    var items:[Persons]?
    override func viewDidLoad() {
        super.viewDidLoad()
        table.delegate = self
        table.dataSource = self
      
        do{
            self.items = try self.context.fetch(Persons.fetchRequest())
            print("łotoott")
        }catch{
            print("Error kurwa")
        }
        // Do any additional setup after loading the view.
    }
    var tab = ["a","b","c"];
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items?.count ?? 0;
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1;
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = table.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! TableDataTableViewCell;
        cell.pesel.text = items?[indexPath.row].pesel ?? ""
        cell.name.text = items?[indexPath.row].name ?? ""
        cell.surname.text = items?[indexPath.row].surname ?? ""
        return cell;
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
            let action = UIContextualAction(style: .destructive, title: "Delete") {(action, view, completionHandler) in
                let toDelete = self.items![indexPath.row]
                self.context.delete(toDelete)
                
                try! self.context.save()
                do{
                    self.items = try self.context.fetch(Persons.fetchRequest())
                    print("łotoott")
                }catch{
                    print("Error kurwa")
                }
                self.table.reloadData()
               
            }
        let action2 = UIContextualAction(style: .normal, title: "Edit") {(action2, view, completionHandler) in
            print("edit")

        }
            return UISwipeActionsConfiguration(actions: [action, action2])
        }

    @IBAction func addPersonButton(_ sender: Any) {
       
    
           
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
        let defaultAction = UIAlertAction(title: "Zapisz",
                                          style: .default) { (action) in
            
           
            // Respond to user selection of the action.
            try! self.context.save()
           }
           let cancelAction = UIAlertAction(title: "Anuluj",
                                style: .cancel) { (action) in
            // Respond to user selection of the action.
           }
        
        alert.addAction(UIAlertAction(title: "Zapisz", style: .default, handler: { [weak alert] (_) in
            var pesel = alert!.textFields![0].text
            let peselLenght = pesel?.count == 11
            
            
            
            let newPerson = Persons(context: self.context)
            newPerson.pesel = alert!.textFields![0].text
            newPerson.name = alert!.textFields![1].text
            newPerson.surname = alert!.textFields![2].text
            
            try! self.context.save()
            do{
                self.items = try self.context.fetch(Persons.fetchRequest())
                print("łotoott")
            }catch{
                print("Error kurwa")
            }
            self.table.reloadData()
            
        }))
        
        alert.addAction(UIAlertAction(title: "Anuluj", style: .default, handler: { [weak alert] (_) in
   
       
            
        }))
                
           self.present(alert, animated: true) {
              // The alert was presented
           }
    }
    // właściwość
   
    // np. dodanie danych
 


    /* //usuwanie
        let toDelete = self.items![0]
        self.context.delete(toDelete)
    */

// a mozna w pełen blok try catch jak ponizej

    // fetch danych
    
}

