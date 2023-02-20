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
    var pesel:UITextField!
    var name:UITextField!
    var surname:UITextField!
    var save:UIAlertAction!
    var alert:UIAlertController!
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
            self.alert = UIAlertController(title: "Edytuj osobę:", message: "",                                      preferredStyle: .alert)
            self.alert.addTextField(configurationHandler: { textField in
                textField.placeholder = "PESEL"
                textField.text = self.items?[indexPath.row].pesel ?? ""
            })
            
            self.alert.addTextField(configurationHandler: { textField in
                textField.placeholder = "Imię"
                textField.text = self.items?[indexPath.row].name ?? ""
            })
            self.alert.addTextField(configurationHandler: { textField in
                textField.placeholder = "Nazwisko"
                textField.text = self.items?[indexPath.row].surname ?? ""
            })

            self.pesel = self.alert.textFields?[0]
            self.name = self.alert.textFields?[1]
            self.surname = self.alert.textFields?[2]
            self.pesel.addTarget(self, action: #selector(self.checkData), for: UIControl.Event.editingChanged)
            self.name.addTarget(self, action: #selector(self.checkData), for: UIControl.Event.editingChanged)
            self.surname.addTarget(self, action: #selector(self.checkData), for: UIControl.Event.editingChanged)
            
            self.save = UIAlertAction(title: "Zapisz", style: .default, handler: { [weak alert = self.alert] (_) in
                var pesel = self.alert!.textFields![0].text
                let peselLenght = pesel?.count == 11
                
                
                
//                let newPerson = Persons(context: self.context)
//                newPerson.pesel = self.alert!.textFields![0].text
//                newPerson.name = self.alert!.textFields![1].text
//                newPerson.surname = self.alert!.textFields![2].text
               
                try! self.context.save()
                do{
                    self.items = try self.context.fetch(Persons.fetchRequest())
                    print("łotoott")
                }catch{
                    print("Error kurwa")
                }
                self.table.reloadData()
                
            })
            self.save.isEnabled = false
            self.alert.addAction(self.save)
            
            self.alert.addAction(UIAlertAction(title: "Anuluj", style: .default, handler: { [weak alert = self.alert] (_) in
                
                
            }))
                                         
            self.present(self.alert, animated: true) {
                // The alert was presented
            }
            
        }
        return UISwipeActionsConfiguration(actions: [action, action2])
    }
    
    @IBAction func addPersonButton(_ sender: Any) {
        
        
        
        
        // Create and configure the alert controller.
        alert = UIAlertController(title: "Dodaj osobę:", message: "",
                                      
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
        self.pesel = alert.textFields?[0]
        self.name = alert.textFields?[1]
        self.surname = alert.textFields?[2]
        pesel.addTarget(self, action: #selector(checkData), for: UIControl.Event.editingChanged)
        name.addTarget(self, action: #selector(checkData), for: UIControl.Event.editingChanged)
        surname.addTarget(self, action: #selector(checkData), for: UIControl.Event.editingChanged)
        
        self.save = UIAlertAction(title: "Zapisz", style: .default, handler: { [weak alert] (_) in
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
            
        })
        self.save.isEnabled = false
        alert.addAction(self.save)
        
        alert.addAction(UIAlertAction(title: "Anuluj", style: .default, handler: { [weak alert] (_) in
            
            
        }))
        
        self.present(alert, animated: true) {
            // The alert was presented
        }
        
    }
    @objc func checkData(){
        var peselStr:String = pesel.text ?? ""
        var peselArr:[String.SubSequence] = peselStr.split(separator: "")
        if(peselStr.count != 11 || name.text?.count ?? 0 < 1 || surname.text?.count ?? 0 < 1){
            save.isEnabled = false
        }else{
            var sum:Int = 0
            var arr :[Int] = [1,3,7,9,1,3,7,9,1,3]
            for i in 0...9{
                sum += (Int(peselArr[i]) ?? 0)*arr[i]%10
            }
            sum = sum % 10
            if(10 - sum == Int(peselArr[10])){
                save.isEnabled = true
            }
            
        }
        
        
        // właściwość0
        // np. dodanie danych
        
        
        
        /* //usuwanie
         let toDelete = self.items![0]
         self.context.delete(toDelete)
         */
        
        // a mozna w pełen blok try catch jak ponizej
        
        // fetch danych
        
    }
}

