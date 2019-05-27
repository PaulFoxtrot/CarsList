//
//  CarsViewController.swift
//  CarsList
//
//  Created by foxtrot on 26/05/2019.
//  Copyright © 2019 foxtrot. All rights reserved.
//

import UIKit
import CoreData

class CarsViewController: UIViewController, UITableViewDelegate, NSFetchedResultsControllerDelegate {
    
    var cars: [Car] = []
    
    // main tableview with the items list
    @IBOutlet weak var carsTableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let fetchRequest: NSFetchRequest<Car> = Car.fetchRequest()
        do {
            let fetchCar = try PersistenceService.context.fetch(fetchRequest)
            self.cars = fetchCar
            self.carsTableView.reloadData()
        } catch {}
    }
    
    
    
    // action to add new object
    @IBAction func plusButtonTapped(_ sender: Any) {
        let alert = UIAlertController(title: "New Car", message: nil, preferredStyle: .alert)
        alert.addTextField {(textField) in
            textField.placeholder = "Name"
        }
        alert.addTextField {(textField) in
            textField.placeholder = "Model"
        }
        alert.addTextField {(textField) in
            textField.placeholder = "Year"
            textField.keyboardType = .numberPad
        }
        alert.addTextField {(textField) in
            textField.placeholder = "Manufacturer"
        }
        alert.addTextField {(textField) in
            textField.placeholder = "Class"
        }
        alert.addTextField {(textField) in
            textField.placeholder = "Type"
        }
        // alert text fields
        let action = UIAlertAction(title: "Add new car", style: .default) { (_) in
            let name = alert.textFields![0].text
            let model = alert.textFields![1].text
            let year = alert.textFields![2].text
            let manufacturer = alert.textFields![3].text
            let classOfCar = alert.textFields![4].text
            let typeOfCar = alert.textFields![5].text
            let car = Car(context: PersistenceService.context)
            car.name = name
            car.model = model
            car.year = Int16(year!)!
            car.manufacturer = manufacturer
            car.classOfCar = classOfCar
            car.typeOfCar = typeOfCar
            
            // saving in core data
            PersistenceService.saveContext()
            self.cars.append(car)
            self.carsTableView.reloadData()
        }
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
        
        // create Cancel button
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (_) in
        }
        alert.addAction(cancelAction)
    }
    
    // deleting object
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        guard editingStyle == .delete else { return }
        cars.remove(at: indexPath.row)
        carsTableView.deleteRows(at: [indexPath], with: .automatic)
        
        
        PersistenceService.saveContext()
    }
}


extension CarsViewController: UITableViewDataSource {
    func numberOfSections(in carstableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ carstableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cars.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: nil)
        cell.textLabel?.text = cars[indexPath.row].name
        cell.detailTextLabel?.text = String("\(cars[indexPath.row].model!), \(String(cars[indexPath.row].year)), \(cars[indexPath.row].manufacturer!), \(cars[indexPath.row].classOfCar!), \(cars[indexPath.row].typeOfCar!)")
        return cell
    }
}







