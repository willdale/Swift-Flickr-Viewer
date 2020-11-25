//
//  SearchViewController.swift
//  Swift Flickr Viewer
//
//  Created by Will Dale on 21/11/2020.
//

import UIKit

class SearchViewController: UIViewController {
    
    // MARK: Type Alias
    typealias DataSource            = UICollectionViewDiffableDataSource<Section, Photo>
    typealias DataSourceSnapshot    = NSDiffableDataSourceSnapshot<Section, Photo>
    
    // MARK: Properties
    let searchController : UISearchController = UISearchController(searchResultsController: nil)
    private var searchQuery : String = ""
    
    private var collectionView  : UICollectionView! = nil
    private var datasource  : DataSource!
    private var snapshot    = DataSourceSnapshot()
        
    // MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureSearch()
        configureCollectionViewLayout()
        configureCollectionViewDataSource()
        
        navigationItem.title = "Search"

    }
}

// MARK: - CollectionView
extension SearchViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let photo = datasource.itemIdentifier(for: indexPath) else { return }
        print(photo)
    }
    
    enum Section {
        case main
    }
    
    private func createLayout() -> UICollectionViewLayout {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 4, leading: 4, bottom: 4, trailing: 4)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(310))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])

        let section = NSCollectionLayoutSection(group: group)
        
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

// MARK: - Search
extension SearchViewController: UISearchResultsUpdating, UISearchBarDelegate {
    private func configureSearch() {
        searchController.searchResultsUpdater = self
        searchController.searchBar.delegate = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Type something here to search"
        navigationItem.searchController = searchController
    }
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let text = searchController.searchBar.text else { return }
        searchQuery = text

        fetchPhotos()
    }
    func updateSearchResults(for searchController: UISearchController) {}
}

// MARK: - Networking
extension SearchViewController {
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

