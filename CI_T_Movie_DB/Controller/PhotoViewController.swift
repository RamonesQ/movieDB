//
//  PhotoViewController.swift
//  CI&T Movie Database
//
//  Created by Ramon Queiroz dos Santos on 22/07/22.
//

import UIKit
import Kingfisher
import Combine
import Resolver

class PhotoViewController: UITableViewController {
    
    @Injected var movieService: MovieAPIService
    @Injected var photoViewModel: PhotoViewModel
    var id: Int?
    var movieImages: MovieImages?
    private var subscribers = Set<AnyCancellable>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        observeViewModel()
        fetchPhotos()
    }
    
    private func fetchPhotos() {
        photoViewModel.fetchPhotos(id: id ?? 0)
    }
    private func observeViewModel() {
        photoViewModel.photosSubject.sink(receiveCompletion: { (resultCompletion) in
            switch resultCompletion {
            case .failure(let error):
                print(error.localizedDescription)
            default: break
            }
        }) { (result) in
            DispatchQueue.main.async {
                self.movieImages = result
                self.tableView.reloadData()
            }
        }.store(in: &subscribers)
    }
    
    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movieImages?.backdrops.count ?? 0
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PhotosCell", for: indexPath) as! PhotoCellTableViewCell
        let moviePhotos = movieImages?.backdrops[indexPath.row]
        let poster = URL(string: "\(movieService.imageUrl)\(movieService.regularImageEndpoint)\(moviePhotos?.filePath ?? "")")
        cell.photoImageView?.kf.setImage(with: poster)
        return cell
    }
}
