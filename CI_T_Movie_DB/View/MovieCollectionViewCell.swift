import UIKit

class MovieCollectionViewCell: UICollectionViewCell {
    static let reuseIdentifier = String(describing: MovieCollectionViewCell.self)
    
    @IBOutlet weak var posterView: UIImageView?
    @IBOutlet weak var titleLabel: UILabel?
    @IBOutlet weak var genreLabel: UILabel?
    @IBOutlet weak var ratingLabel: UILabel?
    @IBOutlet weak var dateLabel: UILabel?
    
}
