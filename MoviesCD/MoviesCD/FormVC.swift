//
//  FormVC.swift
//  MoviesCD
//
//  Created by admin on 16/12/24.
//

import UIKit
import CoreData

class FormVC: UIViewController {
    @IBOutlet weak var txt4: UITextField!
    
    @IBOutlet weak var txt5: UITextField!
    @IBOutlet weak var txt3: UITextField!
    @IBOutlet weak var txt2: UITextField!
    @IBOutlet weak var txt1: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func addbtn(_ sender: Any) {
        
        let mid = Int(txt1.text!)!
        let mmovie=txt2.text!
        let mimage=txt3.text!
        let mrating=Double(txt4.text!)!
        let mimdb_url=txt5.text!
        
        let newmovie = MovieModel(id: mid, movie: mmovie, rating:mrating, image: mimage, imdb_url: mimdb_url)
        addtocd(movieobject: newmovie)
    }
    
    
    
    func addtocd(movieobject:MovieModel){
        
        guard let delegate=UIApplication.shared.delegate as? AppDelegate
        else {return}
        
        let managecontext = delegate.persistentContainer.viewContext
        
        guard let movieEntity=NSEntityDescription.entity(forEntityName: "Movie", in: managecontext)
        else{return}
        
        let movie=NSManagedObject(entity: movieEntity, insertInto: managecontext)
        movie.setValue(movieobject.id, forKey: "id")
        movie.setValue(movieobject.movie, forKey: "movie")
        movie.setValue(movieobject.image, forKey: "image")
        movie.setValue(movieobject.rating, forKey: "rating")
        movie.setValue(movieobject.imdb_url, forKey: "imdb_url")
                
        
        do {
            try managecontext.save()
            debugPrint("Core data saved")
        } catch let err as NSError {
            debugPrint("could not save to CoreData. Error: \(err)")
        }
        
    }

}
