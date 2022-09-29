//
//  DetailsViewController.swift
//  CI&T Movie Database
//
//  Created by Ramon Queiroz dos Santos on 25/07/22.
//

import UIKit
import Kingfisher
import Combine
import Resolver

class DetailsViewController: UIViewController {
	
	@Injected var movieService: MovieAPIService
	@Injected var DetailsVM: DetailsViewModel
	private var subscribers = Set<AnyCancellable>()
	var id: Int?
	private var movieImages: MovieImages?
	private var movieDetailsObj: DetailsObject?
	var synopsisTextInitialHeight: CGFloat = 0
	
	@IBOutlet weak var SynopsisTextViewheight: NSLayoutConstraint!{
		didSet{
			synopsisTextInitialHeight = SynopsisTextViewheight.constant
		}
	}
	@IBOutlet weak var collectionView: UICollectionView?
	@IBOutlet weak var bannerPhoto: UIImageView?
	@IBOutlet weak var titleLabel: UILabel?
	@IBOutlet weak var ratingLabel: UILabel?
	@IBOutlet weak var genreLabel: UILabel?
	@IBOutlet weak var durationLabel: UILabel?
	@IBOutlet weak var contentView: UIView?
	@IBOutlet weak var showMoreButton: UIButton?
	@IBOutlet weak var synopsisTextView: UITextView?
	
	override func viewDidLoad() {
		super.viewDidLoad()
		observeDetailsViewModel()
		fetchImages()
		fetchMovieDetails()
	}
	
	@IBAction func unwind( _ seg: UIStoryboardSegue) {
	}
	@IBAction func showMoreButtonClicked(_ sender: UIButton) {
		if sender.tag == 0{
			synopsisTextView?.sizeToFit()
			SynopsisTextViewheight.constant = synopsisTextView?.contentSize.height ?? 0
			contentView?.layoutIfNeeded()
			showMoreButton?.setTitle("Show Less", for: .normal)
			sender.tag = 1
		}
		else{
			SynopsisTextViewheight.constant = synopsisTextInitialHeight
			contentView?.layoutIfNeeded()
			showMoreButton?.setTitle("Show More", for: .normal)
		}
	}
	
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		if let destinationViewController = segue.destination.children.first as? PhotoViewController,
			segue.identifier == "PhotosSegue"{
			destinationViewController.id = movieDetailsObj?.id
		}
		if let CastViewController = segue.destination.children.first as? CastTableViewController,
			segue.identifier == "CastSegue"{
			CastViewController.id = movieDetailsObj?.id
		}
	}
	
	private func observeDetailsViewModel(){
		DetailsVM.detailsSubject.sink(receiveCompletion: { (resultCompletion) in
			switch resultCompletion {
			case .failure(let error):
				print(error.localizedDescription)
			default: break
			}
		}) { (data) in
			DispatchQueue.main.async {
				self.movieDetailsObj = data
				self.setupInterface()
			}
		}.store(in: &subscribers)
		
		DetailsVM.photosSubject.sink(receiveCompletion: { (resultCompletion) in
			switch resultCompletion {
			case .failure(let error):
				print(error)
			default: break
			}
		}) { (data) in
			DispatchQueue.main.async {
				self.movieImages = data
				self.collectionView?.reloadData()
			}
		}.store(in: &subscribers)
	}
	private func fetchMovieDetails(){
		DetailsVM.fetchMovieDetails(id: id ?? 0 )
	}
	private func fetchImages(){
		DetailsVM.fetchPhotos(id: id ?? 0 )
	}
	
	private func setupInterface() {
		bannerPhoto?.kf.setImage(with: URL(string: "\(movieService.imageUrl)\(movieService.regularImageEndpoint)\(movieDetailsObj?.backdropPath ?? "")"))
		titleLabel?.text = movieDetailsObj?.originalTitle
		synopsisTextView?.text = movieDetailsObj?.overview
		ratingLabel?.text = movieDetailsObj?.voteAverage
		durationLabel?.text = movieDetailsObj?.runtime
		genreLabel!.text = movieDetailsObj?.genres
	}
}

// MARK: - Data Source -

extension DetailsViewController: UICollectionViewDataSource{
	
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int{
		return movieImages?.backdrops.count ?? 0
	}
	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DetailsPhotoTableCollectionViewCell.reuseIdentifier, for: indexPath) as! DetailsPhotoTableCollectionViewCell
		let moviePhotos = movieImages?.backdrops[indexPath.row]
		let poster = URL(string: "\(movieService.imageUrl)\(movieService.regularImageEndpoint)\(moviePhotos?.filePath ?? "")")
		KF.url(poster).set(to: cell.photoView!)
		return cell
	}
}




