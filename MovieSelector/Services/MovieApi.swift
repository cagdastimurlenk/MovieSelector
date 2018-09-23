//
//  MovieApi.swift
//  MovieSelector
//
//  Created by Cagdas Timurlenk on 21.09.2018.
//  Copyright © 2018 CodeAndDreams. All rights reserved.
//

import Foundation
import Moya
import ObjectMapper


class MovieApi{
    
    static func getMovieDetail(request: MovieDetail.Request,
                                    success successCallback: ((MovieDetailResponseDTO) -> Void)?,
                                    error errorCallback: ((ErrorDTO) -> Void)? = nil,
                                    failure failureCallback: (() -> Void)? = nil) {
        
        NetworkAdapter.request(target: MultiTarget(MovieApiTarget.getMovieDetail(request: request)), success: { (response) in
            do
            {
                let json = try JSONSerialization.jsonObject(with: response.data(using: .utf8)!, options: JSONSerialization.ReadingOptions.mutableContainers)
                if let movieListResponse = Mapper<MovieDetailResponseDTO>().map(JSONObject: json)
                {
                    movieListResponse.results?.reverse()
                    successCallback?(movieListResponse)
                }
                else
                {
                    failureCallback?()
                }
            }
            catch
            {
                failureCallback!()
            }
            
        }, error: { (error) in
           
        }) { (error) in
            failureCallback?()
        }
    }
    
    static func getPopularMovieListMock(request: MovieList.Request,
                                    success successCallback: ((MovieListResponseDTO) -> Void)?,
                                    error errorCallback: ((ErrorDTO) -> Void)? = nil,
                                    failure failureCallback: (() -> Void)? = nil) {
        
                 let jsonURL = Bundle.main.url(forResource: "MovieData", withExtension: "json")!
                do {
                    let movieListResponseContent = try Data(contentsOf: jsonURL)
                    let json = try JSONSerialization.jsonObject(with: movieListResponseContent, options: JSONSerialization.ReadingOptions.mutableContainers)
        
                    if let movieListResponse = Mapper<MovieListResponseDTO>().map(JSONObject: json)
                    {
                        successCallback?(movieListResponse)
                    }
                    else
                    {
                        failureCallback?()
                    }
                   //bunu MovieApiDataFromFile a tasiyacaz..
                }
                catch {
                    failureCallback?()
                }
    }
    
    static func getPopularMovieList(request: MovieList.Request,
                                   success successCallback: ((MovieListResponseDTO) -> Void)?,
                                   error errorCallback: ((ErrorDTO) -> Void)? = nil,
                                   failure failureCallback: (() -> Void)? = nil) {
        
        if request.page == -1
        {
            getPopularMovieListMock(request:request, success: successCallback , error: errorCallback, failure:failureCallback)
            return
        }
        
        NetworkAdapter.request(target: MultiTarget(MovieApiTarget.getPopularMovieList(request: request)), success: { (response) in
            do
            {
                let json = try JSONSerialization.jsonObject(with: response.data(using: .utf8)!, options: JSONSerialization.ReadingOptions.mutableContainers)
                if let movieListResponse = Mapper<MovieListResponseDTO>().map(JSONObject: json)
                {
                    movieListResponse.results?.reverse()
                    successCallback?(movieListResponse)
                }
                else
                {
                    failureCallback?()
                }
            }
            catch
            {
                failureCallback!()
            }
            
        }, error: { (error) in
    
        }) { (error) in
            failureCallback?()
        }
    }
    
}
