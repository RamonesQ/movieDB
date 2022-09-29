import UIKit
import Kingfisher
import Combine
import Resolver

class CastTableViewController: UITableViewController {
    
    @Injected var castViewModel: CastViewModel
    @Injected var movieService: MovieAPIService
    var id: Int?
    var movieCredits: CastData?
    private var subscribers = Set<AnyCancellable>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        observeViewModel()
        fetchCast()
    }
    
    private func fetchCast() {
        castViewModel.fetchCast(id: id ?? 0)
    }
    
    private func observeViewModel() {
        castViewModel.castSubject.sink(receiveCompletion: { (resultCompletion) in
            switch resultCompletion {
            case .failure(let error):
                print(error.localizedDescription)
            default: break
            }
        }) { (result) in
            DispatchQueue.main.async {
                self.movieCredits = result
                self.tableView.reloadData()
            }
        }.store(in: &subscribers)
    }
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movieCredits?.cast.count ?? 0
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CastCell", for: indexPath) as! CastTableViewCell
        let actor = movieCredits?.cast[indexPath.row]
        cell.characterNameLabel?.text = actor?.character
        cell.actorNameLabel?.text = actor?.name
        let photo = URL(string:"\(movieService.imageUrl)\(movieService.lowImageEndpopint)\(actor?.profilePath ?? "")")
        cell.actorPhoto?.kf.setImage(with: photo)
        cell.actorPhoto?.layer.cornerRadius = 25
        cell.actorPhoto?.contentMode = .scaleAspectFill
        return cell
    }
}
