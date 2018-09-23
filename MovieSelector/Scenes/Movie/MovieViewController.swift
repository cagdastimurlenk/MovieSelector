//
//  MovieViewController.swift
//  MovieSelector
//
//  Created by Cagdas Timurlenk on 21.09.2018.
//  Copyright © 2018 CodeAndDreams. All rights reserved.
//

import UIKit
import AVKit
import AVFoundation


protocol MovieDisplayLogic: class {
    func displayMovieDetail(_ viewModel: MovieDetail.ViewModel)
    
}

class MovieViewController: UIViewController,MovieDisplayLogic {

    var model: MovieList.ViewModel.MovieViewModel?
    
    @IBOutlet weak var btnPlay: UIButton!
    @IBOutlet weak var imgPlay: UIImageView!
    @IBOutlet weak var lblVote: UILabel!
    @IBOutlet weak var txtOverview: UITextView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    static let identifier = "MovieViewController"
    var interactor: MovieBusinessLogic?
    var isTeaserAvailable = false
    
    var movieTrailers : [MovieDetail.ViewModel.MovieDetailViewModel]?
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?)
    {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder)
    {
        super.init(coder: aDecoder)
        setup()
    }
    
    func setup()
    {
        let viewController = self
        let interactor = MovieInteractor()
        let presenter = MoviePresenter()
        
        viewController.interactor = interactor
        interactor.presenter = presenter
        presenter.viewController = viewController
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        fetchMovieDetail()
        // Do any additional setup after loading the view.
    }
    func setupView ()
    {
        imageView.af_cancelImageRequest()
        let placeholderImage = UIImage(named: "moviePlaceHolder.png")
        let urlString = "\(Constants.MovieApiCred.imageBase)\(model?.posterPath ?? "")"
        
        if let url = URL(string: urlString)
        {
            imageView.af_setImage(withURL: url, placeholderImage: placeholderImage)
        }
        else
        {
            imageView.image = placeholderImage
        }
        
        lblTitle.text = model?.title
        lblVote.text = "\(model?.releaseDate ?? "") - \(model?.voteAverage ?? 0.0)"
        txtOverview.text = model?.overview
        imgPlay.isHidden = true
        btnPlay.isEnabled = false
        
    }
    
    func fetchMovieDetail()
    {
        let request = MovieDetail.Request(movieId: model?.movieId)
        interactor?.getMovieDetail(request)
    }
    
    func displayMovieDetail(_ viewModel: MovieDetail.ViewModel) {
         movieTrailers = viewModel.movieView.result?.filter { data in
            return data.site == "YouTube"
        }
        
        if let movieTrailers = movieTrailers , movieTrailers.count > 0
        {
            self.imgPlay.isHidden = false
            btnPlay.isEnabled = true
        }
    }

    @IBAction func teaserClick(_ sender: Any) {
        //because youtube url and avplayer dont work nicely, open from browser.
        guard let url = URL(string: "https://www.youtube.com/watch?v=\(movieTrailers![0].key)") else {
            return
        }
        
        if #available(iOS 10.0, *) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        } else {
            UIApplication.shared.openURL(url)
        }
        
//        let player = AVPlayer(url: videoURL!)
//        let playerViewController = AVPlayerViewController()
//        playerViewController.player = player
//        self.present(playerViewController, animated: true) {
//            playerViewController.player!.play()
//        }
        
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
