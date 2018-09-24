//
//  MovieListViewControllerTests.swift
//  MovieSelector
//
//  Created by Cagdas Timurlenk on 23.09.2018.
//  Copyright (c) 2018 CodeAndDreams. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

@testable import MovieSelector
import XCTest

class MovieListViewControllerTests: XCTestCase
{
  // MARK: Subject under test
  
  var sut: MovieListViewController!
  var window: UIWindow!
  
  // MARK: Test lifecycle
  
  override func setUp()
  {
    super.setUp()
    window = UIWindow()
    setupMovieListViewController()
  }
  
  override func tearDown()
  {
    window = nil
    super.tearDown()
  }
  
  // MARK: Test setup
  
  func setupMovieListViewController()
  {
    let bundle = Bundle.main
    let storyboard = UIStoryboard(name: "Main", bundle: bundle)
    sut = storyboard.instantiateViewController(withIdentifier: "MovieListViewController") as! MovieListViewController
  }
  
  func loadView()
  {
    window.addSubview(sut.view)
    RunLoop.current.run(until: Date())
  }
  
  // MARK: Test doubles
  
  class MovieListBusinessLogicSpy: MovieListBusinessLogic
  {
    var hasData = false
    var recievedFromServer = ""
    func getPopularMovieList(_ request: MovieList.Request) {
        MovieApi.getPopularMovieList(request: request,
                                     success:
            {
                [weak weakSelf = self] (response) in
                
                self.hasData =  (MovieList.Response(data: response).data.results?.count)! > 0
                if self.hasData && request.page == 1
                {
                    self.recievedFromServer = "yes"
                }
        })
    }
    func saveMovieToDatabase(movieViewModel: MovieList.ViewModel.MovieViewModel, withLike: Bool) {
        
    }
    
//
//    func doSomething(request: MovieList.Something.Request)
//    {
//      doSomethingCalled = true
//    }
  }
  
  // MARK: Tests
  
  func testShouldGetPopularMoviesWhenViewIsLoaded()
  {
    // Given
    let spy = MovieListBusinessLogicSpy()
    sut.interactor = spy
    
    // When
    loadView()
    let request = MovieList.Request(page: -1)
    
    sut.interactor?.getPopularMovieList(request)
    
    // Then
    XCTAssertTrue(spy.hasData, "no data found!s")
  }
    
  
//  func testDisplaySomething()
//  {
//    // Given
//    let viewModel = MovieList.Something.ViewModel()
//    
//    // When
//    loadView()
//    sut.displaySomething(viewModel: viewModel)
//    
//    // Then
//    //XCTAssertEqual(sut.nameTextField.text, "", "displaySomething(viewModel:) should update the name text field")
//  }
}
