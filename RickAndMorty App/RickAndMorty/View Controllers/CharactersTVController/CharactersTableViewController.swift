//
//  CharactersTableViewController.swift
//  RickAndMorty
//
//  Created by Andrii Stetsenko on 04.12.2022.
//

import UIKit

class CharactersTableViewController: UITableViewController {
    
    // MARK: - Properties
    var networkRickAndMortyManager = NetworkRickAndMortyManager()
    var rickAndMortyData: RickAndMortyData?
    var currentCharacter: Int = 0
    
    var isFilterMenuNameActive: Bool = false
    var isFilterMenuAliveActive: Bool = false
    var isFilterMenuDeadActive: Bool = false
    var isFilterMenuUnknownStatusActive: Bool = false
    var isFilterMenuAlienSpeciesActive: Bool = false
    var isFilterMenuHumanSpeciesActive: Bool = false
    var isFilterMenuFemaleActive: Bool = false
    var isFilterMenuMaleActive: Bool = false
    var isFilterMenuUnknownGenderActive: Bool = false
    var isFavoriteMenuActive: Bool = false
    
    var results: [Result] = []
    var filteredResults: [Result] = []
    var favoriteResults: [Result] = []
    
    let searchController = UISearchController(searchResultsController: nil)
    var searchBarIsEmpty: Bool {
        guard let text = searchController.searchBar.text else { return false }
        return text.isEmpty
    }
    var isFiltering: Bool {
        return searchController.isActive && !searchBarIsEmpty
    }
    
    let identifierCell = "CharactersCell"
    let segueDetailsIdentifier = "ShowDetailsVC"
    
    
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Setup the Search Controller
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search"
        navigationItem.searchController = searchController
        definesPresentationContext = true
        
        loadRickAndMortyData()
        navigationItemMenu()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.tableView.reloadData()
    }
    
    
    // MARK: - Private functions
    private func loadRickAndMortyData() {
        networkRickAndMortyManager.onCompletionRickAndMortyComicsData = { [weak self] rickAndMortyData in
            guard let self = self else { return }
            DispatchQueue.main.async {
                self.rickAndMortyData = rickAndMortyData
                self.results.append(contentsOf: rickAndMortyData.results)
                self.tableView.reloadData()
            }
        }
        networkRickAndMortyManager.getData()
    }
    
    private func navigationItemMenu() {
        let nameItem = UIAction(title: "name") { (_) in
            print("filtering by name")
            
            if self.isFilterMenuNameActive {
                self.isFilterMenuNameActive = false
                print("filterMenuNameActive - false")
                
                self.tableView.reloadData()
            } else {
                self.isFilterMenuNameActive = true
                print("filterMenuNameActive - true")
                
                self.filteredResults = self.results.sorted { $0.name < $1.name }
                self.tableView.reloadData()
            }
        }
        
        let aliveItem = UIAction(title: "alive") { (_) in
            print("filtering by alive Status")
            
            if self.isFilterMenuAliveActive {
                self.isFilterMenuAliveActive = false
                print("isFilterMenuAliveActive - false")
                
                self.tableView.reloadData()
            } else {
                self.isFilterMenuAliveActive = true
                print("isFilterMenuAliveActive - true")
                
                self.filteredResults = self.results.filter { $0.status.rawValue == "Alive" }
                self.tableView.reloadData()
            }
        }
        
        let deadItem = UIAction(title: "dead") { (_) in
            print("filtering by dead Status")
            
            if self.isFilterMenuDeadActive {
                self.isFilterMenuDeadActive = false
                print("isFilterMenuDeadActive - false")
                
                self.tableView.reloadData()
            } else {
                self.isFilterMenuDeadActive = true
                print("isFilterMenuDeadActive - true")
                
                self.filteredResults = self.results.filter { $0.status.rawValue == "Dead" }
                self.tableView.reloadData()
            }
        }
        
        let unknownStatusItem = UIAction(title: "unknown") { (_) in
            print("filtering by unknownStatus")
            
            if self.isFilterMenuUnknownStatusActive {
                self.isFilterMenuUnknownStatusActive = false
                print("isFilterMenuUnknownStatusActive - false")
                
                self.tableView.reloadData()
            } else {
                self.isFilterMenuUnknownStatusActive = true
                print("isFilterMenuUnknownStatusActive - true")
                
                self.filteredResults = self.results.filter { $0.status.rawValue == "unknown" }
                self.tableView.reloadData()
            }
        }
        
        let alienItem = UIAction(title: "alien") { (_) in
            print("filtering by alienSpecies")
            
            if self.isFilterMenuAlienSpeciesActive {
                self.isFilterMenuAlienSpeciesActive = false
                print("isFilterMenuAlienSpeciesActive - false")
                
                self.tableView.reloadData()
            } else {
                self.isFilterMenuAlienSpeciesActive = true
                print("isFilterMenuAlienSpeciesActive - true")
                
                self.filteredResults = self.results.filter { $0.species.rawValue == "Alien" }
                self.tableView.reloadData()
            }
        }
        
        let humanItem = UIAction(title: "human") { (_) in
            print("filtering by humanSpecies")
            
            if self.isFilterMenuHumanSpeciesActive {
                self.isFilterMenuHumanSpeciesActive = false
                print("isFilterMenuHumanSpeciesActive - false")
                
                self.tableView.reloadData()
            } else {
                self.isFilterMenuHumanSpeciesActive = true
                print("isFilterMenuHumanSpeciesActive - true")
                
                self.filteredResults = self.results.filter { $0.species.rawValue == "Human" }
                self.tableView.reloadData()
            }
        }
        
        let femaleItem = UIAction(title: "female") { (_) in
            print("filtering by femaleGender")
            
            if self.isFilterMenuFemaleActive {
                self.isFilterMenuFemaleActive = false
                print("isFilterMenuFemaleActive - false")
                
                self.tableView.reloadData()
            } else {
                self.isFilterMenuFemaleActive = true
                print("isFilterMenuFemaleActive - true")
                
                self.filteredResults = self.results.filter { $0.gender.rawValue == "Female" }
                self.tableView.reloadData()
            }
        }
        
        let maleItem = UIAction(title: "male") { (_) in
            print("filtering by maleGender")
            
            if self.isFilterMenuMaleActive {
                self.isFilterMenuMaleActive = false
                print("isFilterMenuMaleActive - false")
                
                self.tableView.reloadData()
            } else {
                self.isFilterMenuMaleActive = true
                print("isFilterMenuMaleActive - true")
                
                self.filteredResults = self.results.filter { $0.gender.rawValue == "Male" }
                self.tableView.reloadData()
            }
        }
        
        let unknownGenderItem = UIAction(title: "unknown") { (_) in
            print("filtering by unknownGender")
            
            if self.isFilterMenuUnknownGenderActive {
                self.isFilterMenuUnknownGenderActive = false
                print("isFilterMenuUnknownGenderActive - false")
                
                self.tableView.reloadData()
            } else {
                self.isFilterMenuUnknownGenderActive = true
                print("isFilterMenuUnknownGenderActive - true")
                
                self.filteredResults = self.results.filter { $0.gender.rawValue == "unknown" }
                self.tableView.reloadData()
            }
        }
        
        let favoriteItem = UIAction(title: "Favorite", image: UIImage(systemName: "heart")) { (_) in
            print("filtering by Favorite!!!")
            
            if self.isFavoriteMenuActive {
                self.isFavoriteMenuActive = false
                print("isFavoriteMenuActive - false")
                
                self.tableView.reloadData()
            } else {
                self.isFavoriteMenuActive = true
                print("isFavoriteMenuActive - true")
                
                self.favoriteResults = self.results.filter { Favorites.shared.isFavorite($0) }
                self.tableView.reloadData()
            }
        }
        
        var submenuStatus: UIMenu {
            return UIMenu(title: "status", image: UIImage(systemName: "ellipsis"), children: [aliveItem, deadItem, unknownStatusItem])
        }
        
        var submenuSpecies: UIMenu {
            return UIMenu(title: "species", image: UIImage(systemName: "ellipsis"), children: [alienItem, humanItem])
        }
        
        var submenuGender: UIMenu {
            return UIMenu(title: "gender", image: UIImage(systemName: "ellipsis"), children: [femaleItem, maleItem, unknownGenderItem])
        }
        
        var menu: UIMenu {
            return UIMenu(title: "Sort by", options: [.singleSelection], children: [nameItem, submenuStatus, submenuSpecies, submenuGender, favoriteItem])
        }
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Sort", primaryAction: nil, menu: menu)
    }
    
    
    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isFiltering {
            return filteredResults.count
        }
        
        if isFilterMenuNameActive || isFilterMenuAliveActive || isFilterMenuDeadActive || isFilterMenuUnknownStatusActive
            || isFilterMenuAlienSpeciesActive || isFilterMenuHumanSpeciesActive || isFilterMenuFemaleActive || isFilterMenuMaleActive
            || isFilterMenuUnknownGenderActive {
            return filteredResults.count
        }
        
        if isFavoriteMenuActive {
            return favoriteResults.count
        }
        
        return results.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: identifierCell, for: indexPath) as? CharactersTableViewCell {
            if isFiltering || isFilterMenuNameActive || isFilterMenuAliveActive || isFilterMenuDeadActive
                || isFilterMenuUnknownStatusActive || isFilterMenuAlienSpeciesActive || isFilterMenuHumanSpeciesActive
                || isFilterMenuFemaleActive || isFilterMenuMaleActive || isFilterMenuUnknownGenderActive {
                let filteredResultsItem = filteredResults[indexPath.row]
                let urlString = filteredResultsItem.image
                
                cell.configure(with: filteredResultsItem, url: urlString, favoriteStatus: Favorites.shared.isFavorite(filteredResultsItem))
                
                return cell
            } else if isFavoriteMenuActive {
                let favoriteItem = favoriteResults[indexPath.row]
                let urlString = favoriteItem.image
                
                cell.configure(with: favoriteItem, url: urlString, favoriteStatus: Favorites.shared.isFavorite(favoriteItem))
                
                return cell
            } else {
                let resultsItem = results[indexPath.row]
                let urlString = resultsItem.image
                
                cell.configure(with: resultsItem, url: urlString, favoriteStatus: Favorites.shared.isFavorite(resultsItem))
                
                return cell
            }
        }
        return UITableViewCell()
    }
    
    // MARK: - UITableViewDelegate
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 156
    }
    
    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 10.0
    }
    
    override func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }
    
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == segueDetailsIdentifier {
            if let indexPath = tableView.indexPathForSelectedRow {
                if isFiltering || isFilterMenuNameActive || isFilterMenuAliveActive || isFilterMenuDeadActive
                    || isFilterMenuUnknownStatusActive || isFilterMenuAlienSpeciesActive || isFilterMenuHumanSpeciesActive
                    || isFilterMenuFemaleActive || isFilterMenuMaleActive || isFilterMenuUnknownGenderActive {
                    let filteredResultsItem = filteredResults[indexPath.row]
                    self.currentCharacter = filteredResultsItem.id - 1
                } else if isFavoriteMenuActive {
                    let favoriteItem = favoriteResults[indexPath.row]
                    self.currentCharacter = favoriteItem.id - 1
                } else {
                    let resultsItem = results[indexPath.row]
                    self.currentCharacter = resultsItem.id - 1
                }
                
                let detailVC = segue.destination as! DetailsViewController
                detailVC.title = "Character details"
                detailVC.currentCharacter = self.currentCharacter
                detailVC.rickAndMortyData = self.rickAndMortyData
                detailVC.favoriteStatus = self.isFavoriteMenuActive
            }
        }
    }
    
}


// MARK: - UISearchResultsUpdating Delegate
extension CharactersTableViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        //filterContentForSearchText(searchController.searchBar.text!)
        filterSortByName(searchController.searchBar.text!)
    }
    
    private func filterContentForSearchText(_ searchText: String) {
        filteredResults = results.filter({ (result: Result) -> Bool in
            return result.name.lowercased().contains(searchText.lowercased())
        })
        
        tableView.reloadData()
    }
    
    private func filterSortByName(_ searchText: String) {
        //filteredResults = results.sorted { $0.name < $1.name }
        filteredResults = results.filter { $0.name.lowercased().hasPrefix(searchText.lowercased()) }
        
        tableView.reloadData()
    }
}

