//
//  ViewController.swift
//  Swift Flickr Viewer
//
//  Created by Will Dale on 21/11/2020.
//

import UIKit

class HomeViewController: UIViewController {
    
    typealias DataSource            = UICollectionViewDiffableDataSource<Section, Photo>
    typealias DataSourceSnapshot    = NSDiffableDataSourceSnapshot<Section, Photo>
    
    let search : UISearchController = UISearchController(searchResultsController: nil)
    private var searchQuery : String = ""
    
    private var collectionView  : UICollectionView! = nil
    
    private var datasource  : DataSource!
    private var snapshot    = DataSourceSnapshot()
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureSearch()
        configureCollectionViewLayout()
        configureCollectionViewDataSource()
        
        navigationItem.title = "Home"

    }
}

extension HomeViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let photo = datasource.itemIdentifier(for: indexPath) else { return }
        print(photo)
    }
}


// MARK: - CollectionView
extension HomeViewController {
    enum Section {
        case main
    }
    
    private func createLayout() -> UICollectionViewLayout {
        let itemSize    = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
        let item        = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(400))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])

        let section = NSCollectionLayoutSection(group: group)
        section.interGroupSpacing = 50        
        
        let layout = UICollectionViewCompositionalLayout(section: section)
        
        return layout
    }
    
    private func configureCollectionViewLayout() {
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: createLayout())
        collectionView.delegate = self
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        collectionView.backgroundColor = .systemGroupedBackground
        collectionView.register(PhotoCell.self, forCellWithReuseIdentifier: PhotoCell.reuseIdentifier)
        view.addSubview(collectionView)
    }
    private func configureCollectionViewDataSource() {
        datasource = DataSource(collectionView: collectionView, cellProvider: { (collectionView, indexPath, photo) -> PhotoCell? in
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PhotoCell.reuseIdentifier, for: indexPath) as! PhotoCell
            cell.configure(with: photo)
            return cell
        })
    }
}

extension HomeViewController: UISearchResultsUpdating {
    private func configureSearch() {
        search.searchResultsUpdater = self
        search.obscuresBackgroundDuringPresentation = false
        search.searchBar.placeholder = "Type something here to search"
        navigationItem.searchController = search
    }
    func updateSearchResults(for searchController: UISearchController) {
        guard let text = searchController.searchBar.text else { return }
        searchQuery = text

        fetchPhotos()
    }
}

// MARK: - Networking
extension HomeViewController {
    private func url() -> String {
        let base = "https://www.flickr.com/services/rest/"
        let method = "?method=flickr.photos.search"
        let key = "&api_key=\(API.key)"
        let search = "&text=\(searchQuery)"
        let format = "&format=json&nojsoncallback=1"
        let url = base+method+key+search+format
        return url
    }
    private func fetchPhotos(completion: @escaping (Result<Response, Error>) -> ()) {
        let urlString = url()
        guard let url = URL(string: urlString) else { return }
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                completion(.failure(error))
            }
            do {
                let photos = try JSONDecoder().decode(Response.self, from: data!)
                completion(.success(photos))
            } catch let jsonError {
                completion(.failure(jsonError))
            }
        }.resume()

    }
    private func fetchPhotos() {
        fetchPhotos { (result) in
            switch result {
            case .success(let response):
                self.applySnapshot(photos: response.photos.photo)
            case .failure(let error):
                print("Failed to fetch photos: \(error.localizedDescription)")
            }
        }
    }
    
    private func applySnapshot(photos: [Photo]) {
        snapshot = DataSourceSnapshot()
        snapshot.appendSections([Section.main])
        snapshot.appendItems(photos)
        datasource.apply(snapshot, animatingDifferences: false)
    }
}

