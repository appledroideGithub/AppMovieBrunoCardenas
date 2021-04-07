//
//  DetailView.swift
//  TheMoviesApp
//
// Created by Bruno Cardenas on 07/04/21.
//

import UIKit
import RxSwift

class DetailView: BaseViewController {
    
    @IBOutlet private weak var titleHeader: UILabel!
    @IBOutlet private weak var imageFilm: UIImageView!
    @IBOutlet private weak var descriptionMovie: UILabel!
    @IBOutlet private weak var releaseDate: UILabel!
    @IBOutlet private weak var originalTitle: UILabel!
    @IBOutlet private weak var voteAverage: UILabel!
    
    private var router = DetailRouter()
    private var viewModel = DetailViewModel()
    private var disposeBag = DisposeBag()
    var movieID: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getDataAndShowDetailMove()
        viewModel.bind(view: self, router: router)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    private func getDataAndShowDetailMove() {
        guard let idMovie = movieID else { return }
        return viewModel.getMovieData(movieID: idMovie).subscribe(
            onNext: { movie in
                self.showMovieData(movie: movie)
        },
            onError: { error in
                print("Ha ocurrido un error: \(error)")
        },
            onCompleted: {
        }).disposed(by: disposeBag)
    }
    
    private func getImageMovie(movie: MovieDetail) {
        return viewModel.getImageMovie(urlString: Constants.URL.urlImages+movie.posterPath)
            .subscribe(
                onNext: { image in
                    DispatchQueue.main.sync {
                        self.imageFilm.image = image
                    }
            },
                onError: { error in
                    print(error.localizedDescription)
            },
                onCompleted: {
            }).disposed(by: disposeBag)
    }
    
    func showMovieData(movie: MovieDetail) {
        DispatchQueue.main.async {
            self.titleHeader.text = movie.title
            self.descriptionMovie.text = movie.overview
            self.releaseDate.text = movie.releaseDate
            self.originalTitle.text = movie.originalTitle
            self.voteAverage.text = String(movie.voteAverage)
            self.getImageMovie(movie: movie)
        }
    }
}
