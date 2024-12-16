//
//  ViewController.swift
//  MoviesCD
//
//  Created by admin on 16/12/24.
//

import UIKit
import CoreData

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate{
    
//    var moviesarr:[MoviesModel]=[]
    var moviesarr1:[MovieModel]=[]
    var moviesarr2:[MovieModel]=[]
    

    @IBOutlet weak var tablevc2: UITableView!
    
    @IBOutlet weak var tablevc1: UITableView!
   
    @IBOutlet weak var tbsegment: UISegmentedControl!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        readcd()
        tablevc2.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        callMoviesApi()
        reloadUi()
        
        // Do any additional setup after loading the view.
    }
    
    func reloadUi(){
        DispatchQueue.main.async {
            if self.tbsegment.selectedSegmentIndex==0{
                self.tablevc1.isHidden=false
                self.tablevc2.isHidden=true
                self.tablevc1.reloadData()
            }
            else if self.tbsegment.selectedSegmentIndex==1
            {
                self.tablevc2.isHidden=false
                self.tablevc1.isHidden=true
                self.readcd()
                self.tablevc2.reloadData()
            }
        }
    }

    @IBAction func changesegment(_ sender: Any) {
        print("current segment\(tbsegment.selectedSegmentIndex)")
        reloadUi()
    }
    
    @IBAction func newbtn(_ sender: Any) {
        performSegue(withIdentifier: "GoToForm", sender: self)
    }
    
    func callMoviesApi(){
        ApiManager().fetchmovies{ result in
            switch result {
                
            case.success(let data):
                self.moviesarr1.append(contentsOf: data)
                print(self.moviesarr1)
                self.tablevc1.reloadData()
                
                
            case.failure(let failure):
                debugPrint("something went wrong in calling API\(failure)")
                
            }
        }
    }
    
    
    func setup(){
        tablevc1.dataSource=self
        tablevc1.delegate=self
        tablevc1.register(UINib(nibName: "MovieCell", bundle: nil), forCellReuseIdentifier: "MovieCell")
        
        tablevc2.dataSource=self
        tablevc2.delegate=self
        tablevc2.register(UINib(nibName: "MovieCell", bundle: nil), forCellReuseIdentifier: "MovieCell")
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tbsegment.selectedSegmentIndex == 0 ? moviesarr1.count : moviesarr2.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "MovieCell", for: indexPath) as? MovieCell else{
            return UITableViewCell()
        }
        let currseg = tbsegment.selectedSegmentIndex
        
        switch currseg{
        case 0:
            guard indexPath.row < moviesarr1.count
            else {
                print("Index out of bounds for JokeArr")
                return cell
            }
            
            cell.lbl1.text = String(moviesarr1[indexPath.row].id)
            cell.lbl2.text=moviesarr1[indexPath.row].movie
            cell.lbl3.text=moviesarr1[indexPath.row].image
            cell.lbl4.text=moviesarr1[indexPath.row].imdb_url
            cell.lbl5.text=String(moviesarr1[indexPath.row].rating)
            
        case 1:
            guard indexPath.row < moviesarr2.count
            else {
                print("Index out of bounds for JokeArr")
                return cell
            }
            
            cell.lbl1.text = String(moviesarr2[indexPath.row].id)
            cell.lbl2.text=moviesarr2[indexPath.row].movie
            cell.lbl3.text=moviesarr2[indexPath.row].image
            cell.lbl4.text=moviesarr2[indexPath.row].imdb_url
            cell.lbl5.text=String(moviesarr2[indexPath.row].rating)
            
        default:
            break
        }

        return cell
        
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 250
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let movie = moviesarr1[indexPath.row]
        FormVC().addtocd(movieobject: MovieModel(id: movie.id, movie: movie.movie, rating: movie.rating, image: movie.image, imdb_url: movie.imdb_url))
    }
    
    
    func readcd(){
        
        guard let delegate=UIApplication.shared.delegate as? AppDelegate else {return}

        let managecontext=delegate.persistentContainer.viewContext
        
        let fetres=NSFetchRequest<NSFetchRequestResult>(entityName: "Movie")
        
        do {
            let res = try managecontext.fetch(fetres)
            debugPrint("fetch from cd sucessfully")
            moviesarr2=[]
            
            for data in res as! [NSManagedObject]{
                
                let mid=data.value(forKey: "id") as! Int32
                let mmovie=data.value(forKey: "movie") as! String
                let mrating=data.value(forKey: "rating") as! Double
                let mimage=data.value(forKey: "image") as! String
                let mimdb_url=data.value(forKey: "imdb_url") as! String
                moviesarr2.append(MovieModel(id: Int(mid), movie: mmovie, rating: mrating, image: mimage, imdb_url: mimdb_url))
                
            }
            
            
        } catch let err as NSError {
            debugPrint("could not save to CoreData. Error: \(err)")
        }
    
    }
    
    
    
}

