//
//  CharacterListViewController.swift
//  RickAndMorty
//
//  Created by Ricardo Ruiz on 12/12/2019.
//  Copyright (c) 2019 Ricardo Ruiz. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit

protocol CharacterListDisplayLogic: class
{
    func displayCharacterList(viewModel: CharacterList.LoadCharacters.ViewModel)
}

class CharacterListViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout, UISearchBarDelegate, CharacterListDisplayLogic
{
    var characterList : [Character] = []
    var filteredCharacters : [Character] = []
    var interactor: CharacterListBusinessLogic?
    var router: (NSObjectProtocol & CharacterListRoutingLogic & CharacterListDataPassing)?
    
    let searchBar = UISearchBar()
    let layout = UICollectionViewFlowLayout()
    
    // MARK: Object lifecycle
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?)
    {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder)
    {
        super.init(coder: aDecoder)
        collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        setup()
    }
    
    // MARK: Setup
    
    private func setup()
    {
        let viewController = self
        let interactor = CharacterListInteractor()
        let presenter = CharacterListPresenter()
        let router = CharacterListRouter()
        
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
    }
    
    // MARK: Routing
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if let scene = segue.identifier {
            let selector = NSSelectorFromString("routeTo\(scene)WithSegue:")
            if let router = router, router.responds(to: selector) {
                router.perform(selector, with: segue)
            }
        }
    }
    
    // MARK: View lifecycle
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        title = "Character List"
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(CharacterCell.self, forCellWithReuseIdentifier: "CharacterCell")
        
        view.backgroundColor = .white
        collectionView.backgroundColor = .white
        
        collectionView.addSubview(searchBar)
        searchBar.delegate = self
        
        searchBar.placeholder = "Search character"
        searchBar.searchTextField.clearButtonMode = .always
        searchBar.returnKeyType = .done
        
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        searchBar.widthAnchor.constraint(equalTo: collectionView.widthAnchor, constant: 0.95).isActive = true
        searchBar.heightAnchor.constraint(equalToConstant: 70).isActive = true
        searchBar.topAnchor.constraint(equalTo: collectionView.safeAreaLayoutGuide.topAnchor).isActive = true
        searchBar.centerXAnchor.constraint(equalTo: collectionView.centerXAnchor).isActive = true
        
        loadCharacterList()
    }
    
    // MARK: Do something
    
    func loadCharacterList()
    {
        let request = CharacterList.LoadCharacters.Request()
        interactor?.loadCharacterList(request: request)
    }
    
    func displayCharacterList(viewModel: CharacterList.LoadCharacters.ViewModel)
    {
        characterList = viewModel.characterListResult
        filteredCharacters = characterList
        collectionView.reloadData()
    }
    
    // MARK: Collectionview delegates
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let character = filteredCharacters[indexPath.row]
        let characterCell = collectionView.dequeueReusableCell(withReuseIdentifier: "CharacterCell", for: indexPath) as? CharacterCell
        
        characterCell!.SetCharacter(character: character)
        
        return characterCell!
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        router?.dataStore?.character = filteredCharacters[indexPath.row]
        router?.routeToCharacterDetails()
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return filteredCharacters.count
    }
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if UIDevice.current.orientation.isLandscape {
            return CGSize(width: UIScreen.main.bounds.size.width / 2 - 20, height: 100)
        } else {
            return CGSize(width: UIScreen.main.bounds.size.width, height: 100)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: 100, height: 100)
    }
    
    override func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        searchBar.resignFirstResponder()
    }
    
    // MARK: Change orientation
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        collectionView.collectionViewLayout.invalidateLayout()
    }
    
    // MARK: Searchbar delegate
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if (searchText == "") {
            filterContentForSearchText(searchText)
            searchBar.resignFirstResponder()
        }
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        filterContentForSearchText(searchBar.searchTextField.text ?? "")
        
        if (searchBar.searchTextField.text ?? "" == "") {
            searchBar.resignFirstResponder()
        }
    }
    
    func filterContentForSearchText(_ searchText: String) {
        filteredCharacters = characterList.filter({ (searchedCharacter) -> Bool in
            return searchedCharacter.name.lowercased().hasPrefix(searchText.lowercased()) || searchText == ""
        })
        
        collectionView.reloadData()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
}
