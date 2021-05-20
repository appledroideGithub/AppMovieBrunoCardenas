//
//  HomeView.swift
//  BCAppMovie
//
//  Created by Bruno Cardenas on 07/04/21.
//

import UIKit
import RxSwift
import RxCocoa
import ProgressHUD

class HomeView: BaseViewController {

    private var viewModel = HomeViewModel()
    private var disposeBag = DisposeBag()
    private var router = HomeRouter()
    private var movies = [Movie]()
    @IBOutlet weak var tableView: UITableView!
    var  currentPage = 1
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
        viewModel.bind(view: self, router: router)
        self.getData()
        self.title = "Movies DB"
        navigationItem.hidesBackButton = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    private func configureTableView() {
        tableView.rowHeight = UITableView.automaticDimension
        tableView.register(UINib(nibName: "CustomMovieCell", bundle: nil), forCellReuseIdentifier: "CustomMovieCell")
        tableView.rx.willDisplayCell
            .subscribe(onNext: ({ (cell,indexPath) in
                cell.alpha = 0
                let transform = CATransform3DTranslate(CATransform3DIdentity, -250, 0, 0)
                cell.layer.transform = transform
                UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.5, options: .curveEaseOut, animations: {
                    cell.alpha = 1
                    cell.layer.transform = CATransform3DIdentity
                }, completion: nil)
            })).disposed(by: disposeBag)
    }
    
    private func reloadTableView() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    private func getData() {
        ProgressHUD.show()
        return viewModel.gestListMoviesData(page: currentPage)
            .subscribe(on: MainScheduler.instance)
            .observe(on: MainScheduler.instance)
            .subscribe(
                onNext: { movies in
                    ProgressHUD.dismiss()
                    self.movies.append(contentsOf: movies.listOfMovies)
                    self.reloadTableView()
            }, onError: { error in
                ProgressHUD.dismiss()
                print(error.localizedDescription)
            }, onCompleted: {
            }).disposed(by: disposeBag)
        //Dar por completado la secuencia de RxSwift
    }
}

extension HomeView: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CustomMovieCell") as! CustomMovieCell
        cell.imageMovie.downloadImage(urlImage: "\(Constants.URL.urlImages+self.movies[indexPath.row].image)", placeHolderImage: UIImage(named: "background")!)
        cell.titleMovie.text = movies[indexPath.row].title
        cell.descriptionMovie.text = movies[indexPath.row].sinopsis
        if indexPath.row == movies.count - 1 {
            currentPage += 1
            self.getData()
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
               
        viewModel.makeDetailView(movieID: String(self.movies[indexPath.row].movieID))

    }
}

