//
//  ApiManager.swift
//  MoviesCD
//
//  Created by admin on 16/12/24.
//

import Foundation

import Alamofire

class ApiManager{
    //    let urlstr="https://www.freetestapi.com/api/v1/movies?limit=5"
    //
    //
    //
    //    func fetchmovies(completionHandler: @escaping(Result<[MoviesModel],Error>)-> Void) {
    //
    //        AF.request(urlstr).responseDecodable(of: [MoviesModel].self){response in
    //            switch response.result{
    //
    //            case.success(let data):
    //                completionHandler(.success(data))
    //
    //            case.failure(let error):
    //                completionHandler(.failure(error))
    //
    //
    //
    //            }
    //
    //        }
    //    }
    
    
    
    let urlstr="https://dummyapi.online/api/movies"
    
    
    
    func fetchmovies(completionHandler: @escaping(Result<[MovieModel],Error>)-> Void) {
        
        AF.request(urlstr).responseDecodable(of: [MovieModel].self){response in
            switch response.result{
                
            case.success(let data):
                completionHandler(.success(data))
                
            case.failure(let error):
                completionHandler(.failure(error))
                
                
                
            }
            
        }
        
    }
}
