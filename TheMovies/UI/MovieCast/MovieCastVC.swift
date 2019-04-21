//
//  MovieCastVC.swift
//  TheMovies
//
//  Created by Yogesh Pareek on 21/04/19.
//  Copyright © 2019 Yogesh Pareek. All rights reserved.
//

import UIKit

class MovieCastVC: UIViewController {
    
    lazy var tvCast: UITableView = {
        let tv = UITableView(frame: view.bounds)
        tv.dataSource = self
        tv.delegate = self
        tv.translatesAutoresizingMaskIntoConstraints = false
        return tv
    }()
    
    let tvSectionAttrs: [NSAttributedString.Key: Any] = [
        NSAttributedString.Key.font: UIFont.themeMediumFont(of: 18)
    ]

    public var movieViewModel: MovieDetailViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = movieViewModel.movieDetail.title
        setUI()
    }
    
    func setUI() {
        self.view.addSubview(tvCast)
        NSLayoutConstraint.activate([
            tvCast.topAnchor.constraint(equalTo: self.view.topAnchor),
            tvCast.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            tvCast.leftAnchor.constraint(equalTo: self.view.leftAnchor),
            tvCast.rightAnchor.constraint(equalTo: self.view.rightAnchor)
            ])
        
        tvCast.register(UINib(nibName: "UIMovieCastTVCell", bundle: nil), forCellReuseIdentifier: "MovieCastTVCell")
        tvCast.rowHeight = UITableView.automaticDimension
        tvCast.estimatedRowHeight = 48
    }
    
}

extension MovieCastVC: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return movieViewModel.castCount
        }
        return movieViewModel.crewCount
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 50))
        
        let label = UILabel(frame: CGRect(x: 20, y: 0, width: UIScreen.main.bounds.width - 40, height: 50))
        view.addSubview(label)
        label.font = UIFont.themeMediumFont(of: 22)
        label.textColor = UIColor.black
        
        label.text = section == 0 ? "Cast" : "Crew"
        
        view.backgroundColor = UIColor.white
        
        return view
    }
        
//    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
//        if section == 0 {
//            return "Cast"
//        }
//        return "Crew"
//    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieCastTVCell", for: indexPath) as! MovieCastTVCell
        if indexPath.section == 0 {
            cell.configure(cast: movieViewModel.cast(at: indexPath))
        } else {
           cell.configure(crew: movieViewModel.crew(at: indexPath))
        }
        return cell
    }
    
}
