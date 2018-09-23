//
//  MovieListViewController.swift
//  MovieSelector
//
//  Created by Cagdas Timurlenk on 20.09.2018.
//  Copyright © 2018 CodeAndDreams. All rights reserved.
//

import UIKit

protocol MovieListDisplayLogic: class {
    func displayMovieList(_ viewModel: MovieList.ViewModel)
}

class MovieListViewController: UIViewController,MovieListDisplayLogic,MovieRouter {
    
  
    @IBOutlet weak var txtOverview: UITextView!
    @IBOutlet weak var collectionView: UICollectionView!
    
    // MARK: - Properties
    
    var currentPage = 1
    static let identifier = "MovieListViewController"
    var interactor: MovieListBusinessLogic?
    
    var moviesResponseModel: MovieList.ViewModel.MovieResponseViewModel?{
        didSet{
            updateUI()
        }
    }
    
    // MARK: - Initialization
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?){
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder){
        super.init(coder: aDecoder)
        setup()
    }
    
    func setup(){
        let viewController = self
        let interactor = MovieListInteractor()
        let presenter = MovieListPresenter()
        
        viewController.interactor = interactor
        interactor.presenter = presenter
        presenter.viewController = viewController
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Movie Selector"
        setupCollectionView()
        fetchPopularMovies()
        // Do any additional setup after loading the view.
    }
    
    func setupCollectionView()
    {
        self.collectionView.register(MovieCollectionViewCell.self, forCellWithReuseIdentifier: Constants.Indentifier.movieCollectionViewCell)
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        if let collectionLayout = self.collectionView.collectionViewLayout as? MovieStackLayout
        {
            collectionLayout.delegate = self
        }
    }

    func fetchPopularMovies()
    {
        //MARK to add.also store what page you are in the userdfaults or realm, then chek if coming movies already swiped left or right so dont show them
        let request = MovieList.Request(page: currentPage)
        interactor?.getPopularMovieList(request)
        //buradan devam// request de API KEy ve diger zimbbirtilari alacak skeilde duzeltilmeli...
    }
    
    func displayMovieList(_ viewModel: MovieList.ViewModel) {
        
        currentPage = viewModel.movieView.page ?? 0
        
        moviesResponseModel = viewModel.movieView
        
        //update collection View.
    }
    
    func updateUI()
    {
        self.collectionView.reloadData()
    }
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

extension MovieListViewController : UICollectionViewDataSource,UICollectionViewDelegateFlowLayout
{
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let movieModels = moviesResponseModel?.result else { return 0 }
        return movieModels.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.Indentifier.movieCollectionViewCell, for: indexPath) as? MovieCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        cell.movieViewModel = self.moviesResponseModel?.result?[indexPath.row]
        txtOverview.text = cell.movieViewModel?.overview
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
       if let movie = moviesResponseModel?.result?[indexPath.row]
       {
        showSelectedMovie(movie)
        }
        
    }
}

extension MovieListViewController :  MovieStackLayoutDelegate {
    func removeMovie(_ flowLayout: MovieStackLayout, indexPath: IndexPath, withLike: Bool) {
        interactor?.saveMovieToDatabase(movieViewModel: (moviesResponseModel?.result?[indexPath.row])!, withLike : withLike)
        moviesResponseModel?.result?.remove(at: indexPath.row)
        collectionView.reloadData()
        if moviesResponseModel?.result?.count == 0
        {
            currentPage += 1
            fetchPopularMovies()
        }
        
        
        print(withLike)
    }
}
