//
//  ViewController.swift
//  trying layout
//
//  Created by Ramon Queiroz dos Santos on 13/07/22.
//

import UIKit
import Kingfisher
import Combine
import Resolver

class HomeViewController: UIViewController {
    
    @Injected var movieService: MovieAPIService
    @Injected var homeViewModel: HomeViewModel
    private var subscribers = Set<AnyCancellable>()
    var selectedMovieId: Int?
    var genresList: GenreList?
    var nowPlaying: MovieResponse?
    var commingSoon: MovieResponse?
    var selectedSegment: Int?
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var segmented: UISegmentedControl!
    @IBAction func active(_ sender: UISegmentedControl) {
        selectedSegment = sender.selectedSegmentIndex
        collectionView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        observeHomeViewModel()
        fetchGenre()
        fetchNowPlayingMovie()
        fetchUpcommingMovie()
        collectionView.collectionViewLayout = configureLayout()

    }
    
    private func observeHomeViewModel(){
        homeViewModel.genreSubject.sink(receiveCompletion: {
            (resultCompletion) in
            switch resultCompletion {
            case .failure(let error):
                print(error.localizedDescription)
            default: break
            }
        }) { (result) in
            DispatchQueue.main.async {
                self.genresList = result
            }
        }.store(in: &subscribers)
        
        homeViewModel.movieSubject.sink(receiveCompletion: {
            (resultCompletion) in
            switch resultCompletion {
            case .failure(let error):
                print(error.localizedDescription)
            default: break
            }
        }) { (result) in
            DispatchQueue.main.async {
                self.nowPlaying = result
            }
        }.store(in: &subscribers)
        
        homeViewModel.movieCommingSubject.sink(receiveCompletion: {
            (resultCompletion) in
            switch resultCompletion {
            case .failure(let error):
                print(error.localizedDescription)
            default: break
            }
        }) { (result) in
            DispatchQueue.main.async {
                self.commingSoon = result
            }
        }.store(in: &subscribers)
    }
    private func fetchGenre(){
        homeViewModel.fetchGenre()
   }
    private func fetchNowPlayingMovie(){
        homeViewModel.fetchNowMovie()
   }
    private func fetchUpcommingMovie(){
        homeViewModel.fetchUpcommingMovie()
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destinationViewController = segue.destination as? DetailsViewController,
           segue.identifier == "DetailsSegue"{
            destinationViewController.id = selectedMovieId!
        }
    }
}

// MARK: - Layout -
extension HomeViewController: UICollectionViewDelegate {
    
    func configureLayout() -> UICollectionViewCompositionalLayout {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.5), heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 5)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalWidth(0.8))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        
        return UICollectionViewCompositionalLayout(section: section)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch segmented.selectedSegmentIndex {
        case 1 :
            selectedMovieId = commingSoon?.results[indexPath.row].id
            performSegue(withIdentifier: "DetailsSegue", sender: self)
        default:
            selectedMovieId = nowPlaying?.results[indexPath.row].id
            performSegue(withIdentifier: "DetailsSegue", sender: self)
        }
    }
}

// MARK: - DataSource -

extension HomeViewController: UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int{
        switch segmented.selectedSegmentIndex {
        case 1 : return commingSoon?.results.count ?? 0
        default: return nowPlaying?.results.count ?? 0
        }
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MovieCollectionViewCell.reuseIdentifier, for: indexPath) as! MovieCollectionViewCell
        let movieData = selectedSegment == 0 ? nowPlaying?.results : commingSoon?.results
        let movieItem = movieData?[indexPath.row]
        
        cell.titleLabel?.text = movieItem?.title
//        // move to VM
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let date = dateFormatter.date(from: movieItem!.releaseDate)
        dateFormatter.dateFormat = "dd-MM-yyyy"
        cell.dateLabel?.text = dateFormatter.string(from: date!)
        cell.ratingLabel?.text = "\(String(describing: movieItem!.voteAverage))"
        let poster = URL(string: "\(movieService.imageUrl)\(movieService.regularImageEndpoint)\(movieItem?.posterPath ?? "")")
        KF.url(poster).set(to: cell.posterView!)
       // cell.genreLabel?.text = "\(String(describing: movieItem!.genreIDS[0]))"
        return cell
    }

}
