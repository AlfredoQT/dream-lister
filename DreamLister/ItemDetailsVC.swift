//
//  ItemDetailsVC.swift
//  DreamLister
//
//  Created by Alfredo Quintero Tlacuilo on 1/29/17.
//  Copyright © 2017 Alfredo Quintero Tlacuilo. All rights reserved.
//

import UIKit
import CoreData

class ItemDetailsVC: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var deleteBtn: UIBarButtonItem!
    @IBOutlet weak var thumbImage: UIImageView!
    @IBOutlet weak var detailsField: CustomTextField!
    @IBOutlet weak var priceField: CustomTextField!
    @IBOutlet weak var titleField: CustomTextField!
    @IBOutlet weak var storePicker: UIPickerView!
    
    var stores = [Store]()
    
    var itemToEdit: Item?
    
    var imagePicker: UIImagePickerController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let topItem = self.navigationController?.navigationBar.topItem {
            topItem.backBarButtonItem = UIBarButtonItem(title: "", style: UIBarButtonItemStyle.plain, target: nil, action: nil)
        }
        storePicker.delegate = self
        storePicker.dataSource = self
        
        imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        
        getStores()
        
        if itemToEdit != nil{
            loadItemData()
            self.title = "Edit Item"
            deleteBtn.isEnabled = true
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        let store = stores[row]
        return store.name
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return stores.count
    }
    
    //How many columns
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func getStores(){
        //Fetch from database
        let fetchRequest: NSFetchRequest<Store> = Store.fetchRequest()
        
        do{
            //Set the stores array to the result that we get back when fetching
            self.stores = try context.fetch(fetchRequest)
            //Reloads components inside of store picker
            self.storePicker.reloadAllComponents()
        }
        catch{
            let error = error as NSError
            print("\(error)")
        }
    }
    
    @IBAction func saveBtnClicked(_ sender: Any) {
        var item: Item!
        
        let picture = Image(context: context)
        
        picture.image = thumbImage.image
        
        //If there is no item to edit (the user clicked the plus button), create a new item in context
        if itemToEdit == nil{
            item = Item(context: context)
        }
        
        //If MainVC passed itemToEdit (the user clicked on an item), set item to itemToEdit to override it
        //CoreData is smart enough to know that it should update it
        else{
            item = itemToEdit
        }
        
        item.toImage = picture
        
        if let title = titleField.text {
            item.title = title
        }
        
        if let price = priceField.text {
            item.price = (price as NSString).doubleValue
        }
        
        if let details = detailsField.text {
            item.details = details
        }
        
        item.toStore = stores[storePicker.selectedRow(inComponent: 0 )]
        
        ad.saveContext()
        _ = navigationController?.popViewController(animated: true)
    }
    
    func loadItemData(){
        if let item = itemToEdit {
            titleField.text = item.title
            priceField.text = "\(item.price)"
            detailsField.text = item.details
            thumbImage.image = item.toImage?.image as? UIImage
            if let store = item.toStore {
                var index = 0
                //Check for every store name until we find the one that is the same as the item to edit
                repeat {
                    let s = stores[index]
                    if s.name == store.name {
                        storePicker.selectRow(index, inComponent: 0, animated: false)
                        break
                    }
                    index += 1
                }while index < stores.count
            }
        }
    }
    
    @IBAction func deleteBtnPressed(_ sender: Any) {
        if itemToEdit != nil {
            context.delete(itemToEdit!)
            ad.saveContext()
        }
        _ = navigationController?.popViewController(animated: true)
    }
    
    
    @IBAction func addImage(_ sender: Any) {
        present(imagePicker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
            thumbImage.image = image
        }
        imagePicker.dismiss(animated: true, completion: nil)
    }
    
}
