//
//  PhotosViewController.swift
//  Photos
//
//  Created by Ryan Rottmann on 3/15/19.
//  Copyright © 2019 Ryan Rottmann. All rights reserved.
//

import UIKit
import CoreData

class PhotosViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {

    @IBOutlet weak var myImageView: UIImageView!
    
    @IBAction func camera(_ sender: Any) {
        let image = UIImagePickerController()
        image.delegate = self
        image.sourceType = UIImagePickerController.SourceType.camera
        image.allowsEditing = false
        self.present(image, animated: true){
            // after it is complete
            
        }
    }
    @IBAction func importImage(_ sender: Any) {
        let image = UIImagePickerController()
        image.delegate = self
        image.sourceType = UIImagePickerController.SourceType.photoLibrary
        image.allowsEditing = false
        self.present(image, animated: true){
            // after it is complete
            
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
       
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            myImageView.image = image
            saveToCoreData(imageToSave: image)
        }
        else {
            print("image not loaded correctly")
        }
        self.dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        pullFromCoreData()
    }
    func saveToCoreData(imageToSave: UIImage){
        if let image = Entity(image: imageToSave){
                let managedContext = image.managedObjectContext
            do {
                try managedContext?.save()
            } catch{
                print("photo did not save")
            }
        }
        
    }
    func pullFromCoreData(){
        if let appDelegate = UIApplication.shared.delegate as? AppDelegate {
            let managedContext = appDelegate.persistentContainer.viewContext
            let fetchRequest: NSFetchRequest<Entity> = Entity.fetchRequest()
            do{
                myImageView.image = try managedContext.fetch(fetchRequest).first?.image
            
            }
            catch{
                print("Did not load image")
            }
        }
        
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
