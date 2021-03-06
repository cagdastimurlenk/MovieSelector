//
//  MovieListInteractorTests.swift
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

class MovieListInteractorTests: XCTestCase
{
  // MARK: Subject under test
  
  var sut: MovieListInteractor!
  
  // MARK: Test lifecycle
  
  override func setUp()
  {
    super.setUp()
    setupMovieListInteractor()
  }
  
  override func tearDown()
  {
    super.tearDown()
  }
  
  // MARK: Test setup
  
  func setupMovieListInteractor()
  {
    sut = MovieListInteractor()
  }
  
  // MARK: Test doubles
  
  class MovieListPresentationLogicSpy: MovieListPresentationLogic
  {
    var presentSomethingCalled = false
    
    func presentMovieList(_ response: MovieList.Response) {
        
    }
//    func presentSomething(response: MovieList.Something.Response)
//    {
//      presentSomethingCalled = true
//    }
  }
  
  // MARK: Tests
  
  func testDoSomething()
  {
    // Given
//    let spy = MovieListPresentationLogicSpy()
//    sut.presenter = spy
//    let request = MovieList.Something.Request()
//    
//    // When
//    sut.doSomething(request: request)
//    
//    // Then
//    XCTAssertTrue(spy.presentSomethingCalled, "doSomething(request:) should ask the presenter to format the result")
  }
}
