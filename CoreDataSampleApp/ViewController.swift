//
//  ViewController.swift
//  CoreDataSampleApp
//
//  Created by Apple-1 on 11/15/17.
//  Copyright © 2017 Apple-1. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,UIAlertViewDelegate{
    
    @IBOutlet var tblView: UITableView!
    
    var valueSentFromSecondViewController:String?
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var tasks : [Person] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getData()
        tblView.reloadData()
        
        //test()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    
    @IBAction func Add() {
        let alert = UIAlertView()
        alert.title = "Add Item"
        alert.message = "Enter the item content"
        alert.addButton(withTitle: "Cancel")
        alert.addButton(withTitle: "Ok")
        alert.alertViewStyle = .plainTextInput
        alert.delegate = self
        alert.show()
    }
    
    func alertView(_ alertView: UIAlertView, clickedButtonAt buttonIndex: Int){
        print("buttonIndex  ", buttonIndex)
        if buttonIndex != 1{
            return
        }
        let task = Person(context: context)
        task.name = alertView.textField(at: 0)?.text! 
        //Save the data to Core Data
        (UIApplication.shared.delegate as! AppDelegate).saveContext()
        //Re-Fetch
        getData()
        tblView.reloadData()
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasks.count
    }
    
    /*private func tableView(_ tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        cell.layer.transform = CATransform3DMakeScale(0.1,0.1,1)
        UIView.animate(withDuration: 0.25, animations: {
            cell.layer.transform = CATransform3DMakeScale(1,1,1)
        })
    }*/
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let task = tasks[indexPath.row]
        if let myName = task.name {
            cell.textLabel?.text = myName as? String
        }
        return cell
    }
    
    func getData(){
        do {
            tasks = try context.fetch(Person.fetchRequest())
        } catch{
            print("Failed in Fetch from Core Data")
        }
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let task = tasks[indexPath.row]
            context.delete(task)
            (UIApplication.shared.delegate as! AppDelegate).saveContext()
            
            do {
                tasks = try context.fetch(Person.fetchRequest())
            }
            catch {
                print("Fetching Failed")
            }
        }
        tblView.reloadData()
    }
    
}
